-- nvim config
require('plugins')

-- Utils
local execute = vim.api.nvim_command
local fn = vim.fn
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')

local map_key = vim.api.nvim_set_keymap

local function opt(o, v, scopes)
	scopes = scopes or {o_s}
	for _, s in ipairs(scopes) do s[o] = v end
end

local function map(modes, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	if type(modes) == 'string' then modes = {modes} end
	for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end


-- Options
local indent = 2

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.guifont = 'PragmataPro Mono liga'

vim.o.termguicolors = true	-- true color support
-- vim.g.nord_contrast = true
-- vim.g.nord_borders = true
opt('background', 'dark')
cmd [[colorscheme dracula]]

vim.wo.number = true		-- show line numbers
vim.o.mouse = 'a'		-- enable mouse mode
vim.o.hidden = true		-- do not save when switching buffers
vim.o.breakindent = true	-- enable break indent

vim.o.hlsearch = true		--
vim.o.incsearch = true		-- enable incremental search
vim.o.ignorecase = true		-- case insensitive search unless /C or capital in search
vim.o.smartcase = true

vim.o.joinspaces = false	-- no double spaces with join after dot
vim.o.scrolloff = 4		-- lines of context
vim.o.sidescrolloff = 8		-- lines of context

vim.o.splitbelow = true		-- split windows below
vim.o.splitright = true		-- ... and to the right

vim.w.list = true		-- show invisible characters


-- Plugin config

vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

local ts = require 'nvim-treesitter.configs'
ts.setup {
	ensure_installed = 'maintained', highlight = { enable = true }
}

local neogit = require('neogit')
neogit.setup {}

require('lualine').setup {
	options = {
		theme = 'nord'
	}
}

require('telescope').load_extension('project')
require('telescope').load_extension('githubcoauthors')

local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"lua-language-server"}
  -- },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)

-- compe autocompletion
vim.g.loaded_compe_treesitter = true
vim.g.loaded_compe_snippets_nvim = true
vim.g.loaded_compe_spell = true
vim.g.loaded_compe_tags = true
vim.g.loaded_compe_ultisnips = true
vim.g.loaded_compe_vim_lsc = true
vim.g.loaded_compe_vim_lsp = true

-- lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]


-- Keymappings
map('', '<leader>y', '"+y')       	-- Copy to clipboard in normal, visual, select and operator modes
map('n', '<leader>/', '<cmd>noh<CR>')	-- Clear highlights

map('n', 'H', '_')			-- Start of line
map('n', 'L', '$')			-- End of line

-- Telescope
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]])
map('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<cr>]])
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
map('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]])
map('n', '<leader><Space>', [[<cmd>lua require('telescope.builtin').commands()<cr>]])
map('n', '<C-p>', [[<cmd>lua require'telescope'.extensions.project.project{}<cr>]], {noremap = true, silent = true})
map('n', '<leader>gc', [[<cmd>lua require'telescope'.extensions.githubcoauthors.coauthors()<cr>]])

-- LSP
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- lspinstall
require'lspinstall'.setup() -- important
local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

local nvim_lsp = require('lspconfig')
local servers = { "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup { on_attach = on_attach }
end

-- map('n', 'gr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]])
-- map('n', '<A-cr>', [[<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>]])
-- map('v', '<A-cr>', [[<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>]])
-- map('v', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<cr>]])
-- map('v', 'gd', [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]])

-- Neogit
map('n', '<leader>gs', [[<cmd>lua require('neogit').open()<cr>]])

