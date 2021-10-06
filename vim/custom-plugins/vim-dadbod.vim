" -------------------------
" Configs
" -------------------------
"  TODO: create environment variables for each name and url

let g:dadbods = []

let db_main = {
		\"name": "cryoportal main",
		\"url": "mysql://root:fun@localhost/"
		\}

let db_v2 = {
		\"name": "cryoportal v2",
		\"url": "mysql://root:fun@localhost/cryoportal_development"
		\}


let db_cm = {
		\"name": "cryoportal tracking",
		\"url": "mysql://root:fun@localhost/cryo_continuous_migration"
		\}

let db_v1 = {
		\"name": "cryoportal v1",
		\"url": "mysql://root:fun@localhost/cryoportal_v1"
		\}

call add(g:dadbods, db_main)
call add(g:dadbods, db_v1)
call add(g:dadbods, db_v2)
call add(g:dadbods, db_cm)

command! DBSelect :call popup_menu(map(copy(g:dadbods), {k,v -> v.name}), {
			\"callback": 'DBSelected'
			\})


func! DBSelected(id, result)
	if a:result != -1
		let b:db = g:dadbods[a:result-1].url
		echomsg 'DB ' . g:dadbods[a:result-1].name . ' is selected.'
	endif
endfunc

func! DBExe(...)
	if !a:0
		let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
		return 'g@'
	endif
	let sel_save = &selection
	let &selection = "inclusive"
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
