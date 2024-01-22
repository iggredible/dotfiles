function! s:setJsonBuffer()
  let &l:buftype='nofile'
  let &l:ft='json'
  let &l:bh='hide'
  setlocal noswapfile
endfunction

function! s:openBufferWindow(scratch_buffer_name)
  vsplit
  execute "buffer " . a:scratch_buffer_name
  return
endfunction

function! s:createNewBuffer(scratch_buffer_name)
  vnew
  call s:setJsonBuffer()
  execute "file " . a:scratch_buffer_name
  return
endfunction

" Public methods
function! BufferFactory(scratch_buffer_name = 'json_previewer.json')
  let l:scratch_buffer_name = a:scratch_buffer_name
  if bufwinnr(l:scratch_buffer_name) == -1 && bufexists(l:scratch_buffer_name)
    call s:openBufferWindow(l:scratch_buffer_name)
  else
    call s:createNewBuffer(l:scratch_buffer_name)
  endif
endfunction

function! JSONBufferPreview()
  if executable('jq')
    let l:reg_save = getreginfo('"')
    execute 'silent noautocmd keepjumps normal vajy'
    call BufferFactory('json_previewer.json')
    execute 'normal! ggdG'
    execute 'normal! P'
    execute '%!jq .'
    call setreg('"', l:reg_save)
  else
    throw 'Please install jq.'
  endif
endfunction

nnoremap <Plug>JSONBufferPreview :call JSONBufferPreview()<CR>
nmap gjq <Plug>JSONBufferPreview
