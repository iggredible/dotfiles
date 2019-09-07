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

" To uninstall plugins:
" 1. Comment unwanted plugins (or delete them)
" 2. Run: call dein#recache_runtimepath()
" 3. Reinstall: call dein#install()
if dein#load_state('/Users/iggy/.cache/dein')
  call dein#begin('/Users/iggy/.config/nvim/bundle/dein')

  call dein#add('/Users/iggy/.config/nvim/bundle/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('scrooloose/nerdtree')
  " call dein#add('HerringtonDarkholme/yats.vim')
  " call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
  call dein#add('bling/vim-airline')
  call dein#add('gko/vim-coloresque')
	call dein#add('junegunn/fzf.vim')
  call dein#add('junegunn/goyo.vim')
  " call dein#add('Raimondi/delimitMate')
  call map(dein#check_clean(), "delete(v:val, 'rf')")
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
  call dein#add('shime/vim-livedown')
	if !has('nvim')
	  call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
  call dein#add('moll/vim-node')
	" call dein#add('Shougo/deoplete.nvim')
  " call dein#add('carlitux/deoplete-ternjs')
  " call dein#add('Shougo/neosnippet')
  " call dein#add('Shougo/neosnippet-snippets')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('posva/vim-vue')
  call dein#add('tpope/vim-repeat')
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
if !exists("g:syntax_on")
    syntax enable
endif

" basic
colorscheme gruvbox
set background=dark
set clipboard=unnamed
set relativenumber number
set tabstop=2 shiftwidth=2 expandtab
set encoding=UTF-8
set ignorecase
set smartcase

" keys 
nnoremap <Leader>p :GFiles<CR>
nnoremap <Leader>f :Ag<Space>
nnoremap <esc><esc> :noh<return><esc>
inoremap jk <Esc>

if !has('nvim')
  nnoremap <Leader>sv :source $MYVIMRC<CR>
  nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
elseif has('nvim')
  nnoremap <Leader>sv :source ~/.vimrc<CR>
  nnoremap <Leader>ev :vsplit ~/.vimrc<CR>
endif

" map buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
"
" F keys
noremap <silent> <F4> :let @+=expand("%:p")<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>

" python source
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/local/Cellar/python3/3.7.2_2/bin/python3'

" gutentags
set statusline+=%{gutentags#statusline()}
set tags=tags;/

" deoplete
" let g:deoplete#enable_at_startup=1
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" set omnifunc=syntaxcomplete#Complete

" neosnippet
" let g:neosnippet#enable_completed_snippet = 1

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
let NERDTreeNaturalSort = 1

nnoremap <Leader>NT :NERDTreeFind<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>

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


" markdown stuff
function! AddHeader()
  let headerLevel = input('Header Level? ')
  if headerLevel == 1
    normal! I# 
  elseif headerLevel == 2
    normal! I## 
  elseif headerLevel == 3
    normal! I### 
  elseif headerLevel == 4
    normal! I#### 
  elseif headerLevel == 5
    normal! I##### 
  elseif headerLevel == 6
    normal! I###### 
  else
    echo "Enter Header Level values between 1-6"
  endif
endfunction

" there are more improvements:
" what if I do this on line that contains text already?
" I think it'd be cool to highlight a code block and execute this
" so it should go to g instead of leader??

function! AddYAMLBlock()
  normal! 3i-yypO
endfunction

function! AddCodeBlock()
  normal! 3i`yypO
endfunction

augroup filetype_md
  autocmd!
  autocmd FileType markdown nnoremap <leader>lh :call AddHeader()<CR>
  autocmd FileType markdown nnoremap <leader>by :call AddYAMLBlock()<CR>
  autocmd FileType markdown nnoremap <leader>bc :call AddCodeBlock()<CR>
augroup END

