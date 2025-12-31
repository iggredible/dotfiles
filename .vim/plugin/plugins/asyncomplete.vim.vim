if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

" Auto-show completion popup
let g:asyncomplete_auto_popup = 1

" Auto-completion settings
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"
