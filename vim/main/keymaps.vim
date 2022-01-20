let g:mapleader = "\<Space>"

nnoremap <Leader>ve :vsplit ~/.vimrc<CR>
nnoremap <Leader>vs :source ~/.vimrc<CR>

" quickly remove highlights
nnoremap <Esc><Esc> :noh<Return><Esc>

" easy window splits
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" quickly open a new file
nnoremap <silent> vn :vnew<CR>
nnoremap <silent> sn :new<CR>

" quickly yank current file path
nnoremap <silent> cp :let @* = expand("%")<CR>
nnoremap <silent> cP :let @* = expand("%:p")<CR>
