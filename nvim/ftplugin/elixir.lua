if vim.g.elixir_loaded then
  return
end

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
