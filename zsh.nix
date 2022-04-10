{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      cat = "bat";
      g = "git";
      dr = "darwin-rebuild";
      tls = "tmux-lazy-session";
      tf = "terraform";
    };
    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [
        "git"
        "sudo"
        "colorize"
      ];
    };
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
