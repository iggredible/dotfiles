" -------------------------
" Keymaps
" -------------------------

" Use <C-s> for both expand and jump (make expand higher priority.)
imap <C-s> <Plug>(coc-snippets-expand-jump)

" Use <leader>ss for convert visual selected code to snippet
xmap <leader>ss  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use Tab for jump to next placeholder
let g:coc_snippet_next = '<tab>'

" Use Shift + Tab for jump to previous placeholder
let g:coc_snippet_prev = '<S-tab>'
