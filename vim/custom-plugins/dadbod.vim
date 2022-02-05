" -------------------------
" Configs
" -------------------------

let g:dadbods = []

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

