if !has('nvim')
  " unsaved changed buffer is hidden
  set hidden

  " easier search
  set hlsearch

  " show how many matches when searching with / or ?
  set shortmess-=S

  " don't give the file info when editing a file
  set shortmess+=F
endif

" allow yank and paste without prepending "*
set clipboard=unnamed

" don't create swapfile
set noswapfile

" make it easy to target a specific line
set relativenumber number

" consistent tabs and spacings
set tabstop=2 shiftwidth=2
set expandtab

" easier search
set ignorecase smartcase

" raises dialog
set confirm

" more natural window placement when splitting
set splitbelow splitright

let s:english_dict = "/usr/share/dict/words"

if filereadable(s:english_dict)
  let &dictionary=s:english_dict
endif

" Interface
set termguicolors
set background=dark
