" Local config override
let s:local_override = getcwd() . '/.vim/local.vim'

if filereadable(s:local_override)
  exe 'source ' . s:local_override
endif

