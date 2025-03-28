" Settings for
" https://github.com/prabirshrestha/vim-lsp
" https://github.com/prabirshrestha/asyncomplete.vim

if executable('solargraph')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'initialization_options': {
    \   "diagnostics": "true",
    \   "formatting": "true",
    \   "completion": "true",
    \ },
    \ 'allowlist': ['ruby'],
    \ })
endif

" LSP key mappings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Navigation
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> gd <plug>(lsp-peek-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)

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
let g:lsp_diagnostics_enabled = 0
" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_diagnostics_float_cursor = 1

" Highlighting references
let g:lsp_highlight_references_enabled = 1

" Format on save (optional; we already have <leader>f
" autocmd BufWritePre *.rb call execute('LspDocumentFormatSync')

