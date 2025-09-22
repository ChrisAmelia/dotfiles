local lspconfig = require 'lspconfig'

--- Document highlights
local function document_highlight()
	vim.api.nvim_exec([[
		hi LspReferenceRead  guibg=#121111 guifg=#FFFF00
		hi LspReferenceText  guibg=#121111 guifg=#FFFF00
		hi LspReferenceWrite guibg=#121111 guifg=#FFFF00

		augroup lsp_document_highlight
			autocmd!
			autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
	]], false)
end

--- Custom attach
local on_attach_vim = function(client, bufnr)
	document_highlight()
	vim.keymap.set("n", "<leader>dc", "<cmd>FzfLua diagnostics_document<cr>")
	vim.keymap.set('n', '<leader>gr', ":Telescope lsp_references<cr>", { buffer = 0 })

	if client.server_capabilities.inlayHintProvider then
		vim.api.nvim_set_hl(0, "LspInlayHint", { bg = MAKO, fg = WHITE })
		vim.lsp.inlay_hint.enable(true, nil)
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}

--- Disable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})


-- JDTLS {{{
-- local root_pattern = lspconfig.util.root_pattern
-- 
-- lspconfig.jdtls.setup {
-- 	root_dir = root_pattern(".git"),
-- 	on_attach = on_attach_vim,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		java = {
-- 			completion = {
-- 				-- Defines the type filters.
-- 				-- All types whose fully qualified name matches the selected filter strings will be ignored in content assist
-- 				-- or quick fix proposals and when organizing imports.
-- 				-- For example 'java.awt.*' will hide all types from the awt packages.
-- 				filteredTypes = {
-- 					"antlr.*",
-- 					"bitronix.*",
-- 					"com.docusign.*",
-- 					"com.lowagi.*",
-- 					"com.sun.*",
-- 					"org.apache.xmlbeans.*"
-- 				},
-- 
-- 				-- When set to true, method arguments are guessed when a method is selected from as list of code assist proposals.
-- 				guessMethodArguments = false,
-- 			},
-- 
-- 			configuration = {
-- 				-- Controls whether to exclude extension-generated project settings files (.project, .classpath, .factorypath, .settings/)
-- 				-- from the file explorer.
-- 				checkProjectSettingsExclusions = false,
-- 			},
-- 
-- 			format = {
-- 				settings = {
-- 					-- Optional formatter profile name from the Eclipse formatter settings.
-- 					profile = "GoogleStyle",
-- 
-- 					-- Specifies the url or file path to the Eclipse formatter xml settings.
-- 					url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
-- 				},
-- 			},
-- 
-- 			-- Enable/disable the implementations code lens.
-- 			implementationsCodeLens = {
-- 				enabled = false,
-- 			},
-- 
-- 			maven = {
-- 				-- Enable/disable download of Maven source artifacts as part of importing Maven projects.
-- 				downloadSources = true,
-- 			},
-- 
-- 			-- Enable/disable the references code lens.
-- 			referencesCodeLens = {
-- 				enabled = true,
-- 			},
-- 
-- 			-- Automatically show build status on startup.
-- 			showBuildStatusOnStart = {
-- 				enabled = true,
-- 			},
-- 
-- 			-- Enable/disable the signature help.
-- 			signatureHelp = {
-- 				enabled = true,
-- 			},
-- 		}
-- 	},
-- }
-- -- }}}
-- 


-- LUA_LS {{{
vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath('config')
				and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
				then
					return
				end
			end
	end,

	settings = {
		Lua = {
			hint = {
				enable = true
			},
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true)
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	}
});

vim.lsp.enable('lua_ls')
-- }}}

-- GOPLS {{{
lspconfig.gopls.setup{
	on_attach = on_attach_vim,
	capabilities = capabilities,
	cmd = {"gopls", "serve"},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			linksInHover = false,
			codelenses = {
				generate = true,
				gc_details = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_depdendency = true,
				vendor = true,
			},
			usePlaceholders = true,
		},
	},
}
-- }}}
