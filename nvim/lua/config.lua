require('colors')
require('lsp')

local fn = vim.fn
local api = vim.api

-- Built-in plugins {{{
local disabledPlugins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
}

for _, plugin in pairs(disabledPlugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- }}}

-- Diagnostics {{{

fn.sign_define("DiagnosticSignHint",  { text = "",  texthl = "DiagnosticHint"  })
fn.sign_define("DiagnosticSignError", { text = "",  texthl = "DiagnosticError" })
fn.sign_define("DiagnosticSignWarn",  { text = " ", texthl = "DiagnosticWarn"  })
fn.sign_define("DiagnosticSignInfo",  { text = " ", texthl = "DiagnosticInfo"  })

api.nvim_command("hi DiagnosticError guifg=" .. CONIFER)
api.nvim_command("hi DiagnosticWarn  guifg=" .. GOLD)
api.nvim_command("hi DiagnosticHint  guifg=" .. BRILLIANT_ROSE)

api.nvim_command("hi DiagnosticVirtualTextError guifg=Red")
api.nvim_command("hi DiagnosticVirtualTextWarn  guifg=Yellow")
api.nvim_command("hi DiagnosticVirtualTextInfo  guifg=White")
api.nvim_command("hi DiagnosticVirtualTextHint  guifg=White")

api.nvim_command("hi DiagnosticUnderlineError guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineWarn  guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineInfo  guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineHint  guifg=NONE gui=underline")

vim.keymap.set("n" , "<Leader>e"  , vim.diagnostic.open_float)

-- }}}

-- nvim-colorizer {{{

require 'colorizer'.setup {
	'css';
	'javascript';
	'lua';
	html = {
		mode = 'background';
	}
}

-- }}}

-- EasyAlign {{{
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
-- }}}

-- Tree-sitter {{{

require'nvim-treesitter.configs'.setup {
	ensure_installed = "java", "lua", "go", -- one of "all", "language", or a list of languages
	highlight = {
		enable = true,                -- false will disable the whole extension
	},
}

api.nvim_command("hi TSFunctBuiltin guifg=red")
api.nvim_command("hi TSCharacter guifg=red")
api.nvim_command("hi TSLabel guifg=red")
api.nvim_command("hi TSWarning guifg=red")
api.nvim_command("hi TSDanger guifg=red")
api.nvim_command("hi TSNote guifg=red")
api.nvim_command("hi TSEnvironment guifg=red")
api.nvim_command("hi TSEnvironmentName guifg=red")
api.nvim_command("hi TSTag guifg=" .. ROSE)
api.nvim_command("hi TSSymbol guifg=red")


api.nvim_command("hi TSAnnotation           guifg=" .. WHITE)
api.nvim_command("hi TSAttribute            guifg=" .. SCHOOL_BUS_YELLOW)
api.nvim_command("hi TSBoolean              guifg=" .. ROSE)
api.nvim_command("hi TSConditional          guifg=" .. ROSE)
api.nvim_command("hi TSConstant             guifg=" .. RIPE_LEMON)
api.nvim_command("hi TSConstructor          guifg=" .. ROSE)
api.nvim_command("hi TSField                guifg=" .. SOFT_AMBER)
api.nvim_command("hi TSFunction             guifg=" .. INCH_WORM)
api.nvim_command("hi TSInclude              guifg=" .. ROSE)
api.nvim_command("hi TSKeyword              guifg=" .. ROSE)
api.nvim_command("hi TSKeywordFunction      guifg=" .. ROSE)
api.nvim_command("hi TSKeywordOperator      guifg=" .. ROSE)
api.nvim_command("hi TSMethod               guifg=" .. INCH_WORM)
api.nvim_command("hi TSNumber               guifg=" .. HELIOTROPE)
api.nvim_command("hi TSOperator             guifg=" .. SCHOOL_BUS_YELLOW)
api.nvim_command("hi TSParameter            guifg=" .. MAYA_BLUE)
api.nvim_command("hi TSParameterReference   guifg=" .. SCARLET)
api.nvim_command("hi TSProperty             guifg=" .. MALIBU)
api.nvim_command("hi TSPunctBracket         guifg=" .. WHITE)
api.nvim_command("hi TSRepeat               guifg=" .. ROSE)
api.nvim_command("hi TSString               guifg=" .. FLAX)
api.nvim_command("hi TSType                 guifg=" .. MALIBU)
api.nvim_command("hi TSTypeBuiltin          guifg=" .. ROSE)
api.nvim_command("hi TSVariable             guifg=" .. SOFT_AMBER)

-- }}}

-- LeaderF {{{

vim.g.Lf_PreviewInPopup = 1
vim.g.Lf_WindowPosition = 'popup'

vim.keymap.set("n" , "<C-n>"      , ":Leaderf file<CR>"        )
vim.keymap.set("n" , "<Leader>rg" , ":Leaderf rg -i -g '!git' ")
vim.keymap.set("n" , "<Leader>rc" , ":LeaderfRgRecall<CR>"     )
vim.keymap.set("n" , "<Leader>f"  , ":LeaderfFunction<CR>"     )

-- }}}

-- Telescope {{{

vim.keymap.set('n', '<Leader>gr', ":Telescope lsp_references<cr>", { buffer = 0 })
vim.keymap.set('n', '<Leader>dc', ":Telescope diagnostics<cr>", { buffer = 0})

api.nvim_command("hi TelescopeSelection guifg=#FFFF00 gui=bold")
api.nvim_command("hi TelescopeNormal guibg=#00000F")
api.nvim_command("hi TelescopeMatching guifg=#A7EC21")

require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = ">",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_sorter =  require'telescope.sorters'.get_fzy_sorter,
		file_ignore_patterns = {},
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		winblend = 0,
		layout_config = {
			width = 0.75,
			preview_cutoff = 120,
			prompt_position = "top",
		},
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
		color_devicons = true,
		use_less = true,
		scroll_strategy = 'cycle',
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
		file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
		grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
		qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	}
}
-- }}}

-- GitGutter {{{

api.nvim_command("hi DiffAdd    guibg = none guifg = lightgreen")
api.nvim_command("hi DiffDelete guibg = none guifg = red       ")
api.nvim_command("hi DiffChange guibg = none guifg = sandybrown")

vim.keymap.set("n" , "gs"         , ":GitGutterPreviewHunk<CR>" )
vim.keymap.set("n" , "<Leader>gu" , ":GitGutterUndoHunk<CR>"    )
vim.keymap.set("n" , "<Leader>ga" , ":GitGutterStageHunk<CR>"   )
vim.keymap.set("n" , "gp"         , ":GitGutterPreviousHunk<CR>")
vim.keymap.set("n" , "gn"         , ":GitGutterNextHunk<CR>"    )

vim.g.gitgutter_sign_added = '│'
vim.g.gitgutter_sign_modified = '│'
-- }}}

-- LSP Config {{{

vim.keymap.set("n" , "K"          , vim.lsp.buf.hover           )
vim.keymap.set("n" , "gi"         , vim.lsp.buf.implementation  )
vim.keymap.set("i" , "<C-k>"      , vim.lsp.buf.signature_help  )
vim.keymap.set("n" , "gr"         , vim.lsp.buf.references      )
vim.keymap.set("n" , "gW"         , vim.lsp.buf.workspace_symbol)
vim.keymap.set("n" , "gd"         , vim.lsp.buf.definition      )
vim.keymap.set("n" , "<Leader>ac" , vim.lsp.buf.code_action     )
vim.keymap.set("n" , "<Leader>rn" , vim.lsp.buf.rename          )

-- }}}

-- barbar.nvim {{{

local bufferline = {
	icons = 'numbers',
	animation = true,
	semantic_letters = true,
	clickable = false,
	letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
	maximum_padding = 4,
	maximum_length = 50,
	auto_hide = true,
}

vim.g.bufferline = bufferline

api.nvim_command("hi BufferCurrent       guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentMod    guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentIndex  guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentSign   guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferCurrentTarget guibg=" .. MAYA_BLUE)
api.nvim_command("hi BufferInactive      guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferInactiveIndex guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferInactiveSign  guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferInactiveMod   guibg=none guifg=" .. WHITE)
api.nvim_command("hi BufferTabpageFill   guibg=none guifg=" .. WHITE)

vim.keymap.set("n", "<Leader>1", ":BufferGoto 1<CR>")
vim.keymap.set("n", "<Leader>2", ":BufferGoto 2<CR>")
vim.keymap.set("n", "<Leader>3", ":BufferGoto 3<CR>")
vim.keymap.set("n", "<Leader>4", ":BufferGoto 4<CR>")
vim.keymap.set("n", "<Leader>5", ":BufferGoto 5<CR>")
vim.keymap.set("n", "<Leader>6", ":BufferGoto 6<CR>")
vim.keymap.set("n", "<Leader>7", ":BufferGoto 7<CR>")
vim.keymap.set("n", "<Leader>8", ":BufferGoto 8<CR>")
vim.keymap.set("n", "<Leader>9", ":BufferGoto 9<CR>")
vim.keymap.set("n", "<Leader>bd", ":BufferClose<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<CR>")
vim.keymap.set("n", "<Tab>", ":BufferNext<CR>")

-- }}}

-- nvim-cmp {{{

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')

local icons = {
	Text          = ' ',
	Method        = ' ',
	Function      = ' ',
	Constructor   = ' ',
	Field         = '識',
	Variable      = '𝑋 ',
	Class         = ' ',
	Interface     = ' ',
	Module        = ' ',
	Property      = ' ',
	Unit          = ' ',
	Value         = ' ',
	Enum          = ' ',
	Keyword       = ' ',
	Snippet       = '﬌ ',
	Color         = ' ',
	File          = ' ',
	Reference     = ' ',
	Folder        = ' ',
	EnumMember    = ' ',
	Constant      = ' ',
	Struct        = ' ',
	Event         = ' ',
	Operator      = 'ﬦ' ,
	TypeParameter = ' ',
}

cmp.setup {
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},

	formatting = {
		fields = { "kind", "abbr", "menu" },

		format = function(_, vim_item)
			vim_item.menu = vim_item.kind
			vim_item.kind = icons[vim_item.kind]

			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},

	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"]() == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'path'     },
		{ name = 'buffer',
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end
			}
		},
		{ name = 'vsnip'    },
	},
}

api.nvim_command(" highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
api.nvim_command(" highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
api.nvim_command(" highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6")
api.nvim_command(" highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
api.nvim_command(" highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE")
api.nvim_command(" highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE")
api.nvim_command(" highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
api.nvim_command(" highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0")
api.nvim_command(" highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
api.nvim_command(" highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4")
api.nvim_command(" highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4")
-- }}}

-- indent_blankline {{{

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block'}
vim.g.indent_blankline_char_highlight_list = { 'Function', 'Type', 'String', 'Comment', 'Number' }

-- }}}

-- pears.nvim {{{

require "pears".setup(function(conf)
	conf.pair("{", "}")
	conf.expand_on_enter(true)
	conf.preset "tag_matching"
end)

-- }}}

-- hlargs {{{

require('hlargs').setup {
	color = MAYA_BLUE,
	excluded_filetypes = {},
	paint_arg_declarations = true,
	paint_arg_usages = true,
	performance = {
		parse_delay = 1,
		max_iterations = 400
	}
}

-- }}}
