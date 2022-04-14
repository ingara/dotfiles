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
    extraConfig = "lua require('ingar/init')"; # Bootstraps my init.lua

    plugins = with pkgs.vimPlugins; [
      fzf-vim
      fzfWrapper

      {
        plugin = telescope-nvim;
        config = ''
          require('telescope').load_extension('project')
          require('telescope').load_extension('githubcoauthors')
          require("telescope").load_extension("lazygit")
        '';
        type = "lua";
      }
      telescope-project-nvim

      {
        plugin = dracula-vim;
        config = ''
          colorscheme dracula
        '';
      }
      lualine-nvim
      dashboard-nvim

      nvim-treesitter

      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      {
        plugin = nvim-lightbulb;
        config = ''
          autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
        '';
      }
      # TODO: LSP installer?

      lazygit-nvim

      vim-surround
      tmux-navigator
    ];
  };
}
