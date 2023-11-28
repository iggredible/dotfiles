function! RemoveAllRegisters() abort
  let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
  echo 'All registers are cleared!'
endfunction

function! RemoveARegister() abort
  let s:register_to_clear = input('Register: ')
  call setreg(s:register_to_clear, []) 
  echo 'register ' . s:register_to_clear . ' is cleared!'
endfunc
