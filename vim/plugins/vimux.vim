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

nnoremap <Leader>vp :VimuxPromptCommand<CR>

nnoremap <expr> gs OperatorWrapper('VimuxSlime')
xnoremap <expr> gs OperatorWrapper('VimuxSlime')
nnoremap <expr> gss OperatorWrapper('VimuxSlime') .. '_'
