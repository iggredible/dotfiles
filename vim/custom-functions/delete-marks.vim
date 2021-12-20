function! DeleteAllMarks()
  execute "delm! | delm A-Z0-9 | echo 'All marks deleted'"
endfunc

nnoremap <Leader>dM :call DeleteAllMarks()<CR>
nnoremap <Leader>dm :delm!<Space>

