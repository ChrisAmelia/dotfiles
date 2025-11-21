vim.api.nvim_create_user_command("UpdatePlugins", function() vim.pack.update() end, {})

vim.pack.add({
  -- Colors
  'https://github.com/norcalli/nvim-colorizer.lua',

  -- Colorscheme
  'https://github.com/ErichDonGubler/vim-sublime-monokai',

  -- Completion
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help',
  'https://github.com/hrsh7th/cmp-nvim-lua',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-vsnip',
  'https://github.com/hrsh7th/vim-vsnip',
  'https://github.com/hrsh7th/vim-vsnip-integ',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/olimorris/codecompanion.nvim',
    --- dependencies
    'https://github.com/nvim-lua/plenary.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = "main" },

  -- Git
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/airblade/vim-gitgutter',

  -- Interface
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/rachartier/tiny-glimmer.nvim',

  -- Finder
  'https://github.com/Yggdroot/LeaderF',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-pack/nvim-spectre',
    --- dependencies
    'https://github.com/nvim-lua/plenary.nvim',

  -- Formatting
  'https://github.com/junegunn/vim-easy-align',

  -- LSP
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-lua/lsp-status.nvim',
  'https://github.com/mfussenegger/nvim-jdtls',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/chrisgrieser/nvim-lsp-endhints',
  'https://github.com/sj2tpgk/nvim-eldoc',

  -- Tabs
  'https://github.com/romgrk/barbar.nvim',

  -- Tree-sitter
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = "main" },
  'https://github.com/m-demare/hlargs.nvim',
  'https://github.com/windwp/nvim-ts-autotag',
})
