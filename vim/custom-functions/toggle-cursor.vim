" DESC
" Usage
"
function! ToggleCursor()
  if(&cursorcolumn == 1)
    set nocursorcolumn
  elseif (&cursorcolumn == 0)
    set cursorcolumn
  endif

  if(&cursorline == 1)
    set nocursorline
  elseif (&cursorline == 0)
    set cursorline
  endif
endfunction

nnoremap <leader>tc :call ToggleCursor()<CR>

