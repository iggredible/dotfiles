function! s:setJsonBuffer()
  let &l:buftype='nofile'
  let &l:ft='json'
  let &l:bh='hide'
  setlocal noswapfile
endfunction

function! s:goToBufferWindow(scratch_buffer_name)
  if bufwinnr(a:scratch_buffer_name) == -1
    vsplit
    execute 'buffer ' . a:scratch_buffer_name
  else
    let win_num = bufwinnr(a:scratch_buffer_name)
    execute win_num . 'wincmd w'
  endif
endfunction

function! s:createNewBuffer(scratch_buffer_name)
  vnew
  call s:setJsonBuffer()
  execute "file " . a:scratch_buffer_name
  return
endfunction

function! s:createOrGoToBuffer(scratch_buffer_name = 'json_previewer.json')
  let l:scratch_buffer_name = a:scratch_buffer_name
  if bufexists(l:scratch_buffer_name)
    call s:goToBufferWindow(l:scratch_buffer_name)
  else
    call s:createNewBuffer(l:scratch_buffer_name)
  endif
endfunction

function! s:jqFilter() abort
  let l:jq_filter = input("jq filter: ")
  if l:jq_filter == '' | let l:jq_filter = '.' | endif
  execute '%!jq ' . "'" . l:jq_filter . "'"
endfunction

function! JSONBufferPreview()
  if executable('jq')
    let l:reg_save = getreginfo('"')
    execute 'silent noautocmd keepjumps normal vajy'
    call s:createOrGoToBuffer('json_previewer.json')
    execute 'normal! gg"_dG'
    execute 'normal! P'
    call s:jqFilter()
    call setreg('"', l:reg_save)
  else
    throw 'Please install jq.'
  endif
endfunction

nnoremap <silent> <Plug>JSONBufferPreview :call JSONBufferPreview()<CR>
nmap <Leader>jq <Plug>JSONBufferPreview
