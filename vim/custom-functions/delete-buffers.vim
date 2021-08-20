" source: https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
function! DeleteAllBuffers()
  let l:current_pos = getpos('.')
  execute "%bd | e# | echo 'Buffers Deleted'"
  call setpos('.', l:current_pos)
endfunc

function! DeleteMatchingBuffers(pattern)
    let l:bufferList = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:matchingBuffers = filter(bufferList, 'bufname(v:val) =~ a:pattern')
    if len(l:matchingBuffers) < 1
        echo 'No buffers found matching pattern ' . a:pattern
        return
    endif
    exec 'bd ' . join(l:matchingBuffers, ' ')
endfunction

command! -nargs=1 DelBuf call DeleteMatchingBuffers('<args>')


nnoremap <silent> <Leader>bd :call DeleteAllBuffers()<CR>
nnoremap <Leader>bD :DelBuf<Space>

