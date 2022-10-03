{ config, pkgs, ... }:

let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.configFile."nvim/lua/ingar".source = mkOutOfStoreSymlink ./configs/nvim/lua;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = "lua require('ingar/config')"; # Bootstraps my config.lua

    plugins = with pkgs.vimPlugins; [
      { plugin = fzf-vim; config = ""; }
      { plugin = fzfWrapper; config = ""; }

      {
        plugin = telescope-nvim;
        config = "";
        # config = ''
        #   require('telescope').load_extension('project')
        #   require('telescope').load_extension('githubcoauthors')
        #   require('telescope').load_extension('lazygit')
        # '';
        # type = "lua";
      }
      #   telescope-project-nvim

      {
        plugin = dracula-vim;
        config = ''
          colorscheme dracula
        '';
      }
      { plugin = lualine-nvim; config = ""; }
      { plugin = dashboard-nvim; config = ""; }

      { plugin = nvim-treesitter; config = ""; }

      { plugin = nvim-lspconfig; config = ""; }
      { plugin = cmp-nvim-lsp; config = ""; }
      { plugin = nvim-cmp; config = ""; }
      {
        plugin = nvim-lightbulb;
        config = ''
          autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
        '';
      }
      #   # TODO: LSP installer?

      { plugin = lazygit-nvim; config = ""; }

      { plugin = vim-surround; config = ""; }
      { plugin = tmux-navigator; config = ""; }
    ];
  };
}
