noremap <silent> <c-y> :call smooth_scroll#up(&scroll, 0, 1)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll*2, 0, 3)<CR>

noremap <silent> <c-e> :call smooth_scroll#down(&scroll, 0, 1)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll*2, 0, 3)<CR>
