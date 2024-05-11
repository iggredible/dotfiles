function! remove#all_buffers() abort
  let l:current_pos = getpos('.')
  execute "%bd | e# | echo 'All buffers cleared!'"
  call setpos('.', l:current_pos)
endfunction

function! remove#which_buffers(pattern) abort
    let l:bufferList = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:matchingBuffers = filter(bufferList, 'bufname(v:val) =~ a:pattern')
    if len(l:matchingBuffers) < 1
        echo 'No buffers found matching pattern "' . a:pattern . '"'
        return
    endif
    exec 'bd ' . join(l:matchingBuffers, ' ')
    echo "\nBuffers matching \"" . a:pattern . '" are cleared!'
endfunction

function! remove#all_marks() abort
  " delm! removes all marks except A-Z 0-9
  execute "delm! | delm A-Z0-9 | echo 'All marks are cleared'"
endfunc

function! remove#which_mark() abort
  let s:mark_to_clear = input('Mark: ')
  if s:mark_to_clear == ''
    echo "\nMark is not cleared"
  else
    execute 'delm ' . s:mark_to_clear
    echo "\nMark " . s:mark_to_clear . ' is cleared!'
  endif
endfunc

function! remove#all_registers() abort
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
  echo 'All registers are cleared!'
endfunction

function! remove#which_register() abort
  let s:register_to_clear = input('Register: ')
  if s:register_to_clear == ''
    echo 'Register is not cleared'
  else
    call setreg(s:register_to_clear, []) 
    echo "\nRegister " . s:register_to_clear . ' is cleared!'
  endif
endfunc
