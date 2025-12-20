if !has_key(g:plugs, expand('<sfile>:t:r')) | finish | endif

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
"
" To exclude or ignore directories
" :grep -g '!spec/*' -g '!test/*' FooMailer
" :grep -g '!{**/node_modules/*,**/.git/*}' FooMailer
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
endif

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

let g:fzf_layout = { 'down': '~40%' }

" For complete configs
" Check out https://github.com/junegunn/fzf/blob/master/README-VIM.md
set rtp+=/opt/homebrew/opt/fzf

let g:rgGlob = ''

" -------------------------
" Helpers
" -------------------------
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

" -------------------------
" Commands
" -------------------------

" How to use Rgg
" :Rgg *.vim
" Now it will search only files ended in *vim
command! -bang -nargs=* Rgg call RgSet(<f-args>)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(RgRunner().shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" -------------------------
" Keymaps
" -------------------------
nnoremap <C-f> :GFiles<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-b> :Buffers<CR>

nnoremap <Leader>f/ :Lines<CR>
nnoremap <Leader>fh :Helptags<CR>
nnoremap <Leader>fo :History<CR>
nnoremap <Leader>fg :GFiles?<CR>

nnoremap git :BCommits<CR>

" https://sts10.github.io/2016/01/10/vim-line-complete-with-fzf.html
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
