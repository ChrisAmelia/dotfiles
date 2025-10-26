local api = vim.api

-- Retrieve current git branch's name and set it in buffer
api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, { callback = function ()
  local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

  if handle ~= nil then
    local branch_name = handle:read("*a")

    vim.b.git_branch_name = branch_name

    handle:close()
  end
end})

-- Add buffer diagnostics to the location list.
api.nvim_create_autocmd({ "InsertLeave" }, { callback = function ()
  vim.diagnostic.setloclist({ open = false })
end})

-- Highlights the yanked text.
api.nvim_create_autocmd({ "TextYankPost" }, { callback = function ()
  vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}
end})
