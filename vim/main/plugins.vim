call plug#begin('~/.vim/plugged')
  " Defaults
  Plug 'tpope/vim-sensible'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'

  " Interface
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'luochen1990/rainbow'
  Plug 'nathanaelkane/vim-indent-guides'

  " Searching
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " Languages and Frameworks
  Plug 'tpope/vim-rails'
  Plug 'vim-ruby/vim-ruby'
  Plug 'slim-template/vim-slim'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-bundler'
  Plug 'lepture/vim-jinja'

  " Editing
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-endwise'
  Plug 'rstacruz/vim-closer'
  Plug 'tpope/vim-unimpaired'
  Plug 'markonm/traces.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'mbbill/undotree'
  Plug 'tommcdo/vim-exchange'
  Plug 'kshenoy/vim-signature'
  Plug 'dahu/vim-fanfingtastic'
  Plug 'tpope/vim-repeat'
  Plug 'romainl/vim-cool'
  Plug 'svermeulen/vim-yoink'
  Plug 'junegunn/vim-peekaboo'
  Plug 'inkarkat/vim-ReplaceWithRegister'

  " Managers
  Plug 'szw/vim-maximizer'
  Plug 'preservim/nerdtree'
  Plug 'simeji/winresizer'
  Plug 'tpope/vim-dotenv'

  " Tmux
  Plug 'christoomey/vim-tmux-navigator'

  " SQL
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'

  " Runner
  Plug 'tpope/vim-dispatch'
  Plug 'preservim/vimux'

  " Completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'honza/vim-snippets'
call plug#end()
