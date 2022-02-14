local cmd = vim.cmd

cmd [[packadd! packer.nvim]]

-- Colors
cmd [[packadd! nvim-colorizer.lua]]

-- Colorscheme
cmd [[packadd! vim-sublime-monokai]]

-- Completion
cmd [[packadd! nvim-cmp]]
cmd [[packadd! vim-vsnip]]
cmd [[packadd! vim-vsnip-integ]]
cmd [[packadd! cmp-nvim-lsp]]
cmd [[packadd! cmp-nvim-lua]]
cmd [[packadd! cmp-buffer]]
cmd [[packadd! cmp-path]]
cmd [[packadd! cmp-vsnip]]
cmd [[packadd! pears.nvim]]

-- Tree-sitter
cmd [[packadd! nvim-treesitter]]
cmd [[packadd! hlargs.nvim]]

-- Finder
cmd [[packadd! LeaderF]]
cmd [[packadd! popup.nvim]]
cmd [[packadd! plenary.nvim]]
cmd [[packadd! telescope.nvim]]

-- Formatting
cmd [[packadd! vim-easy-align]]

-- Git
cmd [[packadd! vim-fugitive]]
cmd [[packadd! vim-gitgutter]]

-- Interface
cmd [[packadd! indent-blankline.nvim]]

-- LSP
cmd [[packadd! nvim-lspconfig]]
cmd [[packadd! lsp-status.nvim]]

-- Tabs
cmd [[packadd! barbar.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	-- Colors
	use { 'norcalli/nvim-colorizer.lua', opt = true }

	-- Colorscheme
	use { 'ErichDonGubler/vim-sublime-monokai', opt = true }

	-- Completion
	use { 'hrsh7th/nvim-cmp',
		opt = true,
		requires = {
			{ 'hrsh7th/cmp-buffer', opt = true },
			{ 'hrsh7th/cmp-path', opt = true },
			{ 'hrsh7th/cmp-nvim-lsp', opt = true },
			{ 'hrsh7th/cmp-nvim-lua', opt = true },
			{ 'hrsh7th/cmp-vsnip', opt = true },
			{ 'hrsh7th/vim-vsnip', opt = true },
			{ 'hrsh7th/vim-vsnip-integ', opt = true},
		},
	}
	use { 'steelsojka/pears.nvim', opt = true }

	-- Git
	use { 'tpope/vim-fugitive', opt = true }
	use { 'airblade/vim-gitgutter', opt = true }

	-- Interface
	use { 'lukas-reineke/indent-blankline.nvim', branch = 'master', opt = true }

	-- Finder
	use { 'Yggdroot/LeaderF', opt = true}
	use { 'nvim-telescope/telescope.nvim', opt = true, requires = { {'nvim-lua/popup.nvim', opt = true}, {'nvim-lua/plenary.nvim', opt = true} } }

	-- Formatting
	use { 'junegunn/vim-easy-align', opt = true }

	-- LSP
	use { 'neovim/nvim-lspconfig', opt = true }
	use { 'nvim-lua/lsp-status.nvim', opt = true }

	-- Tabs
	use { 'romgrk/barbar.nvim', opt = true }

	-- Tree-sitter
	use { 'nvim-treesitter/nvim-treesitter', opt = true }
	use { 'm-demare/hlargs.nvim', opt = true }
end)
