local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter", "BufWinEnter" }, {
  desc = "Retrieve current git branch's name and set it in buffer.",
  callback = function ()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

  if handle ~= nil then
    local branch_name = handle:read("*a")

    vim.b.git_branch_name = branch_name

    handle:close()
  end
end})

autocmd({ "InsertLeave" }, {
  desc = "Add buffer diagnostics to the location list.",
  callback = function ()
    vim.diagnostic.setloclist({ open = false })
  end
})

autocmd({ "TextYankPost" }, {
  desc = "Highlights the yanked text.",
  callback = function ()
    vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}
  end
})

autocmd({'WinEnter', 'BufEnter'}, {
  desc = "Update statusline.",
  pattern = '*',
  callback = function()
    vim.o.statusline = "%!v:lua.require('status-line').activate()"
  end
})

autocmd({ 'WinLeave', 'BufLeave' }, {
  desc = "Inactivate statusline.",
  pattern = '*',
  callback = function()
    vim.o.statusline = "%!v:lua.require('status-line').inactivate()"
  end
})

autocmd({ 'WinEnter', 'BufEnter' }, {
  desc = "Update winbar",
  pattern = '*',
  callback = function()
    vim.o.winbar = "%!v:lua.require('winbar').eval()"
  end
})

autocmd('CursorHold', {
  desc = "Update the global variable under 'vim.b.lsp_current_function'",
  pattern = '*',
  callback = function()
    return require('lsp-status').update_current_function()
  end
})
