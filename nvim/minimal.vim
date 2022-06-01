" To reproduce bugs

set runtimepath^=~/.local/share/nvim/site/pack/packer/opt/telescope.nvim/
set runtimepath^=~/.local/share/nvim/site/pack/packer/opt/plenary.nvim/

function! ActiveWinbar()
    return "hello"
endfunction

augroup Winbar
	autocmd!
	autocmd WinEnter,BufEnter * setlocal winbar=%!ActiveWinbar()
augroup END

set winbar=%!ActiveWinbar()
