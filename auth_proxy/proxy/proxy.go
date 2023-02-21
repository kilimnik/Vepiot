package proxy

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/bufbuild/connect-go"
	"github.com/spf13/viper"
	"go.uber.org/zap"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"

	api "github.com/kilimnik/vepiot/auth_proxy/gen/api/v1"       // generated by protoc-gen-go
	"github.com/kilimnik/vepiot/auth_proxy/gen/api/v1/v1connect" // generated by protoc-gen-connect-go
)

type TOTP struct {
	time     time.Time
	response api.TOTPResponse
}

type Device struct {
	id string
}

type Server struct {
	Logger *zap.SugaredLogger
	Host   string
	Port   int

	TOTPs map[string]*TOTP
}

func (s *Server) SendTOTP(
	ctx context.Context,
	req *connect.Request[api.SendTOTPRequest],
) (*connect.Response[api.SendTOTPResponse], error) {
	if req.Msg.GetResponse() == nil {
		return nil, connect.NewError(connect.CodeInvalidArgument, errors.New("response can't be empty"))
	}

	s.TOTPs[req.Msg.Response.Id] = &TOTP{
		time:     time.Now(),
		response: *req.Msg.GetResponse(),
	}

	res := connect.NewResponse(&api.SendTOTPResponse{})

	return res, nil
}

func (s *Server) GetTOTP(
	ctx context.Context,
	req *connect.Request[api.GetTOTPRequest],
) (*connect.Response[api.GetTOTPResponse], error) {
	if len(req.Msg.Id) == 0 {
		return nil, connect.NewError(connect.CodeInvalidArgument, errors.New("id can't be empty"))
	}

	totp, ok := s.TOTPs[req.Msg.Id]
	if !ok {
		return nil, connect.NewError(connect.CodeNotFound, errors.New("id has no codes"))
	}

	delete(s.TOTPs, req.Msg.Id)

	res := connect.NewResponse(&api.GetTOTPResponse{
		Response: &totp.response,
	})

	return res, nil
}

func (s *Server) Start() {
	server := &Server{
		TOTPs: make(map[string]*TOTP),
	}

	mux := http.NewServeMux()

	var interceptorArray []connect.Interceptor

	if viper.GetInt("verbose") > 1 {
		interceptorArray = append(interceptorArray, NewLoggingInterceptor(s.Logger))
	}
	interceptors := connect.WithInterceptors(interceptorArray...)

	path, handler := v1connect.NewServiceHandler(server, interceptors)

	mux.Handle(path, handler)

	addr := fmt.Sprintf("%s:%d", s.Host, s.Port)
	s.Logger.Infof("Starting server %s", addr)

	http.ListenAndServe(
		addr,
		// Use h2c so we can serve HTTP/2 without TLS.
		h2c.NewHandler(mux, &http2.Server{}),
	)
}
