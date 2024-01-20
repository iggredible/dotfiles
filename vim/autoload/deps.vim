" https://github.com/junegunn/fzf/blob/master/plugin/fzf.vim#L140
let s:is_win = has('win32') || has('win64')
let s:base_dir = expand('<sfile>:h:h')

function! s:warn(msg)
  echohl WarningMsg
  echom a:msg
  echohl None
endfunction

function! deps#install(prg)
  if executable(a:prg)
    call s:warn(a:prg . ' is already installed.')
  endif

  if s:is_win && !has('win32unix')
    {}
  else
    let script = s:base_dir . '/install'
    if !executable(script)
      throw script.' not found'
    endif
    let script .= ' ' . a:prg
  endif

  call s:warn('Running ' . a:prg . ' installer ...')
  call system(script)
  if v:shell_error
    throw 'Failed to download ' . a:prg . ': ' . script
  endif
endfunction
