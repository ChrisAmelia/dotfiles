require('colors')
require('lsp')

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

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.WARN] = " ",
    }
  },

  virtual_text = false,
}

api.nvim_command("hi DiagnosticError guifg=" .. CONIFER)
api.nvim_command("hi DiagnosticWarn  guifg=" .. GOLD)
api.nvim_command("hi DiagnosticHint  guifg=" .. BRILLIANT_ROSE)

api.nvim_command("hi DiagnosticVirtualTextError guifg=Red")
api.nvim_command("hi DiagnosticVirtualTextWarn  guifg=Yellow")
api.nvim_command("hi DiagnosticVirtualTextInfo  guifg=White")
api.nvim_command("hi DiagnosticVirtualTextHint  guifg=White")

api.nvim_command("hi DiagnosticDeprecated  guisp=#FF4040 gui=undercurl")
api.nvim_command("hi DiagnosticUnnecessary guifg=Yellow gui=undercurl")

api.nvim_command("hi DiagnosticUnderlineError guifg=Red gui=underline")
api.nvim_command("hi DiagnosticUnderlineWarn  guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineInfo  guifg=NONE gui=underline")
api.nvim_command("hi DiagnosticUnderlineHint  guifg=NONE gui=underline")

vim.keymap.set('n', '<Leader>e', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

vim.keymap.set('n', '<leader>de', function()
    vim.diagnostic.jump({count = 1, severity = vim.diagnostic.severity.ERROR} )
end, { desc = "Jump to next error" })

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

local ensure_installed = {
  "java",
  "lua",
  "rust",
}

local installed = require'nvim-treesitter.config'.get_installed()
local to_install = vim.iter(ensure_installed)
  :filter(function(parser) return not vim.tbl_contains(installed, parser) end)
  :totable( )
require'nvim-treesitter'.install(to_install)

---- common {{{{

api.nvim_set_hl(0, "@annotation"                  , { fg = ROSE         })
api.nvim_set_hl(0, "@attribute"                   , { fg = YELLOW       })
api.nvim_set_hl(0, "@constant"                    , { fg = RIPE_LEMON   })
api.nvim_set_hl(0, "@definition.macro"            , { fg = MALIBU       })
api.nvim_set_hl(0, "@function"                    , { fg = INCH_WORM    })
api.nvim_set_hl(0, "@function.macro"              , { fg = MALIBU       })
api.nvim_set_hl(0, "@function.method"             , { fg = INCH_WORM    })
api.nvim_set_hl(0, "@keyword.exception"           , { fg = ROSE         })
api.nvim_set_hl(0, "@keyword.function"            , { fg = ROSE         })
api.nvim_set_hl(0, "@keyword.return"              , { fg = ROSE         })
api.nvim_set_hl(0, "@keyword.storage"             , { fg = MALIBU       })
api.nvim_set_hl(0, "@markup.link.url"             , { fg = YELLOW       })
api.nvim_set_hl(0, "@module"                      , { fg = NAVAJO_WHITE })
api.nvim_set_hl(0, "@punctuation.bracket"         , { fg = WHITE        })
api.nvim_set_hl(0, "@string.regexp"               , { fg = SKY_BLUE     })
api.nvim_set_hl(0, "@string.special.url"          , { fg = YELLOW       })
api.nvim_set_hl(0, "@tag"                         , { fg = YELLOW       })
api.nvim_set_hl(0, "@tag.attribute"               , { fg = YELLOW       })
api.nvim_set_hl(0, "@tag.delimiter"               , { fg = YELLOW       })
api.nvim_set_hl(0, "@type.builtin"                , { fg = MALIBU       })
api.nvim_set_hl(0, "@type.qualifier"              , { fg = ROSE         })
api.nvim_set_hl(0, "@variable"                    , { fg = SOFT_AMBER   })
api.nvim_set_hl(0, "@variable.builtin"            , { fg = ROSE         })
api.nvim_set_hl(0, "@variable.member"             , { fg = SOFT_AMBER   })
api.nvim_set_hl(0, "@variable.parameter"          , { fg = MAYA_BLUE    })
api.nvim_set_hl(0, "@variable.parameter.reference", { fg = MAYA_BLUE    })
api.nvim_set_hl(0, "@variable.regex"              , { fg = SKY_BLUE     })

---- }}}}

--- elixir {{{

api.nvim_set_hl(0, "@comment.elixir", { fg = CROCODILE })
api.nvim_set_hl(0, "@comment.documentation.elixir", { fg = CROCODILE })
api.nvim_set_hl(0, "@module.elixir", { fg = MALIBU })
api.nvim_set_hl(0, "@string.special.symbol.elixir", { fg = GOLDEN_SAND })

--- }}}

---- html {{{{

api.nvim_set_hl(0 , "@operator.html"      , { fg = GREEN_YELLOW })
api.nvim_set_hl(0 , "@tag.attribute.html" , { fg = GREEN_YELLOW })
api.nvim_set_hl(0 , "@tag.delimiter.html" , { fg = WHITE        })
api.nvim_set_hl(0 , "@tag.html"           , { fg = ROSE         })

---}}}}

---- java {{{{

api.nvim_set_hl(0, "@constant.java", { fg = SOFT_AMBER, italic = true })
api.nvim_set_hl(0, "@method.java"  , { fg = INCH_WORM,  bold   = true })

---- }}}}

---- rust {{{{

api.nvim_set_hl(0 , "@function.call.rust"           , { fg = INCH_WORM                })
api.nvim_set_hl(0 , "@function.macro.rust"          , { fg = BURNING_ORANGE           })
api.nvim_set_hl(0 , "@function.rust"                , { fg = INCH_WORM                })
api.nvim_set_hl(0 , "@keyword.exception.rust"       , { link = "@function.macro.rust" })
api.nvim_set_hl(0 , "@keyword.storage.lifetime.rust", { fg = HOT_PINK                 })
api.nvim_set_hl(0 , "@type.rust"                    , { fg = TEXAS_ROSE               })
api.nvim_set_hl(0 , "@variable.member.rust"         , { fg = GREEN_YELLOW             })

--- }}}}

---- git {{{{

api.nvim_set_hl(0, "@diff.delta", { bg = FLAX,      fg = FUSCOUS_GRAY })
api.nvim_set_hl(0, "@diff.minus", { bg = FAIR_PINK, fg = MONARCH      })
api.nvim_set_hl(0, "@diff.plus" , { bg = SCANDAL,   fg = JEWEL        })
api.nvim_set_hl(0, "diffAdded"  , { bg = SCANDAL,   fg = JEWEL        })
api.nvim_set_hl(0, "diffFile"   , { bg = ENDEAVOUR, fg = WHITE        })
api.nvim_set_hl(0, "diffLine"   , {                 fg = HOT_PINK     })
api.nvim_set_hl(0, "diffOldFile", {                 fg = CROCODILE    })
api.nvim_set_hl(0, "diffRemoved", { bg = FAIR_PINK, fg = MONARCH      })
api.nvim_set_hl(0, "diffSubname", {                 fg = WHITE        })

--- }}}}

---- gitcommit {{{{

api.nvim_set_hl(0, "gitcommitBranch",        { bg = JEWEL,         fg = INCH_WORM    })
api.nvim_set_hl(0, "gitcommitSelectedFile",  { bg = MEDIUM_PURPLE, fg = WHITE        })
api.nvim_set_hl(0, "gitcommitUntrackedFile", { bg = GRAY,          fg = NAVAJO_WHITE })

---}}}}

-- }}}

-- nvim-ts-autotag {{{

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
})

-- }}}

-- LeaderF {{{

vim.g.Lf_PreviewInPopup = 1
vim.g.Lf_WindowPosition = 'popup'
vim.g.Lf_PopupWidth = 0.70
vim.g.Lf_PopupPreviewPosition = 'cursor'
vim.g.Lf_WildIgnore = {
  dir = { 'target', 'bin', '_build' }
}

vim.keymap.set("n" , "<C-n>"      , ":Leaderf file<CR>"        )
vim.keymap.set("n" , "<Leader>rg" , ":Leaderf rg -i -g '!git' ")
vim.keymap.set("n" , "<Leader>rc" , ":LeaderfRgRecall<CR>"     )
vim.keymap.set("n" , "<Leader>f"  , ":LeaderfFunction<CR>"     )

vim.g.Lf_PreviewResult = { File = 0, Rg = 0, Function = 0, Buffer = 0 }

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
vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = 'rounded' }) end)
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

api.nvim_command("hi BufferCurrent       guibg=" .. MAYA_BLUE .. " guifg=WHITE")
api.nvim_command("hi BufferCurrentMod    guibg=" .. MAYA_BLUE .. " guifg=WHITE")
api.nvim_command("hi BufferCurrentIndex  guibg=" .. MAYA_BLUE .. " guifg=WHITE")
api.nvim_command("hi BufferCurrentSign   guibg=" .. MAYA_BLUE .. " guifg=WHITE")
api.nvim_command("hi BufferCurrentTarget guibg=" .. MAYA_BLUE .. " guifg=WHITE")
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
  Constant      = '  ',
  Constructor   = '  ',
  Enum          = '  ',
  EnumMember    = '  ',
  Event         = '  ',
  Field         = '  ',
  File          = '  ',
  Folder        = '  ',
  Function      = ' ƒ ',
  Interface     = '  ',
  Keyword       = ' 󰌆 ',
  Method        = ' ƒ ',
  Module        = ' 󰕳 ',
  Operator      = '  ',
  Property      = '  ',
  Reference     = '  ',
  Snippet       = '  ',
  Struct        = '  ',
  Text          = '  ',
  TypeParameter = '  ',
  Unit          = '  ',
  Value         = ' 󰰫 ',
  Variable      = ' 𝑋 ',
}

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

    documentation = {
      border = "rounded",
      winhighlight = "Normal:PMenu",
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
    { name = 'nvim_lua '},
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

-- fidget {{{

require"fidget".setup{}

-- }}}

-- spectre {{{{

require('spectre').setup()

-- }}}

-- codecompanion {{{

local adapter = "mistral"

require("codecompanion").setup({

  strategies = {
    chat = {
      adapter = adapter,
    },
    inline = {
      adapter = adapter,
    },
  },

  adapters = {
    http = {
      mistral = function()
        local file = io.open(os.getenv("HOME") .. "/.config/" .. adapter .. "/key", "r")
        local api_key = ""
        if file ~= nil then
          api_key = file:read()
          file:close()
        end

        return require("codecompanion.adapters").extend(adapter, {
          schema = {
            model = {
            },
          },
          env = {
            api_key = api_key
          },
        })
      end,
    },
  },
})

-- }}}

-- render-markdown {{{

require('render-markdown').setup({
  checkbox = {
    enabled = true,
    render_modes = false,
    right_pad = 1,
    unchecked = {
      icon = '󰄱 ',
      highlight = 'RenderMarkdownUnchecked',
      scope_highlight = nil,
    },
    checked = {
      icon = '󰱒 ',
      highlight = 'RenderMarkdownChecked',
      scope_highlight = nil,
    },
    custom = {
      todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
    },
  },
})

-- }}}

-- lsp-endhints {{{

require("lsp-endhints").setup {
  icons = {
    type = " ",
    parameter = "󰏪 ",
    offspec = " ", -- hint kind not defined in official LSP spec
    unknown = " ", -- hint kind is nil
  },
  label = {
    truncateAtChars = 20,
    padding = 1,
    marginLeft = 0,
    sameKindSeparator = ", ",
  },
  extmark = {
    priority = 50,
  },
  autoEnableHints = true,
}
vim.api.nvim_set_hl(0, "LspInlayHint", { bg = MAKO, fg = WHITE })

-- }}}

-- nvim-eldoc {{{

require("nvim-eldoc").setup()
api.nvim_set_hl(0, "EldocCur",  { fg = GOLD })

-- }}}

-- FzfLua {{{{

vim.keymap.set("n", "<leader>dc", "<cmd>FzfLua diagnostics_document<cr>")

require'fzf-lua'.setup {
  winopts = {
    preview = {
      hidden = true,
    }
  }
}

-- }}}

-- tiny-glimmer.nvim {{{

api.nvim_set_hl(0, "HlTinyGlimmerUndo", { bg = ROSE, fg = "none" })
api.nvim_set_hl(0, "HlTinyGlimmerUndoTo", { bg = CROCODILE, fg = "none" })

require("tiny-glimmer").setup({
    enabled = true,

    overwrite = {
      -- Paste operation animation
      paste = {
        enabled = true,
        default_animation = "left_to_right",
      },

      -- Undo operation animation
      undo = {
        enabled = true,
        default_animation = {
          name = "left_to_right",
          settings = {
            from_color = "HlTinyGlimmerUndo",
            to_color = "HlTinyGlimmerUndoTo"
          },
        },
        undo_mapping = "u",
      },
    },

    animations = {
      fade = {
        max_duration = 100,
        min_duration = 100,
      },

      left_to_right = {
        max_duration = 150,
        min_duration = 150,
      },
    },
})

-- }}}

--- neotest {{{

require("neotest").setup({
  output = { open_on_run = true },
  adapters = {
    require("neotest-elixir")({
      -- The Mix task to use to run the tests
      -- Can be a function to return a dynamic value.
      -- Default: "test"
      --- mix_task = {"my_custom_task"},

      -- Other formatters to pass to the test command as the formatters are overridden
      -- Can be a function to return a dynamic value.
      -- Default: {"ExUnit.CLIFormatter"}
      --- extra_formatters = {"ExUnit.CLIFormatter", "ExUnitNotifier"},

      -- Extra test block identifiers
      -- Can be a function to return a dynamic value.
      -- Block identifiers "test", "feature" and "property" are always supported by default.
      -- Default: {}
      --- extra_block_identifiers = {"test_with_mock"},

      -- Extra arguments to pass to mix test
      -- Can be a function that receives the position, to return a dynamic value
      -- Default: {}
      args = {"--trace"},

      -- Command wrapper
      -- Must be a function that receives the mix command as a table, to return a dynamic value
      -- Default: function(cmd) return cmd end
      post_process_command = function(cmd)
        return vim.iter({{"env", "FOO=bar"}, cmd}):flatten():totable()
      end,

      -- Delays writes so that results are updated at most every given milliseconds
      -- Decreasing this number improves snappiness at the cost of performance
      -- Can be a function to return a dynamic value.
      -- Default: 1000
      write_delay = 1000,

      -- The pattern to match test files
      -- Default: "_test.exs$"
      test_file_pattern = ".test.exs$",

      -- Function to determine whether a directory should be ignored
      -- By default includes root test directory and umbrella apps' test directories
      -- Params:
      -- - name (string) - Name of directory
      -- - rel_path (string) - Path to directory, relative to root
      -- - root (string) - Root directory of project
      filter_dir = function(name, rel_path, root)
        return rel_path == "test"
            or rel_path == "lib"
            or vim.startswith(rel_path, 'test/')
            or vim.startswith(rel_path, 'lib/')
      end,
    }),
  }
})

--- }}}
