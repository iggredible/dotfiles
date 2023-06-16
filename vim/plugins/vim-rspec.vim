" -------------------------
" Configs
" -------------------------

let g:rspec_command = "Dispatch bin/rspec {spec}"

" -------------------------
" Keymaps
" -------------------------

" Mnemonics: [t]est [f]ile
nnoremap <Leader>tf :call RunCurrentSpecFile()<CR>
nnoremap <Leader>tt :call RunNearestSpec()<CR>
" Mnemonics: [t]est [l]ast
nnoremap <Leader>tl :call RunLastSpec()<CR>
" Mnemonics: [t]est [a]ll
nnoremap <Leader>ta :call RunAllSpecs()<CR>

