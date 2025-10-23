local Winbar = {}

require('colors')

local component = require('component')

-- Retrieves current's function and returns it in a formatted string
local get_current_function = function()
	local current_function = ""
	local filename = vim.fn.expand("%:t:r")
	local icon = "ƒ"

	if vim.b.lsp_current_function == nil or vim.b.lsp_current_function == "" or vim.b.lsp_current_function == filename  then
		return ""
	end

	current_function = vim.b.lsp_current_function

	return icon .. ":" ..  current_function
end

Winbar.eval = function ()
	local winbar = ""

	local current_function = get_current_function()

	if current_function ~= "" then
		winbar = winbar .. component.build_element({
			separator_hl = "SEPARATOR_FUNCTION",
			main_hl = "LSP_FUNCTION",
			bg = ROSE,
			fg = WHITE,
			value = current_function
		})
	end

	return winbar
end

return Winbar
