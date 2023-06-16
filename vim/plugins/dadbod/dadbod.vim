" -------------------------
" Configs
" -------------------------

" Adding SQL URLs to dadbods
" In this directory, create secrets.json
" fill it with the name and url of the DBs you want to connect
" {
"    'db1': {'name': 'my first db', 'url': 'mysql://user1:pass1@localhost/db1'},
"    'db2': {'name': 'my second db', 'url': 'mysql://user2:pass2@localhost/db2'}
" }

" g:dbs so we can use it with https://github.com/kristijanhusak/vim-dadbod-ui
" Then run :DBUI
let g:dbs = []
" Root dadbod config
let s:dadbodRootFile = glob('~/.vim/plugins/dadbod/config.json')

" Project-specific configs
let s:dadbodProjectFile = glob(getcwd() . '/vim/configs/dadbod/config.json')

if filereadable(s:dadbodRootFile)
  let s:dadbodData = readfile(s:dadbodRootFile)
  let s:dadbodDict = json_decode(join(s:dadbodData))

  if filereadable(s:dadbodProjectFile)
    let s:dadbodProjectData = readfile(s:dadbodProjectFile)
    let s:dadbodProjectDict = json_decode(join(s:dadbodProjectData))
    let s:dadbodDict = extend(s:dadbodDict, s:dadbodProjectDict)
  endif

  let s:dadbodList = keys(s:dadbodDict)

  for dadbodDbKey in s:dadbodList
    call add(g:dbs, s:dadbodDict[dadbodDbKey])
  endfor
endif


command! DBSelect :call popup_menu(map(copy(g:dbs), {k,v -> v.name}), {
			\'callback': 'DBSelected'
			\})

func! DBSelected(id, result)
	if a:result != -1
		let b:db = g:dbs[a:result-1].url
		echomsg 'DB ' . g:dbs[a:result-1].name . ' is selected.'
	endif
endfunc

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
nnoremap <leader>ds :DBSelect<CR>

xnoremap <expr> <Plug>(DBExe)     DBExe()
nnoremap <expr> <Plug>(DBExe)     DBExe()
nnoremap <expr> <Plug>(DBExeLine) DBExe() . '_'

xmap gd <Plug>(DBExe)
nmap gd <Plug>(DBExe)
omap gd <Plug>(DBExe)
nmap gdd <Plug>(DBExeLine)

