local Component = {}

SEPARATOR_LEFT = ""
SEPARATOR_RIGHT = ""

vim.api.nvim_command("hi StatusLine guibg=none gui=nocombine")
vim.api.nvim_command("hi WinBar guibg=none gui=nocombine")

Component.buildElement = function (separatorHighlight, mainHighlight, backgroundColor, textColor, value)
	local buffer = ""

	vim.api.nvim_command("hi " .. separatorHighlight .. " guifg=" .. backgroundColor  .. " guibg=none")
	buffer = buffer .. "%#" .. separatorHighlight .. "#"
	buffer = buffer .. SEPARATOR_LEFT

	vim.api.nvim_command("hi " .. mainHighlight .. " guifg=" .. textColor .. " guibg=" .. backgroundColor)
	buffer = buffer .. "%#" .. mainHighlight .. "#"
	buffer = buffer .. value

	vim.api.nvim_command("hi " .. separatorHighlight .. " guifg=" .. backgroundColor  .. " guibg=none")
	buffer = buffer .. "%#" .. separatorHighlight .. "#"
	buffer = buffer .. SEPARATOR_RIGHT

	return buffer
end

return Component
