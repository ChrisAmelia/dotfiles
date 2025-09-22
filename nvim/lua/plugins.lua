local cmd = vim.cmd

cmd [[packadd! packer.nvim]]

-- Colors
cmd [[packadd! nvim-colorizer.lua]]

-- Colorscheme
cmd [[packadd! vim-sublime-monokai]]

-- Completion
cmd [[packadd! LuaSnip]]
cmd [[packadd! cmp-buffer]]
cmd [[packadd! cmp-nvim-lsp-signature-help]]
cmd [[packadd! cmp-nvim-lsp]]
cmd [[packadd! cmp-nvim-lua]]
cmd [[packadd! cmp-path]]
cmd [[packadd! cmp-vsnip]]
cmd [[packadd! cmp_luasnip]]
cmd [[packadd! codecompanion.nvim]]
cmd [[packadd! nvim-autopairs]]
cmd [[packadd! nvim-cmp]]
cmd [[packadd! vim-vsnip-integ]]
cmd [[packadd! vim-vsnip]]

-- Tree-sitter
cmd [[packadd! hlargs.nvim]]
cmd [[packadd! nvim-treesitter]]
cmd [[packadd! nvim-ts-autotag]]

-- Finder
cmd [[packadd! LeaderF]]
cmd [[packadd! fzf-lua]]
cmd [[packadd! nvim-spectre]]
cmd [[packadd! plenary.nvim]]

-- Formatting
cmd [[packadd! vim-easy-align]]

-- Git
cmd [[packadd! vim-fugitive]]
cmd [[packadd! vim-gitgutter]]

-- Interface
cmd [[packadd! indent-blankline.nvim]]
cmd [[packadd! render-markdown.nvim]]

-- LSP
cmd [[packadd! fidget.nvim]]
cmd [[packadd! lsp-status.nvim]]
cmd [[packadd! nvim-eldoc]]
cmd [[packadd! nvim-jdtls]]
cmd [[packadd! nvim-lsp-endhints]]
cmd [[packadd! nvim-lspconfig]]
cmd [[packadd! rustaceanvim]]

-- Tabs
cmd [[packadd! barbar.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	-- Colors
	use { 'norcalli/nvim-colorizer.lua', opt = true }

	-- Colorscheme
	use { 'ErichDonGubler/vim-sublime-monokai', opt = true }

	-- Completion
	use { 'windwp/nvim-autopairs', opt = true }
	use { 'hrsh7th/nvim-cmp',
		opt = true,
		requires = {
			{ 'L3MON4D3/LuaSnip', opt = true },
			{ 'hrsh7th/cmp-buffer', opt = true },
			{ 'hrsh7th/cmp-nvim-lsp', opt = true },
			{ 'hrsh7th/cmp-nvim-lsp-signature-help', opt = true },
			{ 'hrsh7th/cmp-nvim-lua', opt = true },
			{ 'hrsh7th/cmp-path', opt = true },
			{ 'hrsh7th/cmp-vsnip', opt = true },
			{ 'hrsh7th/vim-vsnip', opt = true },
			{ 'hrsh7th/vim-vsnip-integ', opt = true},
			{ 'saadparwaiz1/cmp_luasnip', opt = true },
		},
	}
	use ({ "olimorris/codecompanion.nvim",
	config = function()
	end,
	requires = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	}
	})

	-- Git
	use { 'tpope/vim-fugitive', opt = true }
	use { 'airblade/vim-gitgutter', opt = true }

	-- Interface
	use { 'lukas-reineke/indent-blankline.nvim', opt = true }
	use { 'MeanderingProgrammer/render-markdown.nvim', opt = true}

	-- Finder
	use { 'Yggdroot/LeaderF', opt = true}
	use { 'ibhagwan/fzf-lua', opt = true}

	use { 'nvim-pack/nvim-spectre', opt = true, requires = { { "nvim-lua/plenary.nvim", opt = true } } }

	-- Formatting
	use { 'junegunn/vim-easy-align', opt = true }

	-- LSP
	use { 'neovim/nvim-lspconfig', opt = true }
	use { 'nvim-lua/lsp-status.nvim', opt = true }
	use { 'mfussenegger/nvim-jdtls', opt = true}
	use { 'j-hui/fidget.nvim', opt = true }
	use { 'mrcjkb/rustaceanvim', opt = true }
	use { 'chrisgrieser/nvim-lsp-endhints', opt = true }
	use { 'sj2tpgk/nvim-eldoc', opt = true }

	-- Tabs
	use { 'romgrk/barbar.nvim', opt = true }

	-- Tree-sitter
	use { 'nvim-treesitter/nvim-treesitter', opt = true }
	use { 'm-demare/hlargs.nvim', opt = true }
	use { 'windwp/nvim-ts-autotag', opt = true}
end)
