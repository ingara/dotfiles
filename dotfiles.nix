{ config, lib, ... }:
let
  dots = {
    "targetfile" = "testrc";
    "ideavim/ideavimrc" = ".ideavimrc";
    "yabai/yabairc" = "yabairc";
    "skhd/skhdrc" = "skhdrc";
    "lazygit/config.yml" = "lazygit.yml";
    "nvim" = "nvim";
    "alacritty" = "alacritty";
  };
in
{
  xdg.configFile = lib.mapAttrs
    (key: value: { source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/${value}"; })
    dots;
}
