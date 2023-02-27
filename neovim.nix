{ config, pkgs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/nvim";
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/dotfiles/configs/nvim";
  programs.neovim =
    {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };

  # xdg.configFile."nvim/lua/config.lua".source = mkOutOfStoreSymlink ./configs/nvim/lua/config.lua;
  # xdg.configFile."nvim/init.lua".source = mkOutOfStoreSymlink ./configs/nvim/lua/config.lua;
  # xdg.configFile."nvim/lua" = {
  #   source = ./configs/nvim/lua;
  #   recursive = true;
  # };

  # programs.neovim =
  #   {
  #     enable = true;
  #     viAlias = true;
  #     vimAlias = true;
  #     # extraConfig = "lua require('config')"; # Bootstraps my config.lua
  #     # extraConfig = ''
  #     #   :luafile ~/.config/nvim/lua/config.lua
  #     # '';
  #     # extraConfig = "lua << EOF\n" + builtins.readFile ./configs/nvim/lua/config.lua + "\nEOF";
  #     # extraConfig = ":luafile ~/.config/nvim/lua/config.lua";

  #     plugins = with pkgs.vimPlugins;
  #       [
  #         fzf-vim
  #         fzfWrapper

  #         {
  #           plugin = telescope-nvim;
  #           config = ''

  #         require('telescope').load_extension('project')
  #         require('telescope').load_extension('githubcoauthors')
  #         require('telescope').load_extension('lazygit')
  #       '';
  #           type = "lua";
  #         }
  #         #   telescope-project-nvim

  #         {
  #           plugin = dracula-vim;
  #           config = ''
  #             colorscheme dracula
  #           '';
  #         }
  #         lualine-nvim
  #         dashboard-nvim

  #         nvim-treesitter

  #         nvim-lspconfig
  #         cmp-nvim-lsp
  #         nvim-cmp
  #         {
  #           plugin = nvim-lightbulb;
  #           config = ''
  #             autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
  #           '';
  #         }
  #         #   # TODO: LSP installer?

  #         lazygit-nvim

  #         vim-surround
  #         tmux-navigator
  #       ];
  #   };
}
