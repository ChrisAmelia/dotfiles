if vim.g.elixir_loaded then
  return
end

local autocmd = vim.api.nvim_create_autocmd

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

vim.g.elixir_loaded = true

vim.o.shiftwidth=2
vim.o.tabstop=2
vim.o.expandtab = true

vim.keymap.set('n', '<F1>', function() require("neotest").run.run() end)
vim.keymap.set('n', '<F2>', function() require("neotest").output.open({ enter = false }) end)
vim.keymap.set('n', '<F3>', function() require("neotest").summary.toggle() end)

vim.api.nvim_create_autocmd("BufWrite", {
  desc = "Format current file.",
  pattern = { "*.ex", "*.exs" },
  callback = function ()
    vim.lsp.buf.format()
  end
})
