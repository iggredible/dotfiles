" NOTE: Need to add SQL connections to dadbod and connect to it
" 1. create .env in project root
" 2. the DB urls keys must start with DB_
"   DB_DEVELOPMENT=mysql://user:password@127.0.0.1/db
"   DB_PRODUCTION=mysql://user:password@host.com/db
" 3. Connect to the query: <leader>dd

function! LoadDB()
  if exists('*DotenvRead')
    return DotenvRead()->keys()->filter('v:val =~# "DB_"')
  endif
endfunction

function! SelectDBSource(_id, result)
	if a:result != -1
    let l:dbs = LoadDB()
    let l:selection = l:dbs[a:result-1]
		let g:db = DotenvGet(l:selection)
		echomsg 'DB ' . l:selection . ' is selected.'
	endif
endfunction

" Load Dadbod Database
" https://habamax.github.io/2019/09/02/use-vim-dadbod-to-query-databases.html
nnoremap <leader>dd :call popup_menu(LoadDB(), { 'callback': 'SelectDBSource' })<CR>

" Create a mapping to execute DB queries
" Given (where cursor is on S in SELECT):
"   [S]ELECT * FROM USERS LIMIT 5;
" Running gdd will execute the query line
function! DadbodExe(db_script = '')
  execute "DB " . a:db_script
endfunction

call operatorify#mapper('gd', 'DadbodExe')
