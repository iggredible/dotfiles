call plug#begin('~/.vim/plugged')
  " Defaults
  Plug 'tpope/vim-sensible'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'

  " Themes
  Plug 'sjl/badwolf'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'

  " Searches
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " Tags
  Plug 'ludovicchabant/vim-gutentags'

  " Languages and Frameworks
  " Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'vim-ruby/vim-ruby'
  Plug 'slim-template/vim-slim'

  " Linter
  Plug 'dense-analysis/ale'

  " Editing
  Plug 'Yggdroot/indentLine'
  Plug 'luochen1990/rainbow'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-unimpaired'
  Plug 'iggredible/totitle-vim'
  Plug 'markonm/traces.vim'
  Plug 'tomtom/tcomment_vim'

  " Windows/Panes
  Plug 'preservim/nerdtree'
  Plug 'szw/vim-maximizer'
  Plug 't9md/vim-choosewin'

  " Show keybindings
  Plug 'liuchengxu/vim-which-key'

  " Peekaboos
  Plug 'junegunn/vim-peekaboo'

  " Undo tree
  Plug 'simnalamburt/vim-mundo'

  " Debugger
  Plug 'puremourning/vimspector'
  "
  " Snippets
  Plug 'mattn/emmet-vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  "
  " Tmux
  Plug 'christoomey/vim-tmux-navigator'

  " SQL
  Plug 'tpope/vim-dadbod'

  " Dispatch
  Plug 'tpope/vim-dispatch'

call plug#end()
