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
    onActivation =
      {
        autoUpdate = true;
        # brewPrefix = brewBinPrefix;
        cleanup = "uninstall"; # "zap" removes manually installed brews and casks
        upgrade = true;
      };
    brews = [
      "tmux-lazy-session"
      # "shopify-cli"

      # Should be removed when nix package is working
      "qmk/qmk/qmk"
    ];
    casks = [
      # utilities
      "bartender" # hides mac bar icons
      "browserosaurus" # choose browser on each link
      "alfred"
      "postman"
      "shottr" # screenshot tool
      "microsoft-teams"
      "zoom"
      "hammerspoon"
      "iterm2"
      "notion"
      "amethyst"
      "discord"
      "fig"
      "visual-studio-code"
      "jetbrains-toolbox"
      "google-chrome"
      "istat-menus"
    ];
    # Mac App Store
    masApps = {
      Fantastical = 975937182;
      "Airmail 5" = 918858936;
      "Amphetamine" = 937984704;
      "TickTick:To-Do List, Calendar" = 966085870;
    };

    taps = [
      "ingara/formulae"
      "shopify/shopify"
      "qmk/qmk"
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
    ];
  };
}
