" DEPS: fzf, ripgrep

" -------------------------
" Configs
" -------------------------

" Override :grep with rg, if available
" If you need to search for a keyword of a certain type, use either:
" :grep --type ruby foo
" :grep -g '*.rb' foo
" For more: https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md
" Ripgrep also supports regex: https://docs.rs/regex/1.7.1/regex/#syntax
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
endif

" For complete configs
" Check out https://github.com/junegunn/fzf/blob/master/README-VIM.md
" runtimepath
set rtp+=/usr/local/opt/fzf

let g:rgGlob = ''

function RgSet(rgGlob = '')
  let g:rgGlob = ''
  if a:rgGlob != ''
    let g:rgGlob = g:rgGlob . '-g ' . shellescape(a:rgGlob) . ' '
  endif
  return g:rgGlob
endfunction

function RgRunner()
    return 'rg --column --line-number --no-heading --color=always --smart-case '.g:rgGlob
endfunction

" How to use Rgg
" :Rgg *.vim
" Now it will search only files ended in *vim
command! -bang -nargs=* Rgg call RgSet(<f-args>)
command! -bang -nargs=* Rg 
  \ call fzf#vim#grep(RgRunner().shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" https://sts10.github.io/2016/01/10/vim-line-complete-with-fzf.html
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_layout = { 'down': '~40%' }

" -------------------------
" Keymaps
" -------------------------
nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <C-g> :Rg<CR>
nnoremap <silent> <C-b> :Buffers<CR>

nnoremap <silent> <Leader>f/ :Lines<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fh :Helptags<CR>
nnoremap <silent> <Leader>fc :BCommits<CR>
nnoremap <silent> <Leader>fo :History<CR>
nnoremap <silent> <Leader>fg :GFiles?<CR>
nnoremap <silent> <Leader>fw :call fzf#vim#tags(expand('<cword>'))<CR>

inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
