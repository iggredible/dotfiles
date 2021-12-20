" -------------------------
" Configs
" -------------------------

" For complete configs
" Check out https://github.com/junegunn/fzf/blob/master/README-VIM.md
" runtimepath 
set rtp+=/usr/local/opt/fzf

" Override :grep with rg, if available
" Ex: :grep vim then :copen
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
endif

" Files to include?
" *js
" src/**/include
" THEN do the search

command! -bang -nargs=* RgNoFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
" pass the file name here
" On https://github.com/BurntSushi/ripgrep#why-should-i-use-ripgrep "rg -tpy
" foo limits your search to Python files and rg -Tjs foo excludes JavaScript
" files from your search"
" Maybe this? https://github.com/jesseleite/vim-agriculture
command! -bang -nargs=* RgWithFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

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

nnoremap <silent> <C-g> :RgNoFile<CR>

nnoremap <silent> <Leader>f/ :Lines<CR>

nnoremap <silent> <Leader>ff :RgWithFile<CR>
nnoremap <silent> <Leader>fs :Snippets<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fb/ :BLines<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fbc :BCommits<CR>
nnoremap <silent> <Leader>fc :Commits<CR>
nnoremap <silent> <Leader>fg :GFiles?<CR>

nnoremap <silent> <C-b> :Buffers<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

