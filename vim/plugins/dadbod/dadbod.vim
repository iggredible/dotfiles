" -------------------------
" Configs
" -------------------------

" Adding SQL URLs to dadbods
" create .env in project root
" Note: the DB urls keys must end with _DB
" DEVELOPMENT_DB=mysql://user:passw0rD@127.0.0.1/db1
" PRODUCTION_DB=mysql://prod_user:prodpassw0rD@some_prod_host.com/db2

function! s:load_databases()
  if exists('*DotenvRead')
    return DotenvRead()->keys()->filter('v:val =~# "_DB"')
  endif
endfunction

command! DBSelect :call popup_menu(s:load_databases(), {
			\'callback': 'DBSelected'
			\})

func! DBSelected(id, result)
	if a:result != -1
    let l:dbs = s:load_databases()
    let l:selection = l:dbs[a:result-1]
		let b:db = DotenvGet(l:selection)
		echomsg 'DB ' . l:selection . ' is selected.'
	endif
endfunc

" TODO use operator wrapper
func! DBExe(...)
	if !a:0
		let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
		return 'g@'
	endif
	let sel_save = &selection
	let &selection = 'inclusive'
	let reg_save = @@

	if a:1 == 'char'	" Invoked from Visual mode, use gv command.
		silent exe 'normal! gvy'
	elseif a:1 == 'line'
		silent exe "normal! '[V']y"
	else
		silent exe 'normal! `[v`]y'
	endif

	execute "DB " . @@

	let &selection = sel_save
	let @@ = reg_save
endfunc

" -------------------------
" Keymaps
" -------------------------

" https://habamax.github.io/2019/09/02/use-vim-dadbod-to-query-databases.html
nnoremap <leader>dd :DBSelect<CR>

xnoremap <expr> <Plug>(DBExe)     DBExe()
nnoremap <expr> <Plug>(DBExe)     DBExe()
nnoremap <expr> <Plug>(DBExeLine) DBExe() . '_'

xmap gd <Plug>(DBExe)
nmap gd <Plug>(DBExe)
omap gd <Plug>(DBExe)
nmap gdd <Plug>(DBExeLine)
