"set termguicolors
"set noshowmode
"set laststatus=3

"function! ActiveLine()
"    return luaeval("require'status-line'.activate()")
"endfunction
"
"function! InactiveLine()
"	return luaeval("require'status-line'.inactivate()")
"endfunction
"
"augroup Statusline
"	autocmd!
"	autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
"	autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
"augroup END
"
"augroup UpdateFunction
"	autocmd!
"	autocmd CursorHold * silent! lua require'lsp-status'.update_current_function()
"augroup END
"
"set statusline=%!ActiveLine()
