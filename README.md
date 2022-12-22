# Vepiot

This is a authentication plugin for [Hashicorp Vault](https://github.com/hashicorp/vault).

The idea of this plugin is to add a manual human step into the authentication process. This works by registering the app with the vault and every time the vault tries to authenticate via this service. The service makes a push notification via firebase. The user can accept the authentication or deny it.

```mermaid
sequenceDiagram

loop
    Vault->>+Proxy: Did someone respond to Vault_X?
    Proxy-->>-Vault: No
end
Vault->>Firebase: Accept or Deny Vault_X login?
Firebase->>Mobile Devices: Accept or Deny Vault_X login?
Mobile Devices->>Proxy: Accept login to Vault_X!

Vault->>+Proxy: Did someone respond to Vault_X?
Proxy-->>-Vault: Accept login to Vault_X!

Vault->>Firebase: Login to Vault_X accepted.
Firebase->>Mobile Devices: Login to Vault_X accepted.

Note right of Vault: Login Accepted
```

## TODO:
* CI/CD
* More secure device registration
* Testcases
* ...