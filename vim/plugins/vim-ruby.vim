" -------------------------
" Keymaps
" -------------------------

" Remapping vim-ruby's ]M and [M
augroup key_remaps
  autocmd!

  autocmd FileType ruby nmap <buffer> ]M ]]
  autocmd FileType ruby xmap <buffer> ]M ]]
  autocmd FileType ruby nmap <buffer> [M [[
  autocmd FileType ruby xmap <buffer> [M [[
augroup END
