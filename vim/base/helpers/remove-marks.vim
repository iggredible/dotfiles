function! RemoveAllMarks()
  execute "delm! | delm A-Z0-9 | echo 'All marks deleted'"
endfunc
