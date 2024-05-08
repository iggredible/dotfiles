" Modified https://github.com/jgdavey/tslime.vim into an operator
function! VimuxSlimeExe(text = '')
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

nnoremap <Leader>vp :VimuxPromptCommand<CR>

nnoremap <expr> <Plug>VimuxSlimeExe operator#wrapper('VimuxSlimeExe')
xnoremap <expr> <Plug>VimuxSlimeExe operator#wrapper('VimuxSlimeExe')
nnoremap <expr> <Plug>VimuxSlimeExeLine operator#wrapper('VimuxSlimeExe') .. '_'

nnoremap gs <Plug>VimuxSlimeExe
xnoremap gs <Plug>VimuxSlimeExe
nnoremap gss <Plug>VimuxSlimeExeLine

" Conditional keymap for spec files only
au! BufRead **/*_spec.rb nnoremap <buffer><expr> <Leader>tt ShowVimuxRspec()
