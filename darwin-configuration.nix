{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ./homebrew.nix
    ./mac.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
  '';

  programs.zsh.enable = true;

  users.users.ingar = {
    name = "ingar";
    home = "/Users/ingar";
  };
  home-manager.users.ingar = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      bat
      colima
      docker
      fd
      htop
      jq
      nixpkgs-fmt
      ripgrep
      terraform
      tldr
    ];

    imports = [
      ./fzf.nix
      ./git.nix
      ./neovim.nix
      ./tmux.nix
      ./zsh.nix
    ];

    programs = {
      exa = {
        enable = true;
        enableAliases = true;
      };

      htop.enable = true;

      starship = {
        # Disable starship until fixed: https://github.com/NixOS/nixpkgs/issues/160876, https://github.com/NixOS/nixpkgs/issues/146349
        enable = false;
        enableZshIntegration = true;
      };
    };


    home.file = {
      ".editorconfig".source = ./configs/.editorconfig;

      ideavimrc = {
        target = ".config/ideavim/ideavimrc";
        source = ./configs/.ideavimrc;
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
    ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
