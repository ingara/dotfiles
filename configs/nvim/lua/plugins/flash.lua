return {
  "folke/flash.nvim",
  keys = {
    -- disable the default flash keymap
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "o", "x" }, false },

    { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<c-CR>", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}
