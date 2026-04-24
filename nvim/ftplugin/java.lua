if vim.g.java_loaded then
  return
end

vim.g.java_loaded = true

local autocmd = vim.api.nvim_create_autocmd

-- nvim-jdtls {{{

autocmd("BufEnter", {
  once = true,
  pattern = { "*.java" },
  callback = function ()
    vim.pack.add({ "https://github.com/mfussenegger/nvim-jdtls" })
  end
})

-- }}}
