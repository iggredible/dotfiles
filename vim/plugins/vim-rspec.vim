" -------------------------
" Configs
" -------------------------

let g:rspec_command = "Dispatch bin/rspec {spec}"

" -------------------------
" Keymaps
" -------------------------

nnoremap <Leader>tt :call RunCurrentSpecFile()<CR>
nnoremap <Leader>ts :call RunNearestSpec()<CR>
nnoremap <Leader>tl :call RunLastSpec()<CR>
nnoremap <Leader>ta :call RunAllSpecs()<CR>

