{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs, ... }@inputs:
    let
      outputs = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs ({
            inherit system;

            overlays = [
            ];

            config.allowUnfree = true;
          });
        in
        {
          packages = {
            auth_proxy = pkgs.buildGoModule rec {
              name = "auth_proxy";

              src = ./auth_proxy;

              vendorHash = "sha256-skp304q/dO1cBH6LIlrSg1rAoALtOK1wtweC0LJRPyI=";
            };
            vault_plugin = pkgs.buildGoModule rec {
              name = "vault_plugin";

              src = ./vault_plugin;

              vendorHash = "sha256-/6aE5w6Rki1ZIXMX9Ryo4XrGzS/01xZQiWDUROriixs=";
            };
          };

          overlays.default = final: prev: {
            zigpkgs = outputs.packages.${prev.system};
          };

          devShell = pkgs.pkgs.mkShell {

            buildInputs = with pkgs;
              [
                protobuf
                stdenv
                go_1_18
                buf
                cmake
                vault-bin
                protoc-gen-go
                pkgs.protoc-gen-connect-go
              ];
            shellHook = ''
              export CFLAGS="-I${pkgs.glibc.dev}/include"
              export LDFLAGS="-L${pkgs.glibc}/lib"
              [ -n "$(go env GOBIN)" ] && export PATH="$(go env GOBIN):''${PATH}"
              [ -n "$(go env GOPATH)" ] && export PATH="$(go env GOPATH)/bin:''${PATH}"
            '';
          };

        });
    in
    outputs
    // {
      overlays.default = final: prev: {
        auth_proxy = outputs.packages.${prev.system}.auth_proxy;
        vault_plugin = outputs.packages.${prev.system}.vault_plugin;
      };
    };
}
