" Load from vim/
let b:fileList = split(globpath('~/.vim/main', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-functions', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-plugins', '**/*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/secret-stuff', '**/*.vim'), '\n')

for fpath in b:fileList
  exe 'source' fpath
endfor
