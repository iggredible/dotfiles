" NOTE: Need to add SQL connections to dadbod
" create .env in project root
" the DB urls keys must start with DB_
" DEVELOPMENT_DB=mysql://user:passw0rD@127.0.0.1/db1
" PRODUCTION_DB=mysql://prod_user:prodpassw0rD@some_prod_host.com/db2

function! s:loadDatabases()
  if exists('*DotenvRead')
    return DotenvRead()->keys()->filter('v:val =~# "DB_"')
  endif
endfunction

func! SelectDBSource(_id, result)
	if a:result != -1
    let l:dbs = s:loadDatabases()
    let l:selection = l:dbs[a:result-1]
		let g:db = DotenvGet(l:selection)
		echomsg 'DB ' . l:selection . ' is selected.'
	endif
endfunc

func! DadbodExe(db_script = '')
  execute "DB " . a:db_script
endfunc

function! SaySomething(something1)
  echo a:something1
endfunction

command! -nargs=1 SaySomething :call SaySomething(<f-args>)
command! SelectDB :call popup_menu(s:loadDatabases(), {
			\'callback': 'SelectDBSource'
			\})

" https://habamax.github.io/2019/09/02/use-vim-dadbod-to-query-databases.html
nnoremap <leader>dd :SelectDB<CR>

nnoremap <expr> <Plug>DadbodExe     operator#wrapper('DadbodExe')
xnoremap <expr> <Plug>DadbodExe     operator#wrapper('DadbodExe')
nnoremap <expr> <Plug>DadbodExeLine operator#wrapper('DadbodExe') .. '_'

nnoremap gd <Plug>DadbodExe
xnoremap gd <Plug>DadbodExe
nnoremap gdd <Plug>DadbodExeLine
