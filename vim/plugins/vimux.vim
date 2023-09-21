" -------------------------
" Helpers
" -------------------------
" Modified https://github.com/jgdavey/tslime.vim into an operator
function! VimuxSlime(text = '')
  call VimuxRunCommand(a:text)
endfunction

let g:vimux_rspec_commands = ['Test Current Line', 'Test File']

function! RSpecSelected(id, result)
  if a:result != -1
    let l:selection = g:vimux_rspec_commands[a:result - 1]
    if l:selection =~# 'Line'
      let l:rspec_command = "bin/rspec " . bufname("%") . ":" . line(".")
    elseif l:selection =~# 'File'
      let l:rspec_command = "bin/rspec " . bufname("%")
    endif
    call VimuxRunCommand(l:rspec_command)
  endif
endfunction

function! ShowVimuxRspec()
  call popup_menu(g:vimux_rspec_commands, {'callback': 'RSpecSelected'})
endfunction

" -------------------------
" Keymaps
" -------------------------

nnoremap <Leader>vp :VimuxPromptCommand<CR>

nnoremap <expr> gs OperatorWrapper('VimuxSlime')
xnoremap <expr> gs OperatorWrapper('VimuxSlime')
nnoremap <expr> gss OperatorWrapper('VimuxSlime') .. '_'

" Conditional, buffer-specific keymap
au! BufRead **/*_spec.rb nnoremap <buffer><expr> <Leader>tt ShowVimuxRspec()
