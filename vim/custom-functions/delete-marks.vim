function! DeleteAllMarks()
  execute "delm! | delm A-Z0-9 | echo 'Marks Deleted'"
endfunc

nnoremap <Leader>dm :delm!
nnoremap <Leader>dM :call DeleteAllMarks()<CR>

