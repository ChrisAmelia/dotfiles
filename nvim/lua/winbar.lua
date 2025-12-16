local Winbar = {}

require('colors')

local component = require('component')

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

return Winbar
