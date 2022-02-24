" -------------------------
" Configs
" -------------------------

set timeoutlen=500

let g:which_key_map = {}

" Mundo
let g:which_key_map['u'] = [':mundoToggle', 'Undo tree']

" Maximizer
let g:which_key_map['o'] = [':MaximizerToggle!', 'Maximize window']

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
      \ 's' : [':Snippets', 'Snippets'],
      \ 'm' : [':Marks', 'Marks'],
      \ 'h' : [':Helptags', 'Helps'],
      \ 'c' : [':Commits', 'Git commits buffer'],
      \ 'g' : [':GFiles?', 'Git status'],
      \ 'o' : [':History?', 'Old files'],
      \ 'w' : [':fzf#vim#tags', 'Find cword in tags'],
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
      \ 'v' : [':NERDTreeToggle vimrc', 'Toggle vimrc'],
      \ }

" Choosewin
let g:which_key_map['q'] = {
      \ 'name' : '+Choosewin' ,
      \ 'q' : [':ChooseWin', 'Choose window'],
      \ 's' : [':ChooseWinSwapStay', 'Swap window'],
      \ }

" Vimspector TODO
" let g:which_key_map['d'] = {
"       \ 'name' : '+Vimspector' ,
"       \ }

" splits
let g:which_key_map['v'] = {
      \ 'name' : 'vimrc' ,
      \ 'e' : [':vsplit vimrc', 'Edit vimrc'],
      \ 's' : [':source vimrc', 'Source vimrc'],
      \ }

" remove buffers/marks
let g:which_key_map['r'] = {
      \ 'name' : 'remove buffers/marks' ,
      \ 'b' : [':RemoveWhichBuffer', 'Remove select buffer(s)'],
      \ 'B' : [':call RemoveAllBuffers()', 'Remove all buffers'],
      \ 'm' : [':call RemoveAllMarks()', 'Remove select mark'],
      \ 'M' : [':delm!', 'Remove all marks'],
      \ }

" DB
let g:which_key_map['d'] = {
      \ 'name' : 'DB' ,
      \ 'b' : [':DBUI', 'Dadbod UI'],
      \ 's' : [':DBSelect', 'Select DB'],
      \ }

call which_key#register('<Space>', "g:which_key_map")

" -------------------------
" Keymaps
" -------------------------

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
