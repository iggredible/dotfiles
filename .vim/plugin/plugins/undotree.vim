if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

let g:undotree_WindowLayout = 4
let g:undotree_ShortIndicators = 1

nnoremap <Leader>u :UndotreeToggle<CR>
