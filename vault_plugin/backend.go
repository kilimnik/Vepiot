package auth

import (
	"bytes"
	"context"
	_ "embed"
	"encoding/json"
	"fmt"
	"net/http"
	"sort"
	"strings"
	"time"

	firebase "firebase.google.com/go"
	"firebase.google.com/go/messaging"
	"github.com/bufbuild/connect-go"
	"github.com/google/uuid"
	"github.com/hashicorp/vault/sdk/framework"
	"github.com/hashicorp/vault/sdk/helper/policyutil"
	"github.com/hashicorp/vault/sdk/logical"
	api_v1 "github.com/kilimnik/vepiot/vault_plugin/gen/api/v1"
	"github.com/kilimnik/vepiot/vault_plugin/gen/api/v1/v1connect"
	"github.com/mdp/qrterminal/v3"
	"github.com/pquerna/otp/totp"
	"google.golang.org/api/option"
)

//go:embed firebase_key.json
var FirebaseKey []byte

type User struct {
	Secret string
}

type Auth struct {
	Policies []string
	Users    map[string]*User
}

// backend wraps the backend framework and adds a map for storing key value pairs.
type backend struct {
	*framework.Backend

	auths map[string]*Auth
}

var _ logical.Factory = Factory

// Factory configures and returns Mock backends
func Factory(ctx context.Context, conf *logical.BackendConfig) (logical.Backend, error) {
	b, err := newBackend()
	if err != nil {
		return nil, err
	}

	if conf == nil {
		return nil, fmt.Errorf("configuration passed into backend is nil")
	}

	if err := b.Setup(ctx, conf); err != nil {
		return nil, err
	}

	return b, nil
}

func newBackend() (*backend, error) {
	b := &backend{
		auths: make(map[string]*Auth),
	}

	b.Backend = &framework.Backend{
		Help:        strings.TrimSpace(pluginHelp),
		BackendType: logical.TypeCredential,
		PathsSpecial: &logical.Paths{
			Unauthenticated: []string{
				"login",
			},
		},
		Paths: framework.PathAppend(
			[]*framework.Path{
				b.pathLogin(),
				b.pathAuthsList(),
			},
			b.pathAuths(),
		),
	}

	return b, nil
}

func (b *backend) pathLogin() *framework.Path {
	return &framework.Path{
		Pattern: "login$",
		Fields: map[string]*framework.FieldSchema{
			"name": {
				Required:    true,
				Type:        framework.TypeString,
				Description: "Auth name to login",
			},
		},
		Operations: map[logical.Operation]framework.OperationHandler{
			logical.UpdateOperation: &framework.PathOperation{
				Callback: b.handleLogin,
				Summary:  "Log in using auth method",
			},
		},
	}
}

func (b *backend) handleLogin(ctx context.Context, req *logical.Request, data *framework.FieldData) (*logical.Response, error) {
	name := data.Get("name").(string)
	if name == "" {
		return logical.ErrorResponse("name must be provided"), nil
	}

	auth, ok := b.auths[name]
	if !ok {
		return nil, logical.ErrPermissionDenied
	}

	opts := []option.ClientOption{
		option.WithCredentialsJSON(FirebaseKey),
	}
	app, err := firebase.NewApp(context.Background(), nil, opts...)
	if err != nil {
		return logical.ErrorResponse("error in initializing firebase app: %s", err.Error()), err
	}

	messageingClient, err := app.Messaging(ctx)
	if err != nil {
		return logical.ErrorResponse("error getting Messaging client: %v\n", err.Error()), err
	}

	id := (uuid.New()).String()

	proto := &api_v1.TOTPRequest{
		Type: api_v1.TOTPRequestType_TOTP_REQUEST_TYPE_REQUEST,
		Id:   id,
		Name: name,
	}

	logialErr, err := SendFirebaseMessage(
		ctx,
		proto,
		auth,
		messageingClient,
	)
	if err != nil {
		return logialErr, err
	}

	defer SendCancelMessage(context.Background(), auth, messageingClient, id, name)

	response, err := RetrieveTOTPLoop(ctx, id)
	if err != nil {
		return logical.ErrorResponse("retrieve totp failed %s", err.Error()), err
	}

	user := auth.Users[response.GetResponse().GetDeviceId()]
	if !totp.Validate(response.GetResponse().GetTotpCode(), user.Secret) {
		return nil, logical.ErrPermissionDenied
	}

	if response.GetResponse().GetType() != api_v1.TOTPResponseType_TOTP_RESPONSE_TYPE_ALLOW {
		return nil, logical.ErrPermissionDenied
	}

	proto = &api_v1.TOTPRequest{
		Type: api_v1.TOTPRequestType_TOTP_REQUEST_TYPE_RESPONSE,
		Id:   id,
		Name: name,
	}

	logialErr, err = SendFirebaseMessage(
		ctx,
		proto,
		auth,
		messageingClient,
	)
	if err != nil {
		return logialErr, err
	}

	// Compose the response
	resp := &logical.Response{
		Auth: &logical.Auth{
			InternalData: map[string]interface{}{
				"totp": response.GetResponse().GetTotpCode(),
			},
			// Policies can be passed in as a parameter to the request
			Policies: auth.Policies,
			Metadata: map[string]string{
				"name": name,
				"user": response.GetResponse().GetDeviceId(),
			},
			// Lease options can be passed in as parameters to the request
			LeaseOptions: logical.LeaseOptions{
				TTL:       30 * time.Second,
				MaxTTL:    15 * time.Minute,
				Renewable: false,
			},
		},
	}

	return resp, nil
}

func SendCancelMessage(
	ctx context.Context,
	auth *Auth,
	messageingClient *messaging.Client,
	id string,
	name string,
) (*logical.Response, error) {
	proto := &api_v1.TOTPRequest{
		Type: api_v1.TOTPRequestType_TOTP_REQUEST_TYPE_CANCEL,
		Id:   id,
		Name: name,
	}

	logialErr, err := SendFirebaseMessage(
		ctx,
		proto,
		auth,
		messageingClient,
	)

	return logialErr, err
}

func SendFirebaseMessage(
	ctx context.Context,
	proto *api_v1.TOTPRequest,
	auth *Auth,
	messageingClient *messaging.Client,
) (*logical.Response, error) {
	protoJson, err := json.Marshal(proto)
	if err != nil {
		return logical.ErrorResponse("failed to marshal proto %s", err.Error()), err
	}

	keys := make([]string, 0, len(auth.Users))
	for k := range auth.Users {
		keys = append(keys, k)
	}

	msg := &messaging.MulticastMessage{
		Data: map[string]string{
			"proto": string(protoJson),
		},
		Tokens: keys,
	}

	_, err = messageingClient.SendMulticast(ctx, msg)
	if err != nil {
		return logical.ErrorResponse("failed to send message to clients %s", err.Error()), err
	}

	return nil, nil
}

func RetrieveTOTPLoop(
	ctx context.Context,
	id string,
) (*api_v1.GetTOTPResponse, error) {
	client := v1connect.NewServiceClient(http.DefaultClient, "http://127.0.0.1:8080")

	for {
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		default:
			if resp, err := RetrieveTOTP(ctx, client, id); err == nil {
				return resp, nil
			} else if connect.CodeOf(err) != connect.CodeNotFound {
				return nil, err
			}
			time.Sleep(1 * time.Second)
		}
	}
}

func RetrieveTOTP(
	ctx context.Context,
	client v1connect.ServiceClient,
	id string,
) (*api_v1.GetTOTPResponse, error) {
	res, err := client.GetTOTP(
		ctx,
		connect.NewRequest(&api_v1.GetTOTPRequest{Id: id}),
	)
	if err != nil {
		return nil, err
	}

	return res.Msg, nil
}

func (b *backend) pathAuths() []*framework.Path {
	return []*framework.Path{
		{
			Pattern: "auths/" + framework.GenericNameRegex("name"),

			Fields: map[string]*framework.FieldSchema{
				"name": {
					Required:    true,
					Type:        framework.TypeString,
					Description: "Specifies the auth name",
				},
				"policies": {
					Required:    true,
					Type:        framework.TypeCommaStringSlice,
					Description: "Specifies the policies",
				},
				"firebase_device_ids": {
					Required:    true,
					Type:        framework.TypeCommaStringSlice,
					Description: "Specifies the device ids to send the notification to",
				},
			},

			Operations: map[logical.Operation]framework.OperationHandler{
				logical.CreateOperation: &framework.PathOperation{
					Callback: b.handleAuthWrite,
					Summary:  "Add a new auth method.",
				},
				logical.DeleteOperation: &framework.PathOperation{
					Callback: b.handleAuthDelete,
					Summary:  "Deletes an auth method.",
				},
			},

			ExistenceCheck: b.handleExistenceCheck,
		},
	}
}

func (b *backend) handleExistenceCheck(ctx context.Context, req *logical.Request, data *framework.FieldData) (bool, error) {
	name := data.Get("name").(string)
	_, ok := b.auths[name]

	return ok, nil
}

func (b *backend) pathAuthsList() *framework.Path {
	return &framework.Path{
		Pattern: "auths/?$",
		Operations: map[logical.Operation]framework.OperationHandler{
			logical.ListOperation: &framework.PathOperation{
				Callback: b.handleAuthsList,
				Summary:  "List existing auths.",
			},
		},
	}
}

func (b *backend) handleAuthsList(ctx context.Context, req *logical.Request, data *framework.FieldData) (*logical.Response, error) {
	authsList := make([]string, len(b.auths))

	i := 0
	for u := range b.auths {
		authsList[i] = u
		i++
	}

	sort.Strings(authsList)

	return logical.ListResponse(authsList), nil
}

func (b *backend) handleAuthWrite(ctx context.Context, req *logical.Request, data *framework.FieldData) (*logical.Response, error) {
	name := data.Get("name").(string)
	if name == "" {
		return logical.ErrorResponse("'name': name must be provided"), nil
	}

	policies := policyutil.ParsePolicies(data.Get("policies"))
	if len(policies) == 0 {
		return logical.ErrorResponse("'policies': at least one policy must be provided"), nil
	}

	firebaseDeviceIds := ParseList(data.Get("firebase_device_ids"))
	if len(firebaseDeviceIds) == 0 {
		return logical.ErrorResponse("'firebase_device_ids': at least one firebase device id must be provided"), nil
	}

	// Store kv pairs in map at specified path
	totpQrCodes := make(map[string]interface{})
	users := make(map[string]*User)
	for _, device := range firebaseDeviceIds {
		key, err := totp.Generate(totp.GenerateOpts{
			Issuer:      "Vepiot Vault",
			AccountName: name,
		})
		if err != nil {
			return nil, err
		}

		users[device] = &User{
			Secret: key.Secret(),
		}

		buf := new(bytes.Buffer)
		qrterminal.Generate(key.URL(), qrterminal.L, buf)
		totpQrCodes[device] = ".\n" + buf.String()
	}

	b.auths[name] = &Auth{
		Policies: policies,
		Users:    users,
	}

	resp := &logical.Response{
		Data: totpQrCodes,
	}

	return resp, nil
}

func (b *backend) handleAuthDelete(ctx context.Context, req *logical.Request, data *framework.FieldData) (*logical.Response, error) {
	name := data.Get("name").(string)
	if name == "" {
		return logical.ErrorResponse("name must be provided"), nil
	}

	// Remove entry for specified path
	delete(b.auths, name)

	return nil, nil
}

const pluginHelp = `
This plugin adds an authentication method which needs an external validation during usage
`
