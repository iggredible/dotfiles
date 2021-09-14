if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

let b:fileList = split(globpath('~/.vim/main', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-functions', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-plugins', '*.vim'), '\n')

for fpath in b:fileList
  exe 'source' fpath
endfor
