{
  description = "pub2nix: Flutter/Dart dependency fetcher for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs-s = forAllSystems (system: import nixpkgs { inherit system; });
      pkgs-stable-s = forAllSystems (system: import inputs.nixpkgs-stable { inherit system; });
    in {
      packages = forAllSystems (system: let pkgs = pkgs-s.${system}; in rec {
        fetch = pkgs.stdenv.mkDerivation {
          name = "pub2nix-fetch";
          src = self;
          buildInputs = with pkgs; with python3Packages; [ python3 pyyaml git wget ];

        };
          
        default = fetch;
      });
    };
}