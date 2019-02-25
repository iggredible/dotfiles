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
set paste
set hlsearch incsearch
set tabstop=2 shiftwidth=2 expandtab

colorscheme gruvbox
set background=dark

" ------------------------------
" setup vundle
" ------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" list of vundle plugins
" Run :PluginInstall to install new ones
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'sheerun/vim-polyglot'
Plugin 'junegunn/fzf.vim'
Plugin 'rking/ag.vim' "preq: https://github.com/ggreer/the_silver_searcher
Plugin 'tpope/vim-surround'
Plugin 'morhetz/gruvbox'
Plugin 'mattn/emmet-vim'

call vundle#end()            

" ------------------------------
" end vundle 
" ------------------------------

" setup for fzf 
set rtp+=/usr/local/opt/fzf

"no maps nonrecursively
" nnoremap <Leader>f :Files<CR>
" GFiles is better search than Files because GFiles follows gitignore (Files would search node_modules too)
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>b :Buffer<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>A :Ag<Space>
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>
inoremap jk <esc>

autocmd FileType elixir inoremap <buffer> do1 do<CR><CR><Space><Space>end<esc>ki<Space><Space><Space><Space>
autocmd FileType elixir inoremap <buffer> do0 do<CR><CR>end<esc>ki<Space><Space>


" autoloads
syntax enable

" ------------------------------
" NERDTree setup
" ------------------------------
" autocmd VimEnter * NERDTree

" Turn on NERDTree by pressing \N
" To turn it off, just type :q on NERDTree window
" To swap easily, do Ctrl + ww
nnoremap NT :NERDTree<CR>

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

" let g:netrw_lifestyle = 3
