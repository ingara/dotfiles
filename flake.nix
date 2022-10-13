{
  description = "Ingar's Nix config for MacOS";

  inputs = {
    # Package sets
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    # Utils
    utils.url = "github:numtide/flake-utils";

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, utils, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = false;
          allowBroken = true;
        };
        # The trick in the overlays variable allows us to use the stable version of problematic packages. You can just use stable.pkg instead of pkg in home/default.nix
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
      darwinConfigurations = {
        ingar = darwin.lib.darwinSystem {
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
    };
}
