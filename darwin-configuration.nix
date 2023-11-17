{ pkgs, ... }:
{
  services.nix-daemon.enable = true;

  imports = [
    ./homebrew.nix
    ./mac.nix
  ];

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      XDG_CONFIG_HOME = "$HOME/.config";
    };

    # Use a custom configuration.nix location.
    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
    darwinConfig = "$HOME/.nixpkgs/darwin-configuration.nix";

    # systemPackages = [
    #   pkgs.yabai
    #   pkgs.skhd
    # ];
  };

  nix = {
    useDaemon = true;
    # enable flakes per default
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


  # This line is required; otherwise, on shell startup, you won't have Nix stuff in the PATH.
  programs.zsh.enable = true;
  programs.fish.enable = true;

  users.users.ingar.shell = pkgs.fish;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
