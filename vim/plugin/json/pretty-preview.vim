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

" Public methods
function! CreateOrGoToBuffer(scratch_buffer_name = 'json_previewer.json')
  let l:scratch_buffer_name = a:scratch_buffer_name
  if bufexists(l:scratch_buffer_name)
    call s:goToBufferWindow(l:scratch_buffer_name)
  else
    call s:createNewBuffer(l:scratch_buffer_name)
  endif
endfunction

function! JSONBufferPreview()
  if executable('jq')
    let l:reg_save = getreginfo('"')
    execute 'silent noautocmd keepjumps normal vajy'
    call CreateOrGoToBuffer('json_previewer.json')
    execute 'normal! gg"_dG'
    execute 'normal! P'
    execute '%!jq .'
    call setreg('"', l:reg_save)
  else
    throw 'Please install jq.'
  endif
endfunction

nnoremap <Plug>JSONBufferPreview :call JSONBufferPreview()<CR>
nmap gjq <Plug>JSONBufferPreview
