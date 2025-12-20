if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

" https://stackoverflow.com/questions/5698284/in-my-vimrc-how-can-i-check-for-the-existence-of-a-color-scheme
try
  colorscheme PaperColor

  let g:PaperColor_Theme_Options = {
    \   'theme': {
    \     'default.dark': {
    \       'transparent_background': 1
    \     }
    \   }
    \ }
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme evening
endtry
