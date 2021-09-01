if empty(glob('~/.vim/autoload/plug.vim'))
  echo "about to glob vim-plug"
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " when we enter Vim, do a PlugInstall, then source
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

 "Plugins {{{
let b:fileList = split(globpath('~/.vim/main', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-functions', '*.vim'), '\n')
let b:fileList += split(globpath('~/.vim/custom-plugins', '*.vim'), '\n')

function! SourceFile(fpath)
    exe 'source' a:fpath
endfunction

function! ProcessList(listToProcess, functionToCall)
  for fpath in a:listToProcess
    call {a:functionToCall}(fpath)
  endfor
endfunction

function! AddBundle(fpath)
  execute "Plug " . readfile(a:fpath, "", 1)[-1][1:]
endfunction

call plug#begin('~/.vim/plugged')
  Plug 'iggredible/totitle-vim'
  Plug 'tpope/vim-sensible'
  Plug 'sjl/badwolf'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'tomtom/tcomment_vim'
  Plug 'mattn/emmet-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-fugitive'
  Plug 'Yggdroot/indentLine'
  Plug 'preservim/nerdtree'
  Plug 'luochen1990/rainbow'
  Plug 'tpope/vim-dispatch'
  Plug 'junegunn/vim-peekaboo'
  Plug 'machakann/vim-sandwich'
  Plug 'simnalamburt/vim-mundo'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-unimpaired'
  Plug 'godlygeek/tabular'
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
  Plug 'ryanoasis/vim-devicons'
  Plug 'dense-analysis/ale'
  Plug 'szw/vim-maximizer'
  Plug 't9md/vim-choosewin'
  Plug 'Shougo/unite.vim'
  " Plug 'puremourning/vimspector'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
call plug#end()
" }}}
let mapleader = "\<Space>"

" TODO: source custom-functions and main-configs
call ProcessList(b:fileList, "SourceFile") " source vim configs from the fileList

