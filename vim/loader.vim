" Load from vim/

let s:fileList = split(globpath('$HOME/.vim/base', '**/*.vim'), '\n')
let s:fileList += split(globpath('$HOME/.vim', 'plugins.vim'), '\n')
let s:fileList += split(globpath('$HOME/.vim/plugins', '**/*.vim'), '\n')
let s:fileList += split(globpath('$HOME/.vim/colorschemes', '**/*.vim'), '\n')

if filereadable(getcwd() . '/.vim/vimrc.local')
  let s:fileList += [getcwd() . '/.vim/vimrc.local']
endif

for fpath in s:fileList
  exe 'source' fpath
endfor
