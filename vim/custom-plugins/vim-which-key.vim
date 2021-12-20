" -------------------------
" Configs
" -------------------------

set timeoutlen=500

let g:which_key_map = {}
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ }

call which_key#register('<Space>', "g:which_key_map")

" -------------------------
" Keymaps
" -------------------------

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
