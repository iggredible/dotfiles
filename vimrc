"  ____ ____ ____ ____ _
" ||I |||G |||G |||Y |||
" ||__|||__|||__|||__|||
" |/__\|/__\|/__\|/__\|/
"  ____ ____ ____ ____ ____
" ||V |||I |||M |||R |||C ||
" ||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|


" Plugins {{{
" " first, get a list of t he plugin locations
let b:pluginList = split(globpath('~/.vim/custom-plugins', '*.vim'))

function! ProcessList(listToProcess, functionToCall)
  for fpath in a:listToProcess
    call {a:functionToCall}(fpath)
  endfor
endfunction

function! AddBundle(fpath)
  " echo "Plug " . readfile(a:fpath, "", 1)[-1][1:]
  execute "Plug " . readfile(a:fpath, "", 1)[-1][1:]
endfunction

call plug#begin('~/.vim/plugged')
  call ProcessList(b:pluginList, "AddBundle")
  Plug 'sjl/badwolf'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'honza/vim-snippets'
call plug#end()
" }}}
let mapleader = "\<Space>"

" TODO: source custom-functions and main-configs
