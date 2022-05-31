local Module = {}

require('colors')

local utils = require('utils')

-- Retrieves current's function and returns it in a formatted string
local getCurrentFunction = function()
	local currentFunction = ""
	local filename = vim.fn.expand("%:t:r")
	local icon = "ƒ"

	if vim.b.lsp_current_function == nil or vim.b.lsp_current_function == "" or vim.b.lsp_current_function == filename  then
		return ""
	end

	currentFunction = vim.b.lsp_current_function

	return icon .. ":" ..  currentFunction
end

Module.eval = function ()
	local winbar = ""

	local currentFunction = getCurrentFunction()

	if currentFunction ~= "" then
		winbar = winbar .. utils.buildElement("SEPARATOR_FUNCTION", "LSP_FUNCTION", ROSE, WHITE, currentFunction)
	end

	return winbar
end

return Module
