local Winbar = {}

require('colors')

local component = require('component')

-- autocmd to update the global variable under 'vim.b.lsp_current_function'
vim.api.nvim_create_autocmd('CursorHold', {
    pattern = '*',
    callback = function()
        return require('lsp-status').update_current_function()
    end
})

--- @return string # function under cursor
local build_current_function_component = function()
  local current_function = ""
  local filename = vim.fn.expand("%:t:r")
  local icon = "ƒ"

  if vim.b.lsp_current_function == nil or vim.b.lsp_current_function == "" or vim.b.lsp_current_function == filename  then
    return ""
  end

  current_function = vim.b.lsp_current_function

  return component.build_element({
      separator_hl = "HlStatuslineSeparatorFunction",
      main_hl = "HlStatuslineFunction",
      bg = ROSE,
      fg = WHITE,
      value = icon .. ":" ..  current_function
  })
end

Winbar.eval = function ()
  local winbar = ""

  local current_function = build_current_function_component()

  if current_function ~= "" then
    winbar = winbar .. current_function
  end

  return winbar
end

--- setup {{{
local function set_winbar()
    vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
        pattern = '*',
        callback = function()
            vim.o.winbar = "%!v:lua.require('winbar').eval()"
        end
    })

    vim.o.winbar = "%!v:lua.require('winbar').eval()"
end

set_winbar()
--- }}}

return Winbar
