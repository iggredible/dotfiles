" NOTE: Need to add SQL connections to dadbod and connect to it
" 1. create .env in project root
" 2. the DB urls keys must start with DB_
"   DB_DEVELOPMENT=mysql://user:password@127.0.0.1/db
"   DB_PRODUCTION=mysql://user:password@host.com/db
" 3. Connect to the query: <leader>dd

" TODO: add a friendly error message in case <Leader> + dd is pressed 
" and no DB is found
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

" Opeator to execute DB queries
function! DadbodExe(db_script = '')
  if !exists('g:db') || empty(g:db)
    echohl WarningMsg
    echo "Warning: No database selected. Please set g:db first."
    echohl None
    return
  endif

  execute "DB " . a:db_script
endfunction

augroup SQLMappings
  autocmd!
" Load Dadbod Database
" https://habamax.github.io/2019/09/02/use-vim-dadbod-to-query-databases.html
  autocmd FileType sql nnoremap <leader>dd :call popup_menu(LoadDB(), { 'callback': 'SelectDBSource' })<CR>

  if exists('*Operatorify#Mapper')
    autocmd FileType sql call Operatorify#Mapper('gd', 'DadbodExe')
  endif
augroup END
