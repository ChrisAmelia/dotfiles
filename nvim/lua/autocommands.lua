local api = vim.api

-- Retrieve current git branch's name and set it in buffer
api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, { callback = function ()
	local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
	local branchName = handle:read("*a")

	handle:close()

	vim.b.gitBranchName = branchName
end})
