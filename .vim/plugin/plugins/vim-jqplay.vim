if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif
if !executable('jq') | finish | endif

let g:jqplay = { 'opts': '--tab', 'delay': 300 }

nnoremap <Plug>VerticalJqPlay :execute 'vertical Jqplay'<CR>
