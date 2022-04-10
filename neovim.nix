{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # TODO: migrate plugins to nix
  home.file.".config/nvim/lua".source = ./configs/nvim/lua;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = "lua require('init')"; # Bootstraps my init.lua
  };
}
