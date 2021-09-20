" -------------------------
" Configs
" -------------------------

let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'ruby': ['rubocop'],
      \}

let g:ale_fixers = {
      \   'javascript': ['eslint'],
      \   'ruby': ['rubocop'],
      \}
let g:ale_linters_explicit = 1 " Only run linters named in ale_linters settings.
let g:ale_sign_column_always = 1

" -------------------------
" Keymaps
" -------------------------

nmap <silent> <Leader>ap <Plug>(ale_previous_wrap)
nmap <silent> <Leader>an <Plug>(ale_next_wrap)

nnoremap <Leader>at :ALEToggle<CR>

