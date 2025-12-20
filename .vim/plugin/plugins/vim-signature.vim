if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

autocmd VimEnter * nnoremap m<Space> :<C-U>call signature#marker#Purge('all')<CR>

nnoremap yom :SignatureToggle<CR>
