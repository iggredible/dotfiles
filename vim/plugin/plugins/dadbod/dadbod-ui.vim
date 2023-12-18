" DEPS: nerd fonts

" -------------------------
" Configs
" -------------------------

let g:db_ui_win_position = 'right'
let g:db_ui_dotenv_variable_prefix = 'DB_'

" Inside .vim/vimrc.local in your project, add this option:
" let g:db_ui_save_location = getcwd() . '/path/to/db/'

" -------------------------
" Keymaps
" -------------------------

nnoremap <leader>db :DBUIToggle<CR>
