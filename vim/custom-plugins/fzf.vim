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
nnoremap <silent> <C-b> :Buffers<CR>

Arpeggio nnoremap <silent> <C-g> :RgNoFile<CR>

" command! -bang -nargs=* RgNoFile call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --type ruby ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" command! -bang -nargs=* RG
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always ' 
"   \  . (len(<q-args>) > 0 ? <q-args> : '""'), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

" Arpeggio nnoremap <silent> ft :RG
" function! RgWithFile()
"   " ask which file type?
"   " then run the command! with that file type
"   " call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --type " . l:file_type, 1, {'options': '--delimiter : --nth 4..'})
"   " call fzf#vim#grep("rg ", 1, <bang>)
"   call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ", 0, {'options': '--delimiter : --nth 4..'})
" endfunction

" function! RipgrepFzf(query, fullscreen)
"   let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
"   let initial_command = printf(command_fmt, shellescape(a:query))
"   let reload_command = printf(command_fmt, '{q}')
"   let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
"   call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
" endfunction

" command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)
"
" Arpeggio nnoremap <silent> ft :Rg<CR>

Arpeggio nnoremap <silent> f/ :Lines<CR>

nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>ff :RgWithFile<CR>
nnoremap <silent> <Leader>f/ :BLines<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fc :BCommits<CR>
nnoremap <silent> <Leader>fg :GFiles?<CR>
nnoremap <silent> <Leader>fs :Snippets<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

