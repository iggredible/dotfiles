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
nnoremap <silent> <Leader>ff :RgWithFile<CR>
nnoremap <silent> <Leader>f/ :BLines<CR>
nnoremap <silent> <Leader>f' :Marks<CR>
nnoremap <silent> <Leader>fg :Commits<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>ft :Tags<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

