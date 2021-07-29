"  ____ ____ ____ ____ _
" ||I |||G |||G |||Y |||
" ||__|||__|||__|||__|||
" |/__\|/__\|/__\|/__\|/
"  ____ ____ ____ ____ ____
" ||V |||I |||M |||R |||C ||
" ||__|||__|||__|||__|||__||
" |/__\|/__\|/__\|/__\|/__\|

" Setup folding {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Plugins {{{
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
  Plug 'puremourning/vimspector'
call plug#end()
" }}}

" Basic setup {{{
set clipboard=unnamed
set noswapfile
set relativenumber number
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
set hlsearch
set confirm
set hidden
set termguicolors
set background=dark

" Dictionary
let s:english_dict = "/usr/share/dict/words"

if filereadable(s:english_dict)
  let &dictionary=s:english_dict
endif

" show how many matches when searching with / or ?
set shortmess-=S
" }}}

" Custom Theme {{{
" colorscheme badwolf
colorscheme iggy
highlight CursorColumn guibg=#ecf0c1
highlight CursorLine guibg=#ecf0c1
" }}}

" FZF  {{{
set rtp+=/usr/local/opt/fzf
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

command! -bang -nargs=* RgNoFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* RgFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" https://sts10.github.io/2016/01/10/vim-line-complete-with-fzf.html
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
" }}}

" Gutentags {{{
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git']

" Make it faster by ignoring these files
let g:gutentags_ctags_exclude = [
  \ '*.git', '*.svg', '*.hg',
  \ '*/tests/*',
  \ 'build',
  \ 'dist',
  \ 'bin',
  \ 'node_modules',
  \ 'cache',
  \ 'compiled',
  \ 'bundle',
  \ 'vendor',
  \ '*.md',
  \ '*-lock.json',
  \ '*.lock',
  \ '*bundle*.js',
  \ '*build*.js',
  \ '.*rc*',
  \ '*.json',
  \ '*.min.*',
  \ '*.map',
  \ '*.bak',
  \ '*.zip',
  \ '*.tmp',
  \ 'tags*',
  \ 'cscope.*',
  \ '*.css',
  \ '*.less',
  \ '*.scss',
  \ '*.swp', '*.swo',
  \ ]
" }}}

" NERDTree {{{
let NERDTreeNaturalSort = 1
" }}}

" signify {{{
set updatetime=1000
" }}}

" rainbow {{{
let g:rainbow_active = 1
" }}}

" ale {{{
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'ruby': ['rubocop'],
      \}

let g:ale_linters_explicit = 1 " Only run linters named in ale_linters settings.
let g:ale_sign_column_always = 1

" moving up and down
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}

" Custom Functions {{{
" toggler
function! ToggleCursor()
  if(&cursorcolumn == 1)
    set nocursorcolumn
  elseif (&cursorcolumn == 0)
    set cursorcolumn
  endif

  if(&cursorline == 1)
    set nocursorline
  elseif (&cursorline == 0)
    set cursorline
  endif
endfunction

function! ToggleNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" clear buffers 
" source: https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
function! BuffersDelete()
  let l:current_pos = getpos('.')
  execute "%bd | e# | echo 'Buffers Deleted'"
  call setpos('.', l:current_pos)
endfunc

" return current date. Format: 2020-12-05
function! GetDate()
  return strftime("%Y-%m-%d")
endfunction

" Open URL. Fixes the buggy gx in mac
function! OpenURLUnderCursor()
  let l:uri = expand('<cWORD>')
  silent exec "!open '" . l:uri . "'"
  redraw!
endfunction

" Call :Tabularize when we insert  |
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Vimspector 
" Jest testing Inspired by 
" Vim as IDE: Config Part 3 (Vimspector) 4:00+
" https://www.youtube.com/watch?v=-AZUIL1rY3U 
function! GetCurrentFile()
  let l:name = expand('%:t')
  return l:name
endfunction

function! CallJestOnCurrentFile()
  let l:currentFileName = GetCurrentFile()
  call vimspector#LaunchWithSettings( #{FileName: l:currentFileName} )
endfunction

" }}}


" mappings {{{
let mapleader = "\<Space>"

" quick access to vimrc
nnoremap <Leader>vs :source ~/.vimrc<CR>
nnoremap <Leader>ve :vsplit ~/.vimrc<CR>

" no highlight
nnoremap <Esc><Esc> :noh<Return><Esc>

" quick date
inoremap <C-d> <C-r>=GetDate()<CR><Esc>

" toggle numbers
nnoremap <leader>tn :call ToggleNumber()<CR>

" toggle cursor highlights
nnoremap <leader>tc :call ToggleCursor()<CR>

" open URL
nnoremap gx :call OpenURLUnderCursor()<CR>

" delete all buffers except current buffer
nnoremap <silent> <Leader>bd :call BuffersDelete()<CR>

" PLUGIN: FZF
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>ff :RgNoFile<CR>
nnoremap <silent> <Leader>fF :RgFile<CR>
nnoremap <silent> <Leader>f/ :BLines<CR>
nnoremap <silent> <Leader>f' :Marks<CR>
nnoremap <silent> <Leader>fg :Commits<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>ft :Tags<CR>

" PLUGIN: NERDTree
nnoremap <Leader>nf :NERDTreeFind<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>

" PLUGIN: Mundo
nnoremap <Leader>u :MundoToggle<CR>

" PLUGIN: Tabularize
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

" Plugin: fugitive
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gr :Gread<CR>

" PLUGIN: Vim-markdown 
" disables ]c caused by Vim-markdown
map <Plug> <Plug>Markdown_MoveToCurHeader

" PLUGIN: Vim-maximizer
nnoremap <Leader>o :MaximizerToggle!<CR>

" " PLUGIN: vim-choosewin
nmap  <Leader>q  <Plug>(choosewin)

" PLUGIN: Vimspector (debugger)
" nnoremap <Leader>dd :call CallJestOnCurrentFile()<CR>
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

nmap <Leader>di <Plug>VimspectorBalloonEval
" }}}
