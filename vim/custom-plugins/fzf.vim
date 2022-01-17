" -------------------------
" Configs
" -------------------------

" For complete configs
" Check out https://github.com/junegunn/fzf/blob/master/README-VIM.md
" runtimepath 
set rtp+=/usr/local/opt/fzf

" Override :grep with rg, if available
" If you need to search for a keyword of a certain type, use either:
" :grep --type ruby foo
" :grep -g '*.rb' foo
" For more: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
endif

command! -bang -nargs=* RG
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" https://sts10.github.io/2016/01/10/vim-line-complete-with-fzf.html
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
"
" -------------------------
" Keymaps
" -------------------------

nnoremap <silent> <expr> <C-f> fugitive#head() != '' ? ':GFiles<CR>' : ':Files<CR>'
nnoremap <silent> <C-g> :RG<CR>

nnoremap <silent> <Leader>f/ :Lines<CR>
nnoremap <silent> <Leader>fs :Snippets<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fc :Commits<CR>
nnoremap <silent> <Leader>fo :History<CR>
nnoremap <silent> <Leader>fg :GFiles?<CR>

nnoremap <silent> <Leader>fb/ :BLines<CR>
nnoremap <silent> <Leader>fbc :BCommits<CR>

nnoremap <silent> <C-b> :Buffers<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

