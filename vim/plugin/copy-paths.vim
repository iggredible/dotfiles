" quickly yank current file path
nnoremap <silent> cp :let @* = expand("%")<CR>
nnoremap <silent> cP :let @* = expand("%:p")<CR>
