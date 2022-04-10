-- Packer bootstrap
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end
vim.cmd [[packadd packer.nvim]]

-- Plugins
require('packer').startup(function(use)
	use 'famiu/nvim-reload'
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
	}
	use 'nvim-telescope/telescope-project.nvim'
	use 'nvim-treesitter/nvim-treesitter'

	use 'neovim/nvim-lspconfig'
	use { 'hrsh7th/nvim-compe',
		event = 'InsertEnter *'
	}
	use 'kabouzeid/nvim-lspinstall'

	use 'kosayoda/nvim-lightbulb'
	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
	use 'cwebster2/github-coauthors.nvim'
	use {
		'hoob3rt/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- Colorschemes
	use 'shaunsingh/nord.nvim'
	use {
		'dracula/vim',
		as = 'dracula'
	}

	use 'tomtom/tcomment_vim'
	use 'tpope/vim-surround'

	use {
		'dhruvasagar/vim-prosession',
		after = 'vim-obsession',
		requires = {{'tpope/vim-obsession', cmd = 'Prosession'}}
	}
	-- Pretty symbols
	use 'kyazdani42/nvim-web-devicons'

	use 'glepnir/dashboard-nvim'

	-- Language servers
	use 'folke/lua-dev.nvim'
end)
