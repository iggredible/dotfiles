if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

" consistent convention with unimpaired
nnoremap yoi <Plug>IndentGuidesToggle
nnoremap [oi <Plug>IndentGuidesEnable
nnoremap ]oi <Plug>IndentGuidesDisable
