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

set clipboard=unnamed
set nocompatible
set number
syntax on

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
Plugin 'rking/ag.vim' "preq: https://github.com/ggreer/the_silver_searcher
Plugin 'tpope/vim-surround'
Plugin 'takac/vim-hardtime'

call vundle#end()

" ------------------------------
" end vundle
" ------------------------------

" setup for fzf
set rtp+=/usr/local/opt/fzf
" this maps nonrecursively
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffer<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>A :Ag<Space>
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
inoremap <c-k> <esc>ki
inoremap jk <esc>


" autoloads
autocmd VimEnter * NERDTree
let g:hardtime_default_on = 1
