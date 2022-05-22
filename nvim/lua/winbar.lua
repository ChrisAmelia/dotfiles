local Module = {}

require('colors')

HIGHLIGHT_FUNCTION = "LSP_FUNCTION"

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
		vim.api.nvim_command("hi " .. HIGHLIGHT_FUNCTION .. " guifg=" .. INCH_WORM .. " guibg=none gui=bold")
		winbar = winbar .. "%#" .. HIGHLIGHT_FUNCTION .. "#"
		winbar = winbar .. currentFunction
	end

	return winbar
end

return Module
