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

" show how many matches when searching with / or ?
set shortmess-=S

let s:english_dict = "/usr/share/dict/words"

if filereadable(s:english_dict)
  let &dictionary=s:english_dict
endif

