-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- By default `lsp` is before .git
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }

-- vim.o.termguicolors = true
