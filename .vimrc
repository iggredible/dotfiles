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
set number 
" set hlsearch incsearch
set tabstop=2 shiftwidth=2 expandtab

" for vim-devicons plugin
set encoding=UTF-8

colorscheme gruvbox
set background=dark

set rtp+=~/.vim/bundle/Vundle.vim

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=/Users/iggy/.config/nvim/bundle/dein/repos/github.com/Shougo/dein.vim
" Required:
if dein#load_state('/Users/iggy/.cache/dein')
  call dein#begin('/Users/iggy/.config/nvim/bundle/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/iggy/.config/nvim/bundle/dein/repos/github.com/Shougo/dein.vim')

  " visuals
  call dein#add('scrooloose/nerdtree')
  call dein#add('bling/vim-airline')
  call dein#add('gko/vim-coloresque')

  " searches
	call dein#add('junegunn/fzf.vim')
  " call dein#add('pelodelfuego/vim-swoop')

  " syntax and navigation
  call dein#add('Raimondi/delimitMate')
  call dein#add('Yggdroot/indentLine')
  call dein#add('tpope/vim-surround')
  call dein#add('terryma/vim-multiple-cursors') " Just type ctrl+n while highlighting the word

  " Git stuff
 call dein#add('tpope/vim-fugitive')
"  call dein#add('airblade/vim-gitgutter')
  call dein#add('Xuyuanp/nerdtree-git-plugin')

  " icons
  call dein#add('ryanoasis/vim-devicons')

  " completion
  call dein#add('tomtom/tcomment_vim') " gc{motion}{c}
	call dein#add('mattn/emmet-vim')
	call dein#add('Shougo/deoplete.nvim')
	if !has('nvim')
	  call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
  call dein#add('carlitux/deoplete-ternjs')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
syntax enable

"End dein Scripts-------------------------

" deoplete setup
let g:deoplete#enable_at_startup=1

" Python deps for deoplete
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python3/3.7.2_2/bin/python3'

" neosnippet
let g:neosnippet#enable_completed_snippet = 1
" setup for fzf 
set rtp+=/usr/local/opt/fzf

"no maps nonrecursively
" nnoremap <Leader>f :Files<CR>
" GFiles is better search than Files because GFiles follows gitignore (Files would search node_modules too)
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>A :Ag<Space>
nnoremap <esc><esc> :noh<return><esc>
nnoremap J 5j
nnoremap K 5k

if !has('nvim')
  nnoremap <Leader>sv :source $MYVIMRC<CR>
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
elseif has('nvim')
  nnoremap <Leader>sv :source ~/.vimrc<CR>
  nnoremap <Leader>ev :vsplit ~/.vimrc<CR>
endif
 
nnoremap <F5> :buffers<CR>:buffer<Space>

" let g:swoopIgnoreCase = 1
" nmap <Leader>l :call Swoop()<CR> 
" vmap <Leader>l :call SwoopSelection()<CR>

" ion highlights ---------- {{{
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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

