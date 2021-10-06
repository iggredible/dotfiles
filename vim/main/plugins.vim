call plug#begin('~/.vim/plugged')
  " Defaults
  Plug 'tpope/vim-sensible'

  " Custom Text Objects
  Plug 'kana/vim-textobj-user'
  Plug 'tek/vim-textobj-ruby'

  " Chords Keymaps
  Plug 'kana/vim-arpeggio'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }

  " Themes
  Plug 'sjl/badwolf'
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'

  " Searches
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'ludovicchabant/vim-gutentags'

  " Languages
  Plug 'sheerun/vim-polyglot'

  " Linter
  Plug 'dense-analysis/ale'

  " Editing
  Plug 'Yggdroot/indentLine'
  Plug 'luochen1990/rainbow'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-unimpaired'
  Plug 'godlygeek/tabular'
  Plug 'iggredible/totitle-vim'
  Plug 'tomtom/tcomment_vim'

  " Windows/Panes
  Plug 'preservim/nerdtree'
  Plug 'szw/vim-maximizer'
  Plug 't9md/vim-choosewin'

  " Registers
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
  Plug 'preservim/vimux'
  Plug 'pgr0ss/vimux-ruby-test'
  Plug 'tyewang/vimux-jest-test'

  " SQL
  Plug 'tpope/vim-dadbod'

  " Dispatch
  Plug 'tpope/vim-dispatch'

call plug#end()

call arpeggio#load()
