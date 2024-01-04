function! scratch#daily(layout) abort
  let l:date_string = strftime('%Y_%m_%d')
  let l:scratch_extension = input('Extension: ')

  if l:scratch_extension == '' | let l:scratch_extension = 'md' | endif
  execute a:layout . 'new ' . l:date_string . '.' . l:scratch_extension
endfunction
