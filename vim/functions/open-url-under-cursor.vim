function! OpenURLUnderCursor()
  let l:uri = expand('<cWORD>')
  silent exec "!open '" . l:uri . "'"
  redraw!
endfunction

nnoremap gx :call OpenURLUnderCursor()<CR>

