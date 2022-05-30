function! ActiveWinbar()
    return luaeval("require'winbar'.eval()")
endfunction

augroup Winbar
	autocmd!
	autocmd WinEnter,BufEnter * setglobal winbar=%!ActiveWinbar()
augroup END

setglobal winbar=%!ActiveWinbar()
