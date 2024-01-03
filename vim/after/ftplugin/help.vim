" Slightly modified from https://vimways.org/2018/for-mappings-and-a-tutorial/
nnoremap <silent><buffer> ]] :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''')<cr>
nnoremap <silent><buffer> [[ :call search('<Bar>[^ <Bar>]\+<Bar>\<Bar>''[A-Za-z0-9_-]\{2,}''','b')<cr>
