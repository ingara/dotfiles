{ pkgs, ... }:
{
  services.nix-daemon.enable = true;

  imports = [
    # <home-manager/nix-darwin>
    ./homebrew.nix
    ./mac.nix
  ];

  # users.users.${user} = {
  #   home = "/Users/${user}";
  #   shell = pkgs.zsh;
  # };

  environment = {
    systemPackages = with pkgs; [ ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  # nixpkgs.config.allowUnfree = true;
  nix = {
    useDaemon = true;
    # enable flakes per default
    # package = pkgs.nixFlakes;
    package = pkgs.nixVersions.stable;
    gc.automatic = true;
    settings = {
      # allowed-users = [ user ];
      experimental-features = [ "nix-command" "flakes" ];
    };
    extraOptions = ''
      extra-platforms = aarch64-darwin x86_64-darwin
    '';
  };


  programs = {
    zsh.enable = true;
  };

  # users.users.ingar = {
  #   name = "ingar";
  #   home = "/Users/ingar";
  # };
  # home-manager.users.ingar = { pkgs, ... }: {
  #   nixpkgs.config.allowUnfree = true;

  # TODO: These two should be removed at some point
  # nixpkgs.config.allowBroken = true;
  # nixpkgs.config.allowUnsupportedSystem = true;






  #   home.file = {
  #     ".editorconfig".source = ./configs/.editorconfig;

  #     ideavimrc = {
  #       target = ".config/ideavim/ideavimrc";
  #       source = ./configs/.ideavimrc;
  #     };

  #     ".config/lazygit/config.yml".source = ./configs/lazygit.yml;
  #   };

  #   home.sessionVariables = {
  #     EDITOR = "nvim";
  #   };

  #   home.stateVersion = "22.11";
  # };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
    ];
  };


  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
