"

" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
" ------------------------------
"
" Iggy's vimrc file
" (To view folded files press za in normal mode)

set clipboard=unnamed
set nocompatible
set number
set tabstop=2 shiftwidth=2 expandtab
set cursorline

" colorscheme desert
colorscheme industry

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
Plugin 'sheerun/vim-polyglot'
Plugin 'junegunn/fzf.vim'
Plugin 'rking/ag.vim' "preq: https://github.com/ggreer/the_silver_searcher
Plugin 'tpope/vim-surround'
Plugin 'takac/vim-hardtime'
Plugin 'elixir-lang/vim-elixir'

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
let g:hardtime_default_on = 1
syntax enable

" ------------------------------
" NERDTree setup
" ------------------------------
autocmd VimEnter * NERDTree

" NerdTree file extension highlights ---------- {{{
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" ---------- }}}
