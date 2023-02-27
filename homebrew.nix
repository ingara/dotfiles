{ config, pkgs, lib, ... }:

# let
#   brewBinPrefix = if pkgs.system == "aarch64-darwin" then "/opt/homebrew/bin" else "/usr/local/bin";
# in
{
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

      "teller"
      "tfenv"
      "checkov"

      "padok-team/tap/tfautomv"

      "koekeishiya/formulae/skhd"
      "koekeishiya/formulae/yabai"
    ];
    casks = [
      # utilities
      "bartender" # hides mac bar icons
      "browserosaurus" # choose browser on each link
      "alfred"
      "raycast"
      "postman"
      "shottr" # screenshot tool
      "microsoft-teams"
      "zoom"
      "hammerspoon"
      "iterm2"
      "notion"
      "discord"
      "fig"
      "visual-studio-code"
      "jetbrains-toolbox"
      "google-chrome"
      "istat-menus"
      "rapidapi"
      "1password"
      "authy"
    ];
    # Mac App Store
    masApps = {
      Fantastical = 975937182;
      "Airmail 5" = 918858936;
      "Amphetamine" = 937984704;
      "TickTick:To-Do List, Calendar" = 966085870;
      "Spotica Menu" = 570549457;
      "Balance Lock" = 1019371109;
    };

    taps = [
      "ingara/formulae"
      "shopify/shopify"
      "qmk/qmk"
      "spectralops/tap" # Teller
      "padok-team/tap" # RapidAPI
      "koekeishiya/formulae" # yabai/skhd
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
    ];
  };
}
