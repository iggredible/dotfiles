" -------------------------
" Keymaps
" -------------------------

" Use Tab for jump to next placeholder
let g:coc_snippet_next = '<Tab>'

" Use Shift + Tab for jump to previous placeholder
let g:coc_snippet_prev = '<S-Tab>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-s> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>ss  <Plug>(coc-convert-snippet)
