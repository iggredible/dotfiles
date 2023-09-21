" List of all plugins
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

  " Languages and Frameworks
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'slim-template/vim-slim'
  Plug 'pangloss/vim-javascript'

  " Editing
  Plug 'Yggdroot/indentLine'
  Plug 'luochen1990/rainbow'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-unimpaired'
  Plug 'markonm/traces.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'iggredible/argh.vim'
  Plug 'junegunn/vim-peekaboo'
  Plug 'simnalamburt/vim-mundo'
  Plug 'mg979/vim-visual-multi'

  " Organizer
  Plug 'szw/vim-maximizer'
  Plug 't9md/vim-choosewin'
  Plug 'tpope/vim-obsession'
  Plug 'preservim/nerdtree'

  " Debugger
  " Plug 'puremourning/vimspector'

  " Snippets
  Plug 'honza/vim-snippets'
"
  " Tmux
  Plug 'christoomey/vim-tmux-navigator'

  " SQL
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  " Runner
  Plug 'tpope/vim-dispatch'
  Plug 'preservim/vimux'

  " Autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
