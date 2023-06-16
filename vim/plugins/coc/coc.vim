" DEPS: node (13 or up)

" -------------------------
" Configs
" -------------------------

" NOTE: coc-db requires dadbod plugin
let g:coc_global_extensions = [
      \'coc-solargraph', 
      \'coc-json', 
      \'coc-db',
      \'coc-tsserver',
      \'coc-snippets',
      \]

let g:coc_config_home = '~/.vim/plugins/coc/'

" -------------------------
" Keymaps
" -------------------------

" TODO: https://github.com/neoclide/coc.nvim/wiki
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
