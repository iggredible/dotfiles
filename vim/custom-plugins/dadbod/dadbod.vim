" -------------------------
" Configs
" -------------------------

" Adding SQL URLs to dadbods
" In this directory, create secrets.json
" fill it with the name and url of the DBs you want to connect
"{
"   'db1': {'name': 'my first db', 'url': 'mysql://user1:pass1@localhost/db1'},
"   'db2': {'name': 'my second db', 'url': 'mysql://user2:pass2@localhost/db2'}
" }

let s:dadbods = []
let s:dadbodFile = glob('**/dadbod/secrets.json')

if filereadable(s:dadbodFile)
  let s:dadbodData = readfile(s:dadbodFile)
  let s:dadbodDict = json_decode(join(s:dadbodData))
  let s:dadbodList = keys(s:dadbodDict)

endif

for dadbodDbKey in s:dadbodList
  call add(s:dadbods, s:dadbodDict[dadbodDbKey])
endfor

command! DBSelect :call popup_menu(map(copy(s:dadbods), {k,v -> v.name}), {
			\'callback': 'DBSelected'
			\})

func! DBSelected(id, result)
	if a:result != -1
		let b:db = s:dadbods[a:result-1].url
		echomsg 'DB ' . s:dadbods[a:result-1].name . ' is selected.'
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

