"
" ------------------------------
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
" ------------------------------
"
" Iggy's vimrc file
"

" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard=unnamed
set nocompatible
set number 

" vim native fuzzy search
" i.e.:
" type ':find *.ex' then press <TAB>, it will search recursively, 
" up to 2 folders deep, anything with *.ex* pattern
set path+=**
set wildmenu

" ------------------------------
" setup vundle
" ------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" list of vundle plugins

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'slim-template/vim-slim.git'
Plugin 'bling/vim-airline'
Plugin 'slashmili/alchemist.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'wikitopian/hardmode'
Plugin 'craigemery/vim-autotag'

call vundle#end()            

" ------------------------------
" end vundle 
" ------------------------------

" setup for fzf 
set rtp+=/usr/local/opt/fzf
" this maps \t to :Files command
nmap <Leader>f :Files<CR>
nmap <Leader>b :Buffer<CR>
nmap <Leader>l :Lines<CR>

" autoloads
autocmd VimEnter * NERDTree
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" syntax highlight
syntax on
