{ config, pkgs, lib, ... }:

{
  homebrew = {
    enable = true;
    onActivation =
      {
        autoUpdate = true;
        cleanup = "uninstall"; # "zap" removes manually installed brews and casks
        upgrade = true;
      };
    brews = [
      "tmux-lazy-session"
      # "shopify-cli"

      # Should be removed when nix package is working
      # "qmk/qmk/qmk"

      "teller"
      "tfenv"
      # "checkov"

      # "padok-team/tap/tfautomv"

      "koekeishiya/formulae/skhd"
      "koekeishiya/formulae/yabai"

      # iOS
      "licenseplist"
    ];
    casks = [
      # utilities
      "bartender" # hides mac bar icons
      # "firefox"
      "firefox-developer-edition"
      "raycast"
      "postman"
      "shottr" # screenshot tool
      # "microsoft-teams"
      # "zoom"
      "hammerspoon"
      "iterm2"
      "notion"
      "discord"
      "visual-studio-code"
      "jetbrains-toolbox"
      "google-chrome"
      "istat-menus"
      "rapidapi"
      "1password"
      "authy"
      "elgato-stream-deck"
      "signal"
    ];
    # Mac App Store
    masApps = {
      Fantastical = 975937182;
      "Airmail 5" = 918858936;
      "Amphetamine" = 937984704;
      # "TickTick:To-Do List, Calendar" = 966085870;
      "Spotica Menu" = 570549457;
      "Balance Lock" = 1019371109;
      "Velja" = 1607635845;
    };

    taps = [
      "ingara/formulae"
      "shopify/shopify"
      # "qmk/qmk"
      "spectralops/tap" # Teller
      "padok-team/tap" # RapidAPI
      "koekeishiya/formulae" # yabai/skhd
      "homebrew/cask-versions"
      # default
      "homebrew/bundle"
      # "homebrew/cask"
      "homebrew/cask-drivers"
      # "homebrew/core"
      "homebrew/services"
    ];
  };
}
