" DEPS: nerd fonts

" -------------------------
" Configs
" -------------------------

let g:db_ui_win_position = 'right'
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_save_location = getcwd() . '/scripts/'

" -------------------------
" Keymaps
" -------------------------

nnoremap <leader>db :DBUIToggle<CR>
