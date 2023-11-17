return {
  "LintaoAmons/scratch.nvim",
  event = 'VimEnter',
  keys = {
    { "<M-C-n>", "<cmd>Scratch<cr>" }

--     vim.keymap.set("n", "<M-C-n>", "<cmd>Scratch<cr>")
-- vim.keymap.set("n", "<M-C-o>", "<cmd>ScratchOpen<cr>")
    -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
    -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  }
}
