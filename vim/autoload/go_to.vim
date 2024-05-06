" https://vi.stackexchange.com/questions/12835/how-do-i-jump-to-the-next-line-with-the-same-indent-level
function! go_to#next_or_previous_indent(inc)
  " Get the cursor current position
  let currentPos = getpos('.')
  let currentLine = currentPos[1]
  let matchIndent = 0

  " Look for a line with the same indent level whithout going out of the buffer
  while !matchIndent && currentLine != line('$') + 1 && currentLine != -1
    let currentLine += a:inc
    let matchIndent = indent(currentLine) == indent('.')
  endwhile

  " If a line is found go to this line
  if (matchIndent)
    let currentPos[1] = currentLine
    call setpos('.', currentPos)
  endif
endfunction
