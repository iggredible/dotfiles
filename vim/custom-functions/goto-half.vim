function! s:Gm()
  execute 'normal! ^'
  let l:first_col = virtcol('.')
  execute 'normal! g_'
  let l:last_col  = virtcol('.')
  execute 'normal! ' . (l:first_col + l:last_col) / 2 . '|'
endfunc

nnoremap <silent> gm :call <SID>Gm()<CR>
onoremap <silent> gm :call <SID>Gm()<CR>
