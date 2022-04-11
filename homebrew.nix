{ config, pkgs, lib, ... }:

# let
#   brewBinPrefix = if pkgs.system == "aarch64-darwin" then "/opt/homebrew/bin" else "/usr/local/bin";
# in
{
  # environment.shellInit = ''
  #   eval "$(${brewBinPrefix}/brew shellenv)"
  # '';
  homebrew = {
    enable = true;
    autoUpdate = true;
    # brewPrefix = brewBinPrefix;
    cleanup = "zap"; # "zap" removes manually installed brews and casks
    brews = [
      "tmux-lazy-session"
    ];
    casks = [
      # utilities
      "bartender" # hides mac bar icons
      "browserosaurus" # choose browser on each link
      "alfred"
      #"firefox"
      "postman"
      "shottr" # screenshot tool
      "microsoft-teams"
      "zoom"
      "iterm2"
      "notion"
      "spotify"
      "amethyst"
      "discord"
      "fig"
      "visual-studio-code"
      "jetbrains-toolbox"
      "google-chrome"
    ];
    # Mac App Store
    masApps = {
      Fantastical = 975937182;
      "Airmail 5" = 918858936;
    };
    taps = [
      "ingara/formulae"
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
    ];
  };
}
