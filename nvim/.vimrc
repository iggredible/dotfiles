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
" Iggy's vimrc file!

if &compatible
  set nocompatible
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug('scrooloose/nerdtree')
  Plug('bling/vim-airline')
  Plug('gko/vim-coloresque')
  Plug('junegunn/fzf.vim')
  Plug('Yggdroot/indentLine')
  Plug('tpope/vim-surround')
  Plug('ludovicchabant/vim-gutentags')
  Plug('tpope/vim-fugitive')
  Plug('airblade/vim-gitgutter')
  Plug('Xuyuanp/nerdtree-git-plugin')
  Plug('ryanoasis/vim-devicons')
  Plug('tomtom/tcomment_vim') " gc{motion}{c}
	Plug('mattn/emmet-vim')
  Plug('tpope/vim-repeat')
  Plug('posva/vim-vue')
  " Plug('SirVer/ultisnips')
  " Plug('honza/vim-snippets')
  " Plug('junegunn/goyo.vim')
  " Plug('shime/vim-livedown')
  " Plug('w0rp/ale')

  " installing neo-snippets
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  let g:deoplete#enable_at_startup = 1

  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
call plug#end()

" basic
filetype plugin indent on
if !exists("g:syntax_on")
    syntax enable
endif

colorscheme gruvbox
set background=dark
set clipboard=unnamed
set relativenumber number
set tabstop=2
set shiftwidth=2
set expandtab
set encoding=UTF-8
set ignorecase
set smartcase
set lazyredraw
" set noswapfile
set confirm
set nobackup
set directory=$HOME/.vim/swp//
" set undofile
" set undodir=~/.vim/undodir

" KEY MAPPINGS
" open files and search files
nnoremap <C-p> :GFiles<CR>
nnoremap <C-f> :Ag<Space>

" Show active buffers
nnoremap <C-b> :buffers<CR>:buffer<Space>
" get rid of highlight
nnoremap <esc><esc> :noh<return><esc>

" center search results
nnoremap n nzz
nnoremap N Nzz

" normal mode while in insert mode
inoremap jk <Esc>

" moving lines while in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

if !has('nvim')
  nnoremap <Leader>sv :source $MYVIMRC<CR>
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
elseif has('nvim')
  nnoremap <Leader>sv :source ~/.vimrc<CR>
  nnoremap <Leader>ev :vsplit ~/.vimrc<CR>
endif

" window traversal
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" buffers traversal
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Get path of current buffer
nnoremap <C-c> :let @+=expand("%:p")<CR>

" python source
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python/3.7.4_1/bin/python3'

" let g:python3_host_prog='/usr/local/bin/python3'

" gutentags
set statusline+=%{gutentags#statusline()}
set tags=tags;/

" airline
" let g:airline_symbols = {}
" let g:airline_symbols.branch = ''

" deoplete
" let g:deoplete#enable_at_startup=1
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" set omnifunc=syntaxcomplete#Complete

" neosnippet
" let g:neosnippet#enable_completed_snippet = 1

" setup for fzf 
set rtp+=/usr/local/opt/fzf

" ale
" let g:ale_fixers = {
" \   'javascript': ['prettier'],
" \   'css': ['prettier'],
" \}
" let g:ale_fix_on_save = 1
" let g:ale_sign_error = '●' " Less aggressive than the default '>>'
" let g:ale_sign_warning = '.'
" let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

" NERDTree
let NERDTreeNaturalSort = 1

" nnoremap <Leader>NT :NERDTreeFind<CR>
nnoremap <Leader>t :NERDTreeFind<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')

" grepping
" https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" UltiSnips
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:UltiSnipsSnippetDirectories=[$HOME.'/.local/share/nvim/plugged/vim-snippets/UltiSnips']
" "
" " source  ~/.vim/markdown.vim
"" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
