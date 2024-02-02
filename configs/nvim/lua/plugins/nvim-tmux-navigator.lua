return {
  "alexghergh/nvim-tmux-navigation",
  enabled = enabled,
  event = "VeryLazy",
  vscode = false,
  config = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")
    nvim_tmux_nav.setup({
      disable_when_zoomed = true,
      -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      },
    })
  end,
  keys = {
    { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", { desc = "Tmux navigate left", silent = true } },
    { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", { desc = "Tmux navigate down", silent = true } },
    { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", { desc = "Tmux navigate up", silent = true } },
    { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", { desc = "Tmux navigate right", silent = true } },
  },
}
