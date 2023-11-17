-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--------
-- Stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
--------

map('', '<leader>y', '"+y', { desc = "Copy to clipboard in normal, visual, select and operator modes" })
map('n', 'H', '_', { desc = "Start of line"})
map('n', 'L', '$', { desc = "End of line"})
map('n', '<leader>uz', ':ZenMode<CR>', { desc = "Toggle Zen mode" })
