" DEPS: nerd fonts

" NOTE: Inside .vim/vimrc.local in your project, change the save location:
" let g:db_ui_save_location = getcwd() . '/path/to/db/'
let g:db_ui_save_location = getcwd()
let g:db_ui_win_position = 'right'
let g:db_ui_dotenv_variable_prefix = 'DB_'

nnoremap <leader>db :DBUIToggle<CR>
