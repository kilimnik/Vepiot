{
  inputs = {
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs-unstable, nixpkgs-master, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs-master = nixpkgs-master.legacyPackages.${system}.appendOverlays [

        ];

        pkgs = import nixpkgs-unstable ({
          inherit system;

          overlays = [
          ];

          config.allowUnfree = true;
        });

      in
      {
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
              pkgs-master.protoc-gen-connect-go
            ];
          shellHook = ''
            export CFLAGS="-I${pkgs.glibc.dev}/include"
            export LDFLAGS="-L${pkgs.glibc}/lib"
            [ -n "$(go env GOBIN)" ] && export PATH="$(go env GOBIN):''${PATH}"
            [ -n "$(go env GOPATH)" ] && export PATH="$(go env GOPATH)/bin:''${PATH}"
          '';
        };

      });
}
