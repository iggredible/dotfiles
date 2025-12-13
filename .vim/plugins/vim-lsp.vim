" LSP Server Registration
if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->['typescript-language-server', '--stdio']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(
        \   lsp#utils#find_nearest_parent_file_directory(
        \     lsp#utils#get_buffer_path(),
        \     ['package.json', 'tsconfig.json', 'jsconfig.json']
        \   ))},
        \ 'allowlist': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'],
        \ })
endif

if executable('solargraph')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'initialization_options': {
    \   "diagnostics": v:true,
    \   "completion": v:true,
    \   "formatting": v:true,
    \   "definitions": v:true,
    \   "hover": v:true,
    \   "references": v:true,
    \   "symbols": v:true,
    \   "snippets": v:true
    \ },
    \ 'allowlist': ['ruby'],
    \ })
endif

" LSP Configuration
let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_async_completion = 1
let g:lsp_completion_snippet_enabled = 1
let g:lsp_completion_resolve_timeout = 200

" LSP Buffer Settings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    " Navigation mappings
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
    nmap <buffer> <leader>f <plug>(lsp-document-format)

    " Documentation
    nmap <buffer> K <plug>(lsp-hover)

    " Diagnostics navigation
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Auto-close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Asyncomplete Configuration
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 100
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,preview

" UltiSnips Configuration
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit = "vertical"

" Tell LSP to use UltiSnips for snippet expansion
let g:lsp_settings = {'_': {'snippet_engine': 'ultisnips'}}

" Register completion sources
" call asyncomplete#register_source({
"     \ 'name': 'lsp',
"     \ 'allowlist': ['*'],
"     \ 'completor': function('lsp#complete')
"     \ })

" call asyncomplete#register_source({
"     \ 'name': 'ultisnips',
"     \ 'allowlist': ['*'],
"     \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
"     \ 'refresh_pattern': '\(\k\+$\|\s\{2,\}$\)'
"     \ })

" Prioritize completion sources
" let g:asyncomplete_source_priority = {
"     \ 'ultisnips': 1000,
"     \ 'lsp': 700,
"     \ 'buffer': 500,
"     \ 'file': 400,
"     \ 'around': 300
"     \ }
