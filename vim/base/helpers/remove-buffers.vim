function! RemoveAllBuffers()
  let l:current_pos = getpos('.')
  execute "%bd | e# | echo 'Buffers Removed'"
  call setpos('.', l:current_pos)
endfunc

function! RemoveMatchingBuffers(pattern)
    let l:bufferList = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let l:matchingBuffers = filter(bufferList, 'bufname(v:val) =~ a:pattern')
    if len(l:matchingBuffers) < 1
        echo 'No buffers found matching pattern ' . a:pattern
        return
    endif
    exec 'bd ' . join(l:matchingBuffers, ' ')
endfunction

command! -nargs=1 RemoveWhichBuffer call RemoveMatchingBuffers(<f-args>)
