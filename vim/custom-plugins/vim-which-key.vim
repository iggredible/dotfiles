" -------------------------
" Configs
" -------------------------

set timeoutlen=500

let g:which_key_map = {}

" Mundo
let g:which_key_map['u'] = [':mundoToggle', 'Undo tree']

" Maximizer
let g:which_key_map['o'] = [':MaximizerToggle!', 'Maximize window']

" Vimux
let g:which_key_map['v'] = {
      \ 'name' : '+vimux' ,
      \ 'p' : [':VimuxPromptCommand', 'Enter command to run'],
      \ 'l' : [':VimuxRunLastCommand', 'Rerun last vimux cmd'],
      \ 'c' : [':VimuxCloseRunner', 'Close tmux runner'],
      \ 't' : ['Focused Test', 'Run a focused test'],
      \ 'T' : ['All Tests', 'Run all tests'],
      \ }

" ALE
let g:which_key_map['a'] = {
      \ 'name' : '+ale' ,
      \ 'p' : ['ale_previous_wrap', 'Previous error'],
      \ 'n' : ['ale_next_wrap', 'Next error'],
      \ }

" FZF
let g:which_key_map['f'] = {
      \ 'name' : '+fzf' ,
      \ '/' : [':Lines', 'Search in buffer'],
      \ 'f' : [':RgWithFile', 'Search with files'],
      \ 's' : [':Snippets', 'Snippets'],
      \ 'm' : [':Marks', 'Marks'],
      \ 'h' : [':Helptags', 'Helps'],
      \ 'c' : [':Commits', 'Git commits buffer'],
      \ 'g' : [':GFiles?', 'Git status'],
      \ 'o' : [':History?', 'Old files'],
      \ }

let g:which_key_map['f']['b'] = {
      \ 'name' : '+fzf_buffers' ,
      \ '/' : [':BLines?', 'Search in buffers'],
      \ 'c' : [':BCommits?', 'Git commits buffers'],
      \ }

" NERDTree
let g:which_key_map['n'] = {
      \ 'name' : '+NERDTree' ,
      \ 'f' : [':NERDTreeFind', 'Find file'],
      \ 't' : [':NERDTreeToggle', 'Toggle tree'],
      \ }

" Choosewin
let g:which_key_map['q'] = {
      \ 'name' : '+Choosewin' ,
      \ 'q' : [':ChooseWin', 'Choose window'],
      \ 's' : [':ChooseWinSwapStay', 'Swap window'],
      \ }

" Vimspector TODO
let g:which_key_map['d'] = {
      \ 'name' : '+Vimspector' ,
      \ }
call which_key#register('<Space>', "g:which_key_map")

" -------------------------
" Keymaps
" -------------------------

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
