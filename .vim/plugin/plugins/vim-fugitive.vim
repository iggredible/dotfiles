if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

nnoremap gib :Git blame<CR>
nnoremap gir :Gread<CR>
nnoremap gid :Gdiffsplit<CR>
