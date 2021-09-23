" -------------------------
" Configs
" -------------------------

" runtimepath 
set rtp+=/usr/local/opt/fzf

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

command! -bang -nargs=* RgNoFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
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

nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <expr> <C-f> fugitive#head() != '' ? ':GFiles --cached --others --exclude-standard<CR>' : ':Files<CR>'
nnoremap <silent> <C-g> :RgNoFile<CR>
Arpeggio nnoremap <silent> f/ :Lines<CR>
Arpeggio nnoremap <silent> fm :Marks<CR>
Arpeggio nnoremap <silent> fg :Commits<CR>
Arpeggio nnoremap <silent> fh :Helptags<CR>
Arpeggio nnoremap <silent> ft :Tags<CR>

nnoremap <silent> <Leader>ff :RgWithFile<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fg :BCommits<CR>
nnoremap <silent> <Leader>f/ :BLines<CR>
nnoremap <silent> <Leader>fh :History<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
