"  __    _______   ___________    ____  __     _______.                    
" |  |  /  _____| /  _____\   \  /   / (_ )   /       |                    
" |  | |  |  __  |  |  __  \   \/   /   |/   |   (----`                    
" |  | |  | |_ | |  | |_ |  \_    _/          \   \                        
" |  | |  |__| | |  |__| |    |  |        .----)   |                       
" |__|  \______|  \______|    |__|        |_______/                        
"      _______. __    __  .______    _______ .______                       
"     /       ||  |  |  | |   _  \  |   ____||   _  \                      
"    |   (----`|  |  |  | |  |_)  | |  |__   |  |_)  |                     
"     \   \    |  |  |  | |   ___/  |   __|  |      /                      
" .----)   |   |  `--'  | |  |      |  |____ |  |\  \----.                 
" |_______/     \______/  | _|      |_______|| _| `._____|                 
"                                                                          
"      ___   ____    __    ____  _______     _______. __    __  .___  ___. 
"     /   \  \   \  /  \  /   / |   ____|   /       ||  |  |  | |   \/   | 
"    /  ^  \  \   \/    \/   /  |  |__     |   (----`|  |  |  | |  \  /  | 
"   /  /_\  \  \            /   |   __|     \   \    |  |  |  | |  |\/|  | 
"  /  _____  \  \    /\    /    |  |____.----)   |   |  `--'  | |  |  |  | 
" /__/     \__\  \__/  \__/     |_______|_______/     \______/  |__|  |__| 
"                                                                          
" ____    ____  __  .___  ___. .______        ______                       
" \   \  /   / |  | |   \/   | |   _  \      /      |                      
"  \   \/   /  |  | |  \  /  | |  |_)  |    |  ,----'                      
"   \      /   |  | |  |\/|  | |      /     |  |                           
"    \    /    |  | |  |  |  | |  |\  \----.|  `----.                      
"     \__/     |__| |__|  |__| | _| `._____| \______|                      
"
" ------------------------------
"
" Iggy's vimrc file

"dein 
if &compatible
  set nocompatible
endif

set runtimepath+=/Users/iggy/.config/nvim/bundle/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/iggy/.cache/dein')
  call dein#begin('/Users/iggy/.config/nvim/bundle/dein')

  call dein#add('/Users/iggy/.config/nvim/bundle/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('bling/vim-airline')
  call dein#add('gko/vim-coloresque')
	call dein#add('junegunn/fzf.vim')
  call dein#add('Raimondi/delimitMate')
  call dein#add('Yggdroot/indentLine')
  call dein#add('tpope/vim-surround')
  call dein#add('terryma/vim-multiple-cursors') " Just type ctrl+n while highlighting the word
  call dein#add('ludovicchabant/vim-gutentags')
  call dein#add('w0rp/ale')
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('tomtom/tcomment_vim') " gc{motion}{c}
	call dein#add('mattn/emmet-vim')
	call dein#add('Shougo/deoplete.nvim')
	if !has('nvim')
	  call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
  call dein#add('moll/vim-node')
  call dein#add('carlitux/deoplete-ternjs')
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" basic
colorscheme gruvbox
set background=dark
set clipboard=unnamed
set relativenumber number
set tabstop=2 shiftwidth=2 expandtab
set encoding=UTF-8
set ignorecase
set smartcase

nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>A :Ag<Space>
nnoremap <esc><esc> :noh<return><esc>
nnoremap <F5> :buffers<CR>:buffer<Space>
noremap <silent> <F4> :let @+=expand("%:p")<CR>
inoremap jj <Esc>

if !has('nvim')
  nnoremap <Leader>sv :source $MYVIMRC<CR>
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
elseif has('nvim')
  nnoremap <Leader>sv :source ~/.vimrc<CR>
  nnoremap <Leader>ev :vsplit ~/.vimrc<CR>
endif

let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python3/3.7.2_2/bin/python3'

" gutentags
set statusline+=%{gutentags#statusline()}
set tags=tags;/

" deoplete
let g:deoplete#enable_at_startup=1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
set omnifunc=syntaxcomplete#Complete

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

" setup for fzf 
set rtp+=/usr/local/opt/fzf

" ale
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

" NERDTree
nnoremap <Leader>NT :NERDTreeToggle<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>

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
