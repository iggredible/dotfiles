if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

" Enable LSP for supported filetypes
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" Show diagnostic signs in the gutter
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '⚠'}

" Key mappings when LSP attaches
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Jump to definition
    nmap <buffer> <C-]> <plug>(lsp-definition)

    " Hover documentation
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Auto-completion settings
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" Auto-show completion popup
let g:asyncomplete_auto_popup = 1
