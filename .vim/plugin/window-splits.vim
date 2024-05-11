" quick window splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" open a new (dated) file, with extension
nnoremap <silent> vn :call scratch#daily('v')<CR>
nnoremap <silent> sn :call scratch#daily('')<CR>

" vimrc
nnoremap <Leader>ve :vsplit $HOME/.vim/<CR>
