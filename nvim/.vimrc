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
  Plug('mtth/scratch.vim')
  Plug('rbong/vim-flog')
  Plug('junegunn/vim-peekaboo')
  Plug('junegunn/goyo.vim')
  " Plug('shime/vim-livedown')
  Plug('w0rp/ale')
  Plug 'kyoz/purify', { 'rtp': 'vim' }
  " deoplete and neosnippets
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

  Plug 'kana/vim-textobj-user'
  Plug 'rhysd/vim-textobj-ruby'
call plug#end()

let mapleader = "\<space>"

" basic
filetype plugin indent on
if !exists("g:syntax_on")
    syntax enable
endif

" colorscheme gruvbox
colorscheme purify
set background=dark
set clipboard=unnamed
set relativenumber
set number
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
set nrformats=alpha
set hidden
" set undofile
" set undodir=~/.vim/undodir

" KEY MAPPINGS
" open files and search files
nnoremap <C-p> :Files<CR>
" nnoremap <C-f> :Ag<CR>
nnoremap <C-f> :Rg<CR>

" Show active buffers
" nnoremap <C-b> :buffers<CR>:buffer<Space>
nnoremap <C-b> :ls<CR>:b<Space>

" window resizing
nnoremap <C-w><Right> :vertical resize +10<CR>
nnoremap <C-w><Left> :vertical resize -10<CR>
nnoremap <C-w><Down> :resize +10<CR>
nnoremap <C-w><Up> :resize -10<CR>

" get rid of highlight
nnoremap <esc><esc> :noh<return><esc>

" center search results
nnoremap n nzz
nnoremap N Nzz

" files
nnoremap <Leader>w :w<CR>

" normal mode while in insert mode
" inoremap jk <Esc>

" MOVING STUFF
" moving lines up/down
vnoremap <Up> :m '<-2<CR>gv=gv
vnoremap <Down> :m '>+1<CR>gv=gv
nnoremap <Leader><Up>   :<C-u>silent! move-2<CR>==
nnoremap <Leader><Down> :<C-u>silent! move+<CR>==

" moving words left/right
" https://www.reddit.com/r/vim/comments/38d9ts/ideas_for_using_the_leader_key_feature/
nnoremap <Leader><Left>  "_yiw?\v\w+\_W+%#<CR>:s/\v(%#\w+)(\_W+)(\w+)/\3\2\1/<CR><C-o><C-l>
nnoremap <Leader><Right> "_yiw:s/\v(%#\w+)(\_W+)(\w+)/\3\2\1/<CR><C-o>/\v\w+\_W+<CR><C-l>

" VIMRC
" shortcut to vimrc and sourcing
if !has('nvim')
  nnoremap <Leader>vs :source $MYVIMRC<CR>
  nnoremap <Leader>ve :vsplit $MYVIMRC<CR>
elseif has('nvim')
  nnoremap <Leader>vs :source ~/.vimrc<CR>
  nnoremap <Leader>ve :vsplit ~/.vimrc<CR>
endif

" delete without saving to register
nnoremap <Leader>d "_d
xnoremap <Leader>d "_d

" BUFFERS
" buffers traversal
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>k :bfirst<CR>
nnoremap <Leader>j :blast<CR>

" Get path of current buffer
nnoremap <Leader>bp :let @+=expand("%:p")<CR>

" highlight trailing whitespace
match ErrorMsg '\s\+$'
" remove trailing whitespaces automatically
autocmd BufWritePre * :%s/\s\+$//e

" VIM SYNTAX
" helpers for https://github.com/vim/vim/blob/master/runtime/syntax/README.txt
nnoremap <Leader>s2 :runtime!syntax/2html.vim<CR>
nnoremap <Leader>sc :runtime!syntax/colortest.vim<CR>
nnoremap <Leader>sh :runtime!syntax/hitest.vim<CR>
nnoremap <Leader>sw :runtime!syntax/whitespace.vim<CR>

" python source
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python/3.7.4_1/bin/python3'

" fzf
set rtp+=/usr/local/opt/fzf

" gutentags
set statusline+=%{gutentags#statusline()}
set tags=tags;/


" deoplete
" let g:deoplete#enable_at_startup=1
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" set omnifunc=syntaxcomplete#Complete

" neosnippet
" let g:neosnippet#enable_completed_snippet = 1

" ale
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'vue': ['prettier']
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file

" NERDTree
let NERDTreeNaturalSort = 1

" nnoremap <Leader>NT :NERDTreeFind<CR>
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>
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

