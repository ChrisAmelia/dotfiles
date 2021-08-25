local api = vim.api
local protocol = require'vim.lsp.protocol'
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
local on_attach_vim = function()
	document_highlight()
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = false, -- Enable underline, use default values
	virtual_text = false -- Enable virtual text only on Warning or above, override spacing to 2
}
)

-- JDTLS {{{
local root_pattern = lspconfig.util.root_pattern

lspconfig.jdtls.setup{
	root_dir = root_pattern(".git"),
	on_attach = on_attach_vim,
	capabilities = capabilities,
	settings = {
		java = {
			completion = {
				-- Defines the type filters.
				-- All types whose fully qualified name matches the selected filter strings will be ignored in content assist
				-- or quick fix proposals and when organizing imports.
				-- For example 'java.awt.*' will hide all types from the awt packages.
				filteredTypes = {
					"antlr.*",
					"bitronix.*",
					"com.docusign.*",
					"com.lowagi.*",
					"com.sun.*",
					"org.apache.xmlbeans.*"
				},

				-- When set to true, method arguments are guessed when a method is selected from as list of code assist proposals.
				guessMethodArguments = false,
			},

			configuration = {
				-- Controls whether to exclude extension-generated project settings files (.project, .classpath, .factorypath, .settings/)
				-- from the file explorer.
				checkProjectSettingsExclusions = false,
			},

			format = {
				settings = {
					-- Optional formatter profile name from the Eclipse formatter settings.
					profile = "GoogleStyle",

					-- Specifies the url or file path to the Eclipse formatter xml settings.
					url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
				},
			},

			-- Enable/disable the implementations code lens.
			implementationsCodeLens = {
				enabled = true,
			},

			maven = {
				-- Enable/disable download of Maven source artifacts as part of importing Maven projects.
				downloadSources = true,
			},

			-- Enable/disable the references code lens.
			referencesCodeLens = {
				enabled = true,
			},

			-- Automatically show build status on startup.
			showBuildStatusOnStart = {
				enabled = true,
			},

			-- Enable/disable the signature help.
			signatureHelp = {
				enabled = true,
			},
		}
	},
}
-- }}}

-- SUMNEKO_LUA {{{
local system_name = "Linux"
local sumneko_root_path = vim.fn.stdpath('cache') .. "/lspconfig/sumneko_lua/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

lspconfig.sumneko_lua.setup {
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
	on_attach = on_attach_vim,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Get the language server to recognize LuaJIT globals like `jit` and `bit`
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim', 'use'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
}
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
			codelens = {
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
