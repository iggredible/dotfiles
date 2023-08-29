function! s:get_visual_selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! VimuxSlime() range
  let l:text = s:get_visual_selection()
  echo 'calling vimux slime'
  call VimuxRunCommand(l:text)
endfunction

vnoremap <Leader>vs :call VimuxSlime()<CR>
