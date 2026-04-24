local autocmd = vim.api.nvim_create_autocmd

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
  'https://github.com/rachartier/tiny-glimmer.nvim',
  'https://github.com/folke/zen-mode.nvim',

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

-- neotest-elixir {{{

autocmd("BufEnter", {
  once = true,
  pattern = { "*.ex", "*.exs", "*.heex" },
  callback = function ()
    -- Testing
    vim.pack.add({
      "https://github.com/nvim-neotest/neotest",
      "https://github.com/jfpedroza/neotest-elixir",
        --- dependencies
        "https://github.com/nvim-lua/plenary.nvim",
        "https://github.com/nvim-neotest/nvim-nio",
    })

    require("neotest").setup({
      output = { open_on_run = true },
      adapters = {
        require("neotest-elixir")({
          -- The Mix task to use to run the tests
          -- Can be a function to return a dynamic value.
          -- Default: "test"
          --- mix_task = {"my_custom_task"},

          -- Other formatters to pass to the test command as the formatters are overridden
          -- Can be a function to return a dynamic value.
          -- Default: {"ExUnit.CLIFormatter"}
          --- extra_formatters = {"ExUnit.CLIFormatter", "ExUnitNotifier"},

          -- Extra test block identifiers
          -- Can be a function to return a dynamic value.
          -- Block identifiers "test", "feature" and "property" are always supported by default.
          -- Default: {}
          --- extra_block_identifiers = {"test_with_mock"},

          -- Extra arguments to pass to mix test
          -- Can be a function that receives the position, to return a dynamic value
          -- Default: {}
          args = {"--trace"},

          -- Command wrapper
          -- Must be a function that receives the mix command as a table, to return a dynamic value
          -- Default: function(cmd) return cmd end
          post_process_command = function(cmd)
            return vim.iter({{"env", "FOO=bar"}, cmd}):flatten():totable()
          end,

          -- Delays writes so that results are updated at most every given milliseconds
          -- Decreasing this number improves snappiness at the cost of performance
          -- Can be a function to return a dynamic value.
          -- Default: 1000
          write_delay = 1000,

          -- The pattern to match test files
          -- Default: "_test.exs$"
          test_file_pattern = ".test.exs$",

          -- Function to determine whether a directory should be ignored
          -- By default includes root test directory and umbrella apps' test directories
          -- Params:
          -- - name (string) - Name of directory
          -- - rel_path (string) - Path to directory, relative to root
          -- - root (string) - Root directory of project
          filter_dir = function(name, rel_path, root)
            return rel_path == "test"
            or rel_path == "lib"
            or vim.startswith(rel_path, 'test/')
            or vim.startswith(rel_path, 'lib/')
          end,
        }),
      }
    })

  end
})

-- }}}

-- nvim-jdtls {{{

autocmd("BufEnter", {
  once = true,
  pattern = { "*.java" },
  callback = function ()
    vim.pack.add({ "https://github.com/mfussenegger/nvim-jdtls" })
  end
})

-- }}}

-- Rendermarkdown {{{

autocmd("BufEnter", {
  once = true,
  pattern = { "*.md" },
  callback = function()
    vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

    require('render-markdown').setup({
      checkbox = {
        enabled = true,
        render_modes = false,
        right_pad = 1,
        unchecked = {
          icon = '󰄱 ',
          highlight = 'RenderMarkdownUnchecked',
          scope_highlight = nil,
        },
        checked = {
          icon = '󰱒 ',
          highlight = 'RenderMarkdownChecked',
          scope_highlight = nil,
        },
        custom = {
          todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
      },
    })

    vim.api.nvim_command("RenderMarkdown disable")
  end
})

-- }}}
