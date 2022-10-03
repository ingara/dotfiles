{
  description = "Ingar's Nix config for MacOS";

  inputs = {
    # Package sets
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.05";
    utils.url = "github:numtide/flake-utils";

    # Environment/system management
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # inputs.utils.follows = "nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, utils, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (utils.lib) eachDefaultSystem;
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = false;
          allowBroken = true;
        };
        #  The trick in the overlays variable allows us to use the stable version of problematic packages. You can just use stable.pkg instead of pkg in home/default.nix
        overlays = [
          (
            final: prev:
              let
                system = prev.stdenv.system;
                nixpkgs-stable = nixpkgs-stable;
              in
              {
                master = nixpkgs.legacyPackages.${system};
                stable = nixpkgs-stable.legacyPackages.${system};
              }
          )
        ];
      };
      stateVersion = "22.11";
      user = "ingar";
      system = "aarch64-darwin";
    in
    # let
      #   pkgs = import nixpkgs { inherit system nixpkgsConfig; };
      # in
    {
      # nix-darwin with home-manager for macOS
      darwinConfigurations = {
        # nixpkgs.config = nixpkgsConfig;
        # nixpkgs = pkgs;
        # ingar = darwin.lib.darwinSystem {
        ingar = darwin.lib.darwinSystem {
          system = system;
          # inputs = { inherit nixpkgs; };
          # makes all inputs availble in imported files
          specialArgs = { inherit inputs; };
          modules = [
            # (import ./darwin-configuration.nix { inherit nixpkgsConfig; user = user; })
            ./darwin-configuration.nix
            # ({ pkgs, ... }: {
            #   nixpkgs.config = nixpkgsConfig;
            #   # system.stateVersion = 4;

            #   # users.users.${user} = {
            #   #   home = "/Users/${user}";
            #   #   shell = pkgs.zsh;
            #   # };

            #   # nix = {
            #   #   useDaemon = true;
            #   #   # enable flakes per default
            #   #   # package = pkgs.nixFlakes;
            #   #   package = pkgs.nixVersions.stable;
            #   #   settings = {
            #   #     allowed-users = [ user ];
            #   #     experimental-features = [ "nix-command" "flakes" ];
            #   #   };
            #   # };
            # })
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              # utils = false;
              # utils = utils;
              # users.users.${user} = {
              #   home = "/Users/${user}";
              #   shell = nixpkgs.zsh;
              # };
              home-manager = {
                # pkgs = pkgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                # makes all inputs available in imported files for hm
                # extraSpecialArgs = { inherit inputs; };
                # users.ingar = import ./home.nix { user = user; };
                users.ingar = import ./home.nix;
                # home.stateVersion = stateVersion;
                # home.username = user;
                # users.${user} = { pkgs, ... }: {
                #   imports = [ ./home.nix ];
                #   home.stateVersion = stateVersion;
                #   home.username = user;
                # };
              };
            }
          ];
        };
      };
    };
  # } // eachDefaultSystem (system:
  #   let
  #     pkgs = import nixpkgs { inherit system; };
  #   in
  #   { });
}
