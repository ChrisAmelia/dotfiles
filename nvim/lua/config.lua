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

api.nvim_set_hl(0, "Annotation"        ,  { fg = YELLOW     })
api.nvim_set_hl(0, "Boolean"           ,  { fg = ROSE       })
api.nvim_set_hl(0, "Conditional"       ,  { fg = ROSE       })
api.nvim_set_hl(0, "Constructor"       ,  { fg = ROSE       })
api.nvim_set_hl(0, "Field"             ,  { fg = SOFT_AMBER })
api.nvim_set_hl(0, "Include"           ,  { fg = ROSE       })
api.nvim_set_hl(0, "Keyword"           ,  { fg = ROSE       })
api.nvim_set_hl(0, "KeywordFunction"   ,  { fg = MALIBU     })
api.nvim_set_hl(0, "KeywordOperator"   ,  { fg = ROSE       })
api.nvim_set_hl(0, "MethodCall"        ,  { fg = YELLOW     })
api.nvim_set_hl(0, "Number"            ,  { fg = HELIOTROPE })
api.nvim_set_hl(0, "Operator"          ,  { fg = YELLOW     })
api.nvim_set_hl(0, "Parameter"         ,  { fg = MAYA_BLUE  })
api.nvim_set_hl(0, "ParameterReference",  { fg = SCARLET    })
api.nvim_set_hl(0, "Property"          ,  { fg = MALIBU     })
api.nvim_set_hl(0, "PuncBracket"       ,  { fg = WHITE      })
api.nvim_set_hl(0, "Repeat"            ,  { fg = ROSE       })
api.nvim_set_hl(0, "StorageClass"      ,  { fg = MALIBU     })
api.nvim_set_hl(0, "String"            ,  { fg = FLAX       })
api.nvim_set_hl(0, "Todo"              ,  { fg = FLAX       })
api.nvim_set_hl(0, "Type"              ,  { fg = MALIBU     })
api.nvim_set_hl(0, "TypeBuiltin"       ,  { fg = ROSE       })
api.nvim_set_hl(0, "variable"          ,  { fg = SOFT_AMBER })

api.nvim_set_hl(0, "@annotation"          , { fg = ROSE         })
api.nvim_set_hl(0, "@attribute"           , { fg = YELLOW       })
api.nvim_set_hl(0, "@constant"            , { fg = RIPE_LEMON   })
api.nvim_set_hl(0, "@constant.java"       , { fg = SOFT_AMBER, italic = true   })
api.nvim_set_hl(0, "@definition.macro"    , { fg = MALIBU       })
api.nvim_set_hl(0, "@exception"           , { fg = ROSE         }) -- to be deprecated for '@keyword.exception'
api.nvim_set_hl(0, "@field"               , { fg = SOFT_AMBER   }) -- to be deprecated for '@variable.member'
api.nvim_set_hl(0, "@function"            , { fg = INCH_WORM    })
api.nvim_set_hl(0, "@function.macro"      , { fg = MALIBU       })
api.nvim_set_hl(0, "@keyword.function"    , { fg = ROSE         })
api.nvim_set_hl(0, "@keyword.return"      , { fg = ROSE         })
api.nvim_set_hl(0, "@method"              , { fg = INCH_WORM    }) -- to be deprecated for '@function.method'
api.nvim_set_hl(0, "@namespace"           , { fg = NAVAJO_WHITE }) -- to be deprecated for '@module'
api.nvim_set_hl(0, "@parameter"           , { fg = MAYA_BLUE    }) -- to be deprecated for '@variable.parameter'
api.nvim_set_hl(0, "@parameter.reference" , { fg = MAYA_BLUE    }) -- to be deprecated for '@variable.parameter.reference'
api.nvim_set_hl(0, "@punctuation.bracket" , { fg = WHITE        })
api.nvim_set_hl(0, "@string.regex"        , { fg = SKY_BLUE     }) -- to be deprecated for '@variable.regexp'
api.nvim_set_hl(0, "@storageclass"        , { fg = MALIBU       }) -- to be deprecated for '@keyword.storage'
api.nvim_set_hl(0, "@tag"                 , { fg = YELLOW       })
api.nvim_set_hl(0, "@tag.attribute"       , { fg = YELLOW       })
api.nvim_set_hl(0, "@tag.delimiter"       , { fg = YELLOW       })
api.nvim_set_hl(0, "@text"                , { fg = YELLOW       }) -- to be deprecated for '@markup.*'
api.nvim_set_hl(0, "@text.uri"            , { fg = YELLOW       }) -- to be deprecated for '@markup.link.url'
api.nvim_set_hl(0, "@type.builtin"        , { fg = MALIBU       })
api.nvim_set_hl(0, "@type.qualifier"      , { fg = ROSE         })
api.nvim_set_hl(0, "@variable"            , { fg = SOFT_AMBER   })
api.nvim_set_hl(0, "@variable.builtin"    , { fg = ROSE         })

api.nvim_set_hl(0, "@text.reference.markdown_inline"    , { fg = ROSE         })

api.nvim_set_hl(0, "@method.java"         , { fg = INCH_WORM, bold = true})

-- rust
api.nvim_set_hl(0, "@exception.rust"            , { fg = SANDY_BROWN            }) -- to be deprecated for '@keyword.exception.rust'
api.nvim_set_hl(0, "@field.rust"                , { fg = GREEN_YELLOW           }) -- to be deprecated for '@variable.member.rust'
api.nvim_set_hl(0, "@function.rust"             , { fg = INCH_WORM, bold = true })
api.nvim_set_hl(0, "@function.call.rust"        , { fg = INCH_WORM              })
api.nvim_set_hl(0, "@storageclass.lifetime.rust", { fg = HOT_PINK               }) -- to be deprecated for '@keyword.storage.lifetime.rust'

-- Git
api.nvim_set_hl(0, "diffAdded",   { bg = SCANDAL, fg = JEWEL     })
api.nvim_set_hl(0, "diffFile",    { bg = ENDEAVOUR, fg = WHITE   })
api.nvim_set_hl(0, "diffLine",    { fg = HOT_PINK                })
api.nvim_set_hl(0, "diffOldFile", { fg = CROCODILE               })
api.nvim_set_hl(0, "diffRemoved", { bg = FAIR_PINK, fg = MONARCH })
api.nvim_set_hl(0, "diffSubname", { fg = WHITE                   })

api.nvim_set_hl(0, "gitcommitBranch", { bg = JEWEL, fg = INCH_WORM })
api.nvim_set_hl(0, "gitcommitSelectedFile", { bg = MEDIUM_PURPLE, fg = WHITE })
api.nvim_set_hl(0, "gitcommitUntrackedFile", { bg = GRAY, fg = NAVAJO_WHITE })

-- https://github.com/nvim-treesitter/nvim-treesitter/commit/1ae9b0e4558fe7868f8cda2db65239cfb14836d0
api.nvim_set_hl(0, "@diff.delta"                      , { bg = FLAX, fg = FUSCOUS_GRAY })
api.nvim_set_hl(0, "@diff.minus"                      , { bg = FAIR_PINK, fg = MONARCH })
api.nvim_set_hl(0, "@diff.plus"                       , { bg = SCANDAL, fg = JEWEL     })
api.nvim_set_hl(0, "@function.method"                 , { fg = INCH_WORM               })
api.nvim_set_hl(0, "@keyword.exception"               , { fg = ROSE                    })
api.nvim_set_hl(0, "@keyword.storage"                 , { fg = MALIBU                  })
api.nvim_set_hl(0, "@markup"                          , { fg = YELLOW                  })
api.nvim_set_hl(0, "@markup.link.url"                 , { fg = YELLOW                  })
api.nvim_set_hl(0, "@markup.reference.markdown_inline", { fg = ROSE                    })
api.nvim_set_hl(0, "@module"                          , { fg = NAVAJO_WHITE            })
api.nvim_set_hl(0, "@string.regexp"                   , { fg = SKY_BLUE                })
api.nvim_set_hl(0, "@string.special.url"              , { fg = YELLOW                  })
api.nvim_set_hl(0, "@variable.member"                 , { fg = SOFT_AMBER              })
api.nvim_set_hl(0, "@variable.parameter"              , { fg = MAYA_BLUE               })
api.nvim_set_hl(0, "@variable.parameter.reference"    , { fg = MAYA_BLUE               })

api.nvim_set_hl(0, "@variable.member.rust"         , { fg = SANDY_BROWN })
api.nvim_set_hl(0, "@keyword.exception.rust"       , { fg = SANDY_BROWN })
api.nvim_set_hl(0, "@keyword.storage.lifetime.rust", { fg = HOT_PINK    })

-- }}}

-- nvim-ts-autotag {{{
require("nvim-treesitter.parsers").list.xml = {
	install_info = {
		url = "https://github.com/Trivernis/tree-sitter-xml",
		files = { "src/parser.c" },
		generate_requires_npm = true,
		branch = "main",
	},
	filetype = "xml",
}


require'nvim-treesitter.configs'.setup {
	autotag = {
		enable = true,
		filetypes = { "xml" },
	}
}

-- }}}

-- LeaderF {{{

vim.g.Lf_PreviewInPopup = 1
vim.g.Lf_WindowPosition = 'popup'
vim.g.Lf_PopupWidth = 0.70
vim.g.Lf_PopupPreviewPosition = 'cursor'

vim.keymap.set("n" , "<C-n>"      , ":Leaderf file<CR>"        )
vim.keymap.set("n" , "<Leader>rg" , ":Leaderf rg -i -g '!git' ")
vim.keymap.set("n" , "<Leader>rc" , ":LeaderfRgRecall<CR>"     )
vim.keymap.set("n" , "<Leader>f"  , ":LeaderfFunction<CR>"     )

vim.g.Lf_PreviewResult = { File = 0, Rg = 0, Function = 0, Buffer = 0 }

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
		initial_mode = "normal",
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
		color_devicons = true,
		use_less = true,
		scroll_strategy = 'cycle',
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
		preview = false,
		-- file_previewer = require'telescope.previewers'.cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
		-- grep_previewer = require'telescope.previewers'.vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
		-- qflist_previewer = require'telescope.previewers'.qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

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

require'barbar'.setup {
	icons = {
		filetype = {
			enabled = false,
		}
	},
	animation = true,
	semantic_letters = true,
	clickable = false,
	letters = 'asdfjkl;ghnmxcbziowerutyqpASDFJKLGHNMXCBZIOWERUTYQP',
	maximum_padding = 4,
	maximum_length = 50,
	auto_hide = true,
}

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
	Class         = '  ',
	Color         = '  ',
	Constant      = '  ',
	Constructor   = '  ',
	Enum          = ' 識',
	EnumMember    = ' 識',
	Event         = '  ',
	Field         = '  ',
	File          = '  ',
	Folder        = '  ',
	Function      = '  ',
	Interface     = '  ',
	Keyword       = ' 󰌆 ',
	Method        = '  ',
	Module        = '  ',
	Operator      = '  ',
	Property      = '  ',
	Reference     = '  ',
	Snippet       = '  ',
	Struct        = '  ',
	Text          = '  ',
	TypeParameter = '  ',
	Unit          = '  ',
	Value         = '  ',
	Variable      = ' 𝑋 ',
}

local luasnip = require("luasnip")

cmp.setup {
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},

	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
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
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	sources = {
		{
			name = 'nvim_lsp',
			entry_filter = function (entry)
				-- Disable snippet suggestions from LSP
				if vim.bo.filetype == 'java' then
					return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
				end
				return entry
			end
		},
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
		{ name = 'vsnip' },
	},
}

api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = WHITE, bg = "NONE", strikethrough = true })
api.nvim_set_hl(0, "CmpItemAbbrMatch",      { fg = WHITE, bg = HAVELOCK_BLUE })
api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = WHITE, bg = HAVELOCK_BLUE })

api.nvim_set_hl(0, "CmpItemKindClass",         { fg = WHITE, bg = CRIMSON       })
api.nvim_set_hl(0, "CmpItemKindConstant",      { fg = WHITE, bg = RANGITOTO     })
api.nvim_set_hl(0, "CmpItemKindConstructor",   { fg = BLACK, bg = WHITE         })
api.nvim_set_hl(0, "CmpItemKindEnum",          { fg = WHITE, bg = CONGO_BROWN   })
api.nvim_set_hl(0, "CmpItemKindEnumMember",    { fg = WHITE, bg = CONGO_BROWN   })
api.nvim_set_hl(0, "CmpItemKindEvent",         { fg = GOLD,  bg = BLACK         })
api.nvim_set_hl(0, "CmpItemKindField",         { fg = WHITE, bg = GREEN_HAZE    })
api.nvim_set_hl(0, "CmpItemKindFile",          { fg = WHITE, bg = BIG_STONE     })
api.nvim_set_hl(0, "CmpItemKindFolder",        { fg = BLACK, bg = FLAX          })
api.nvim_set_hl(0, "CmpItemKindFunction",      { fg = WHITE, bg = MEDIUM_PURPLE })
api.nvim_set_hl(0, "CmpItemKindInterface",     { fg = WHITE, bg = BLUE_CHILL    })
api.nvim_set_hl(0, "CmpItemKindKeyword",       { fg = WHITE, bg = HOT_PINK      })
api.nvim_set_hl(0, "CmpItemKindMethod",        { fg = WHITE, bg = MEDIUM_PURPLE })
api.nvim_set_hl(0, "CmpItemKindModule",        { fg = WHITE, bg = LOTUS         })
api.nvim_set_hl(0, "CmpItemKindOperator",      { fg = WHITE, bg = "#A377BF"     })
api.nvim_set_hl(0, "CmpItemKindProperty",      { fg = WHITE, bg = ALTO          })
api.nvim_set_hl(0, "CmpItemKindReference",     { fg = WHITE, bg = RUST          })
api.nvim_set_hl(0, "CmpItemKindSnippet",       { fg = WHITE, bg = SUNSET_ORANGE })
api.nvim_set_hl(0, "CmpItemKindStruct",        { fg = WHITE, bg = CAMARONE      })
api.nvim_set_hl(0, "CmpItemKindText",          { fg = WHITE, bg = BLUE_RIBBON   })
api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = WHITE, bg = "#58B5A8"     })
api.nvim_set_hl(0, "CmpItemKindUnit",          { fg = WHITE, bg = ALTO          })
api.nvim_set_hl(0, "CmpItemKindVariable",      { fg = WHITE, bg = FUSCOUS_GRAY  })
api.nvim_set_hl(0, "CmpItemKindValue",         { fg = WHITE, bg = WOODSMOKE     })

-- }}}

-- indent_blankline {{{

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup {
	indent = { highlight = highlight },
	scope = { char = "▍", highlight = highlight }
}

-- }}}

-- nvim-autopairs {{{

require("nvim-autopairs").setup {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
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

-- rust-tools {{{

local rt = require("rust-tools")

local opts = {
	tools = {
		-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
		reload_workspace_from_cargo_toml = true,

		-- These apply to the default RustSetInlayHints command
		inlay_hints = {
			-- automatically set inlay hints (type hints)
			-- default: true
			auto = true,

			-- whether to show parameter hints with the inlay hints or not
			-- default: true
			show_parameter_hints = true,

			-- prefix for parameter hints
			-- default: "<-"
			parameter_hints_prefix = " ",

			-- prefix for all the other hints (type, chaining)
			-- default: "=>"
			other_hints_prefix = " ",

			-- The color of the hints
			highlight = "StorageClass";
		},
	},

	server = {
		-- standalone file support
		-- setting it to false may improve startup time
		standalone = true,

		on_attach = function ()
			vim.keymap.set("n", "<leader>dc", ":Telescope diagnostics bufnr=0<cr>")
			vim.keymap.set('n', '<leader>gr', ":Telescope lsp_references<cr>", { buffer = 0 })
		end,
	},
}

rt.setup(opts)

-- }}}

-- fidget {{{

require"fidget".setup{}

-- }}}


local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.gitcommit = {
    install_info = {
        url = "https://github.com/gbprod/tree-sitter-gitcommit",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "main",
    },
    filetype = "gitcommit",
    maintainers = {  "@gbprod" },
}

api.nvim_set_hl(0, "@attribute.diff", { fg = "#CDB9F2" })
api.nvim_set_hl(0, "@function.diff", { fg = "#8fBFFC" })
api.nvim_set_hl(0, "@text.diff.delete", { bg = "#FFEBE9", fg = "#82071E", })
api.nvim_set_hl(0, "@text.diff.add", { bg = "#DAFBE1", fg = "#116329" })
api.nvim_set_hl(0, "@function.diff", { bg = "#8FBFFC", fg = "#0550AE" })
api.nvim_set_hl(0, "@text.reference.gitcommit", { bg = "#BFFC8F", fg = "#357503" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

require('spectre').setup()
