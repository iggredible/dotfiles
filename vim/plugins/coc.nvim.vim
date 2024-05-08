" DEPS: node (13 or up)

" To list the extensions, run :CocList extensions

" coc-db requires dadbod plugin
" CoC saves the extensions inside
" ~/.config/coc/extensions/package.json
let g:coc_global_extensions = [
      \'coc-solargraph', 
      \'coc-json', 
      \'coc-db',
      \'coc-tsserver',
      \'coc-snippets',
      \'coc-eslint'
      \]

let g:coc_config_home = expand('<sfile>:p:h')

" Use tab for trigger completion with characters ahead and navigate
" There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> <C-]> :call CocActionAsync('jumpDefinition')<CR>

" Scroll up/down Coc's preview window
inoremap <nowait><expr> <Up> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Up>"
inoremap <nowait><expr> <Down> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Down>"

" ----- coc-snippets -----
" Use <C-s> for both expand and jump (make expand higher priority.)
imap <C-s> <Plug>(coc-snippets-expand-jump)

" Use <leader>ss for convert visual selected code to snippet
xmap <leader>ss  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use Tab for jump to next placeholder
let g:coc_snippet_next = '<tab>'

" Use Shift + Tab for jump to previous placeholder
let g:coc_snippet_prev = '<S-tab>'
