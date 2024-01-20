xnoremap <expr>   ij json#inner_movement(v:count1)
onoremap <silent> ij :normal vij<CR>
xnoremap <expr>   aj json#outer_movement(v:count1)
onoremap <silent> aj :normal vaj<CR>
