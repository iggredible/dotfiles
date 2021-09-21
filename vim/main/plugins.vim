" idea: run Vim based on speed
" MIN and MAX modes
" MAX has the whole enchiladas
" MIN excludes nice-to-have but not-absolutely-necessary plugins
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
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'preservim/vimux'
call plug#end()

