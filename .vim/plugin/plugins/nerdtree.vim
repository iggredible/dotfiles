if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

let NERDTreeNaturalSort = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1

nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>
