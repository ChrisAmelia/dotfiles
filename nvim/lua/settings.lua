require('colors')

local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

opt.autoindent    = true    -- Autoindent when starting new line, or using o or O
opt.background    = 'dark'  -- When set to "dark" or "light", adjusts the default color groups for that background type.
opt.clipboard     = "unnamedplus" -- Register clipboard
opt.completeopt   = "menu,menuone,noselect" -- A comma separated list of options for Insert mode completion |ins-completion|
opt.encoding      = 'utf-8' -- Force utf-8 encoding
opt.hlsearch      = true    -- Enable search highlighting.
opt.ignorecase    = true    -- Ignore case when searching
opt.incsearch     = true    -- Enable highlighted case-insensitive incremential search.
opt.laststatus    = 3
opt.modeline      = false   -- Don't parse modelines (google vim modeline vulnerability).
opt.modifiable    = true    -- Make buffer modifiable
opt.mouse         = ''      -- Disable mouse
opt.showmode      = false   -- If in Insert, Replace or Visual mode put a message on the last line.
opt.showcmd       = true    -- Show the size of block one selected in visual mode
opt.showmatch     = true    -- The cursor will briefly jump to the matching brace when you insert one.
opt.splitright    = true    -- When on, splitting a window will put the new window right of the current one.
opt.termguicolors = true    -- Enables 24-bit RGB color in the |TUI|.
opt.ttimeoutlen   = 50      -- Allow for mappings including Esc, while preserving zero timeout after pressing it manually
opt.updatetime    = 100     -- Update time in ms
opt.wildmenu      = true -- Autocomplete commands using nice menu in place of window status. Enable CTRL-N and CTRL-P to scroll through matches.
opt.wildmode      = 'longest:full,full'-- For autocompletion, complete as much as you can.
opt.wildoptions   = 'pum'   -- List of words that change how |cmdline-completion| is done.


opt.shiftwidth = 4 -- When indenting with '>', use spaces width
opt.tabstop    = 4 -- Show existing tab with spaces width


opt.cursorline     = true -- Highlight line under cursor. It helps with navigation.
opt.number         = true -- Show line numbers on the sidebar
opt.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line


opt.fillchars:append { eob = " "}


cmd("colorscheme sublimemonokai")    -- Set colorscheme
cmd("set noswapfile")                -- Disable swap to prevent annoying messages.
cmd("set list lcs=tab:\\│\\ ,eol:↴") -- List mode: Show tabs as CTRL-I is displayed, display $ after end of line.
cmd("syntax on")                     -- See :h :syntax-on


vim.g.mapleader = "," -- Leader map
vim.keymap.set('n', 'p', '"+p', { noremap = true, silent = true })

api.nvim_set_hl(0, "SignColumn" , { bg = "none"      , fg = "none"     })
api.nvim_set_hl(0, "PMenuSel"   , { bg = ABBEY       , fg = "none"     })
api.nvim_set_hl(0, "LineNr"     , { bg = "none"      , fg = "none"     })
api.nvim_set_hl(0, "Normal"     , { bg = "none"      , fg = "none"     })
api.nvim_set_hl(0, "Comment"    , { bg = "none"      , fg = CHARTREUSE })
api.nvim_set_hl(0, "CurSearch"  , { bg = BLUE_RIBBON , fg = WHITE      })
api.nvim_set_hl(0, "PMenu"      , { bg = SHARK       , fg = SILVER     })
api.nvim_set_hl(0, "Visual"     , { bg = SPRING_GREEN, fg = BLACK      })
api.nvim_set_hl(0, "NormalFloat", { bg = SHARK       , fg = "none"     })
api.nvim_set_hl(0, "FloatBorder", { bg = "none"      , fg = SILVER     })
api.nvim_set_hl(0, "ColorColumn", { bg = SHARK       , fg = "none"     })



-- Quick mappings
api.nvim_set_keymap("n", "<leader>w", ":w<CR>",        { noremap = true } )
api.nvim_set_keymap("n", "<leader>q", ":q<CR>",        { noremap = true } )
api.nvim_set_keymap("n", "<c-d>",     "dd",            { noremap = true } )
api.nvim_set_keymap("n", "²",         "0",             { noremap = true } )
api.nvim_set_keymap("n", "<space>",   "i<space><esc>", { noremap = true } )


opt.colorcolumn = "99999" -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/59


-- Highlight to avoid weird visual glitches
api.nvim_command("hi StatusLine guibg=none gui=nocombine")
api.nvim_command("hi WinBar guibg=none gui=nocombine")
