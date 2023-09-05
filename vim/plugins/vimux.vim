" -------------------------
" Helpers
" -------------------------

" Modified https://github.com/jgdavey/tslime.vim into an operator
function! VimuxSlime(text = '')
  call VimuxRunCommand(a:text)
endfunction

" -------------------------
" Keymaps
" -------------------------

nnoremap <expr> gs OperatorWrapper('VimuxSlime')
xnoremap <expr> gs OperatorWrapper('VimuxSlime')
nnoremap <expr> gss OperatorWrapper('VimuxSlime') .. '_'

nnoremap <Leader>vp :VimuxPromptCommand<CR>
