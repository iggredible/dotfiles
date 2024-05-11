function s:Foo()
  echo 'foo_a!'
endfunction

nnoremap <Leader>f :call <SID>Foo()<CR>
