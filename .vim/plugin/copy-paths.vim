" quickly yank current file path
nnoremap <silent> <leader>cp :let @* = expand("%:t")<CR>
nnoremap <silent> <leader>cP :let @* = expand("%:~:.")<CR>

" display paths
nnoremap <silent> <leader>pp :echo expand("%:t")<CR>
nnoremap <silent> <leader>PP :echo expand("%:~:.")<CR>
