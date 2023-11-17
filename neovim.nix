{ config, pkgs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/nvim";
  programs.neovim =
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
}
