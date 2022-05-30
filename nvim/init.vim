execute 'luafile ' . stdpath('config') . '/lua/plugins.lua'

source $HOME/.config/nvim/status-line.vim
source $HOME/.config/nvim/winbar.vim
luafile $HOME/.config/nvim/lua/settings.lua
luafile $HOME/.config/nvim/lua/config.lua
luafile $HOME/.config/nvim/lua/autocommands.lua

" Nvim highlight yank {{{
augroup highlight_yank
    autocmd!
	au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}
augroup END
" }}}

function!  QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction

command! QuickFixOpenAll         call QuickFixOpenAll()
