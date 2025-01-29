" https://github.com/junegunn/vim-plug/wiki/extra
augroup PlugHelper
  if has('ruby')
    autocmd!
    autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call plug_helper#gx()<cr>
    autocmd FileType vim-plug nnoremap <buffer> <silent> H :call plug_helper#doc()<cr>
    autocmd FileType vim inoremap <c-x><c-v> <c-r>=plug_helper#vim_awesome_complete()<cr>
  endif
augroup END
