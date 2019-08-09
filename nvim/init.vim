" VIM SETTINGS {{{
"

"Show line numbers on the sidebar
set number

"Ignore case when searching.
set ignorecase

"Turn on filetype plugins (:help filetype-plugin)
filetype plugin indent on
syntax on

"Enable syntax highlighting
if has('syntax')
	syntax enable
endif

"Set background
set background=dark

"Highlight line under cursor. It helps with navigation.
set cursorline

"Show mode in statusbar, not separately.
set noshowmode

"Set mapleader key
let mapleader = ","

"Completion
set omnifunc=syntaxcomplete#Complete

"Force utf-8 encoding
set encoding=utf-8

"Allow for mappings including Esc, while preserving zero timeout after
"pressing it manually
set ttimeoutlen=50

"Show the size of block one selected in visual mode
set showcmd

"Autocomplete commands using nice menu in place of window status. Enable
"CTRL-N and CTRL-P to scroll through matches.
set wildmenu

"For autocompletion, complete as much as you can.
set wildmode=longest:full,full

"The cursor will briefly jump to the matching brace when you insert one.
set showmatch

"Enable search highlighting.
set hlsearch

"Enable highlighted case-insensitive incremential search.
set incsearch

"Autoindent when starting new line, or using o or O
set autoindent

"Show hte line and column number of the cursor position.
set ruler

"Don't parse modelines (google vim modeline vulnerability).
set nomodeline

"Disable swap to prevent annoying messages.
set noswapfile

"Make buffer modifiable
set modifiable

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" True color
set termguicolors

"}}}

" Vimscript file settings {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/plugins_mappings.vim
"source $HOME/.config/nvim/java.vim
source $HOME/.config/nvim/zsh.vim
source $HOME/.config/nvim/mapping.vim

"colorscheme material-monokai
colorscheme sublimemonokai

" Transparent background
hi Visual guifg=Black guibg=#00FA9A gui=none
hi Normal guibg=NONE ctermbg=NONE

" Highlight trailing space
highlight Trail ctermbg=red guibg=red
call matchadd('Trail', '\s\+$', 100)

" Highlight word under cursor
hi illuminatedWord cterm=underline gui=none guifg=White guibg=#0066FF

" Comments color
hi Comment guifg=#7CFC00
