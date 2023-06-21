let g:mapleader = "\<Space>"

nnoremap <Leader>ve :vsplit ~/.vim/<CR>
nnoremap <Leader>vs :source ~/.vim/vimrc<CR>

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

nnoremap <Leader>rM :call RemoveAllMarks()<CR>
nnoremap <Leader>rm :delm!<Space>

nnoremap <Leader>rb :RemoveWhichBuffer<Space>
nnoremap <Leader>rB :call RemoveAllBuffers()<CR>

nnoremap gx :call OpenURLUnderCursor()<CR>
