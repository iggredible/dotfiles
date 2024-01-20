" Source: https://github.com/tpope/vim-jdaddy/
function! json#inner_pos(...) abort
  let cnt = a:0 ? a:1 : 1
  let line = getline('.')
  let char = line[col('.')-1]
  if char ==# '"' || len(s:gsub(s:gsub(line[0 : col('.')-1], '\\.', ''), '[^"]', '')) % 2
    let cnt -= 1
    if !cnt
      let quotes = []
      for pos in range(len(line))
        if exists('skip')
          unlet skip
        elseif line[pos] ==# '\'
          let skip = 1
        elseif line[pos] ==# '"'
          let quotes += [pos]
        endif
      endfor
      let before = filter(copy(quotes), 'v:val <= col(".")-1')
      let after  = filter(copy(quotes), 'v:val > col(".")-1')
      if before[-1] == col('.')-1 && len(before) % 2 == 0
        return [line('.'), before[-2]+1, line('.'), before[-1]+1]
      else
        return [line('.'), before[-1]+1, line('.'), after[0]+1]
      endif
    endif
  elseif char =~# '[[:alnum:]._+-]'
    let cnt -= 1
    if !cnt
      let [start, end] = [col('.')-1, col('.')-1]
      while line[start-1] =~# '[[:alnum:]._+-]'
        let start -= 1
      endwhile
      while line[end+1] =~# '[[:alnum:]._+-]'
        let end += 1
      endwhile
      return [line('.'), start+1, line('.'), end+1]
    endif
  endif
  if char =~# '[]})]'
    let cnt -= 1
    let [lclose, cclose] = [line('.'), col('.')]
  else
    let [lclose, cclose] = searchpairpos('[[{(]', '', '[]})]', 'W')
  endif
  let [lopen, copen] = searchpairpos('[[{(]', '', '[]})]', 'Wb')
  if !lopen || !lclose
    return [0, 0, 0, 0]
  endif
  return [lopen, copen, lclose, cclose]
endfunction

function! json#outer_pos(...) abort
  if getline('.')[col('.')-1] =~# '[]}]'
    let [lclose, cclose] = [line('.'), col('.')]
  else
    let [lclose, cclose] = searchpairpos('[[{]', '', '[]}]', 'r')
  endif
  let [lopen, copen] = searchpairpos('[[{]', '', '[]}]', 'rb')
  if lopen && lclose
    return [lopen, copen, lclose, cclose]
  endif
  return [0, 0, 0, 0]
endfunction

function! s:movement_string(line, col) abort
  return a:line . "G0" . (a:col > 1 ? (a:col - 1) . "l" : "")
endfunction

function! json#inner_movement(count) abort
  let [lopen, copen, lclose, cclose] = json#inner_pos(a:count)
  if !lopen
    return "\<Esc>"
  endif
  call setpos("'[", [0, lopen, copen, 0])
  call setpos("']", [0, lclose, cclose, 0])
  return "`[o`]"
endfunction

function! json#outer_movement(count) abort
  let [lopen, copen, lclose, cclose] = json#outer_pos(a:count)
  if !lopen
    return "\<Esc>"
  endif
  call setpos("'[", [0, lopen, copen, 0])
  call setpos("']", [0, lclose, cclose, 0])
  return s:movement_string(lopen, copen) . 'o' . s:movement_string(lclose, cclose)
endfunction
