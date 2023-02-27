{
  description = "Ingar's Nix config for MacOS";

  inputs = {
    # Package sets
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # Utils
    utils.url = "github:numtide/flake-utils";

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, utils, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues optionalAttrs singleton makeOverridable;
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = false;
          # allowBroken = true;
        };
        # The trick in the overlays variable allows us to use the stable version of problematic packages. You can just use stable.pkg instead of pkg in home/default.nix
        overlays = attrValues self.overlays ++ singleton (
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.pkgs-x86)
              idris2
              nix-index
              niv;
          })
        );
        # overlays = [
        #   (
        #     final: prev:
        #       let
        #         system = prev.stdenv.system;
        #         nixpkgs-stable = nixpkgs-stable;
        #       in
        #       {
        #         master = nixpkgs.legacyPackages.${system};
        #         stable = nixpkgs-stable.legacyPackages.${system};
        #       }
        #   )
        # ];
      };
      stateVersion = "22.11";
      user = "ingar";
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations = rec {
        ingar = darwinSystem {
          system = system;
          modules = [
            ./darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              users.users.ingar.home = "/Users/${user}";
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ingar = import ./home.nix;
              };
            }
          ];
        };

      };
      overlays = {
        # Overlays to add different versions `nixpkgs` into package set
        pkgs-master = final: prev: {
          pkgs-master = import inputs.nixpkgs-master {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-stable = final: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-unstable = final: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        };
      };
    } // utils.lib.eachDefaultSystem (system: {
      legacyPackages = import inputs.nixpkgs-unstable {
        inherit system;
        inherit (nixpkgsConfig) config;
        overlays = with self.overlays; [
          pkgs-master
          pkgs-stable
          apple-silicon
        ];
      };
    });
}
