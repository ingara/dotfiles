{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
    extraConfig = (builtins.readFile ./configs/tmux.conf);
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-fahrenheit false
          set -g @dracula-show-left-icon session
          set -g @dracula-show-powerline true
          set -g @dracula-show-flags true
        '';
      }
      open # Open stuff with prefix+o
      pain-control # navigating panes etc
      prefix-highlight
      sidebar # prefix+<tab> and prefix+<backspace>
      tmux-fzf # prefix+F
      # tmux-thumbs # copy/pasting stuff. prefix+<space>
      vim-tmux-navigator # Move around with <ctrl>+hjkl
      yank # Copy to system clipboard
      fzf-tmux-url # Find URLS with prefix+u
    ];
  };
}

