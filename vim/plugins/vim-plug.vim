" -------------------------
" Helpers
" -------------------------
function! VimPlugInstall()
  write
  source $HOME/.vim/vimrc
  PlugInstall
endfunction
" -------------------------
" Commands
" -------------------------
command! Install call VimPlugInstall()
