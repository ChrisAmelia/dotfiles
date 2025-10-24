---@class Component
---@field separator_hl string The separator's highlight.
---@field main_hl      string The value's separator highlight.
---@field bg           string The background color.
---@field fg           string The foreground color.
---@field value        string The value.
---@field has_separator_left  boolean|nil false to not add the separator on the left
---@field has_separator_right boolean|nil false to not add the separator on the right
local Component = {}

SEPARATOR_LEFT = ""
SEPARATOR_RIGHT = ""

vim.api.nvim_command("hi StatusLine guibg=none gui=nocombine")
vim.api.nvim_command("hi WinBar guibg=none gui=nocombine")

--- @param params table
--- @return string
function Component.build_element(params)
  local buffer = ""

  if params.has_separator_left ~= false then
    vim.api.nvim_command("hi " .. params.separator_hl .. " guifg=" .. params.bg  .. " guibg=none")
    buffer = buffer .. "%#" .. params.separator_hl .. "#"
    buffer = buffer .. SEPARATOR_LEFT
  end

  vim.api.nvim_command("hi " .. params.main_hl .. " guifg=" .. params.fg .. " guibg=" .. params.bg)
  buffer = buffer .. "%#" .. params.main_hl .. "#"
  buffer = buffer .. params.value

  if params.has_separator_right ~= false then
    vim.api.nvim_command("hi " .. params.separator_hl .. " guifg=" .. params.bg  .. " guibg=none")
    buffer = buffer .. "%#" .. params.separator_hl .. "#"
    buffer = buffer .. SEPARATOR_RIGHT
  end

  return buffer
end

return Component
