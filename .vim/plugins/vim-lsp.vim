" Settings for
" https://github.com/prabirshrestha/vim-lsp
" https://github.com/prabirshrestha/asyncomplete.vim
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[
        \   'typescript-language-server',
        \   '--stdio'
        \ ]},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(
        \   lsp#utils#find_nearest_parent_file_directory(
        \     lsp#utils#get_buffer_path(),
        \     ['package.json', 'tsconfig.json', 'jsconfig.json']
        \   ))},
        \ 'whitelist': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'],
        \ })
endif

" NOTE: Don't forget to add solargraph-rails in `.solargraph.yml
if executable('solargraph')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'initialization_options': {
    \   "diagnostics": "true",
    \   "formatting": "true",
    \   "completion": "true",
    \   "definitions": "true",
    \   "hover": "true",
    \   "references": "true",
    \   "symbols": "true"
    \ },
    \ 'allowlist': ['ruby'],
    \ })
endif

" LSP key mappings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Navigation
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> gd <plug>(lsp-peek-definition)

    " Scroll the preview window
    nnoremap <buffer> <expr>]s lsp#scroll(+5)
    nnoremap <buffer> <expr>[s lsp#scroll(-5)

    " Actions
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>ca <plug>(lsp-code-action)

    " Documentation
    nmap <buffer> K <plug>(lsp-hover)

    " Diagnostics navigation
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)

    " Formatting
    nmap <buffer> <leader>f <plug>(lsp-document-format)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that have the server registered
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Enable auto-completion
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 50

" Auto-close preview window
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Show diagnostic signs
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" NOTE: Enable auto hover after the cursor stays on a position for X milliseconds
" let g:lsp_hover_delay = 500
" let g:lsp_auto_hover = 1
" let g:lsp_hover_conceal = 1

" Highlighting references
let g:lsp_highlight_references_enabled = 1

" NOTE: Format on save (optional; we already have <leader>f
" autocmd BufWritePre *.rb call execute('LspDocumentFormatSync')

" NOTE: for debugging
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
