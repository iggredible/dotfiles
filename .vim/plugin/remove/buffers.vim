command! -nargs=1 RemoveWhichBuffer call remove#which_buffers(<f-args>)

nnoremap <Leader>rb :RemoveWhichBuffer<Space>
nnoremap <Leader>rB :call remove#all_buffers()<CR>
