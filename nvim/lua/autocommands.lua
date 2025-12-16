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
  desc = "Update winbar.",
  pattern = '*',
  callback = function()
    vim.o.winbar = "%!v:lua.require('winbar').eval()"
  end
})

autocmd('CursorHold', {
  desc = "Update the global variable under 'vim.b.lsp_current_function'.",
  pattern = '*',
  callback = function()
    return require('lsp-status').update_current_function()
  end
})

autocmd("FileType", {
  desc = "Automatically Split help Buffers to the right.",
  pattern = "help",
  command = "wincmd L",
})

autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    -- remove error = false when nvim 0.12+ is default
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      vim.treesitter.start()
    end
  end,
})

autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  desc = 'Close with <q>',
  pattern = {
    'fugitive',
    'git',
    'help',
    'qf',
  },
  callback = function(args)
    if args.match ~= 'help' or not vim.bo[args.buf].modifiable then
      vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = args.buf })
    end
  end,
})
