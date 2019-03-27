" Inside .config/nvim
" set bundle to store dein stuff inside this directory too
"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
