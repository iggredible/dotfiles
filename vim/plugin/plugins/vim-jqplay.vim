let g:jqplay = { 'opts': '--tab', 'delay': 300 }

au! BufRead **/*.json nnoremap <buffer> <Leader>jq :execute 'vertical Jqplay'<CR>
