function! ActiveWinbar()
    return luaeval("require'winbar'.eval()")
endfunction

augroup Winbar
	autocmd!
	autocmd WinEnter,BufEnter * setlocal winbar=%!ActiveWinbar()
augroup END

set winbar=%!ActiveWinbar()
