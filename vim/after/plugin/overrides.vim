" Local config override
let s:local_file = getcwd() . '/.vim/local.vim'
if filereadable(s:local_file)
  exe 'source ' . s:local_file
endif

