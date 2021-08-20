" 'junegunn/fzf.vim'

set rtp+=/usr/local/opt/fzf
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
endif

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RgNoFile call RipgrepFzf(<q-args>, <bang>0)
command! -bang -nargs=* RgWithFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

" https://sts10.github.io/2016/01/10/vim-line-complete-with-fzf.html
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

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

