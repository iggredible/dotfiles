" Modified https://github.com/jgdavey/tslime.vim into an operator
function! VimuxSlimeExe(text = '')
  call VimuxRunCommand(a:text)
endfunction

let g:vimux_rspec_commands = ['Test Current Line', 'Test File']

function! RSpecSelected(id, result)
  if a:result != -1
    let l:selection = g:vimux_rspec_commands[a:result - 1]
    if l:selection =~# 'Line'
      let l:rspec_command = "bin/rspec " . bufname("%") . ":" . line(".")
    elseif l:selection =~# 'File'
      let l:rspec_command = "bin/rspec " . bufname("%")
    endif
    call VimuxRunCommand(l:rspec_command)
  endif
endfunction

function! ShowVimuxRspec()
  call popup_menu(g:vimux_rspec_commands, {'callback': 'RSpecSelected'})
endfunction

function! VimuxSelectPane() abort
  " Check if fzf is available
  if exists('*fzf#run') && executable('fzf')
    call s:VimuxSelectPaneWithFzf()
  else
    call s:VimuxSelectPaneBasic()
  endif
endfunction

function! s:GetAvailablePanes() abort
  let current_pane = system("tmux display-message -p '#{pane_id}'")
  let current_pane = substitute(current_pane, '\n', '', '')
  
  " Get all panes in current window with useful info
  " tmux pane IDs are in format %[number] (e.g., %105, %99)
  let panes_output = system("tmux list-panes -F '#{pane_id}|#{pane_index}|#{pane_current_command}|#{pane_width}x#{pane_height}|#{pane_title}'")
  let panes = split(panes_output, '\n')
  
  let available_panes = []
  
  for pane_info in panes
    let parts = split(pane_info, '|')
    if len(parts) >= 5
      let pane_id = parts[0]
      
      " Skip current pane
      if pane_id == current_pane
        continue
      endif

      let pane_data = {
            \ 'id': pane_id,
            \ 'index': parts[1],
            \ 'command': parts[2] != '' ? parts[2] : 'shell',
            \ 'size': parts[3],
            \ 'title': len(parts) >= 5 && parts[4] != '' ? parts[4] : 'untitled'
            \ }

      call add(available_panes, pane_data)
    endif
  endfor
  
  return available_panes
endfunction

" Format pane info for display
function! s:FormatPaneInfo(pane) abort
  return printf("Pane %s: %s [%s] (%s)", 
        \ a:pane.index, 
        \ a:pane.command,
        \ a:pane.size,
        \ a:pane.title)
endfunction

" Basic version for when fzf is not available
function! s:VimuxSelectPaneBasic() abort
  let available_panes = s:GetAvailablePanes()
  if empty(available_panes)
    echo "No other panes available in current window"
    return
  endif
  
  " Build menu items
  let menu_items = []
  let pane_ids = []
  
  for pane in available_panes
    call add(menu_items, s:FormatPaneInfo(pane))
    call add(pane_ids, pane.id)
  endfor
  
  if has('popupwin')
    " Create popup menu
    let selection = popup_menu(menu_items, #{
          \ title: ' Select Target Pane ',
          \ border: [],
          \ padding: [0, 1, 0, 1],
          \ callback: function('s:VimuxPaneSelected', [pane_ids]),
          \ })
  " For older Vim or Neovim
  else
    " Use inputlist for older versions
    echo "Select target pane:"
    let i = 1
    for item in menu_items
      echo printf("%d. %s", i, item)
      let i += 1
    endfor
    let choice = input("Enter number (empty to cancel): ")
    
    if choice != '' && choice > 0 && choice <= len(pane_ids)
      call s:SetVimuxRunner(pane_ids[choice - 1])
    endif
  endif
endfunction

" FZF version for better UX when available
function! s:VimuxSelectPaneWithFzf() abort
  let available_panes = s:GetAvailablePanes()
  
  if empty(available_panes)
    echo "No other panes available"
    return
  endif
  
  " Build fzf input with hidden IDs
  let fzf_input = []
  for pane in available_panes
    let display = printf("%-8s %-15s %-10s %s", 
          \ "Pane " . pane.index,
          \ pane.command,
          \ pane.size,
          \ pane.title)
    
    " Store pane ID at the end after a delimiter that won't be shown
    call add(fzf_input, display . "\t" . pane.id)
  endfor
  
  " Use fzf to select
  let selection = fzf#run({
        \ 'source': fzf_input,
        \ 'sink': function('s:SetVimuxRunnerFromFzf'),
        \ 'options': '--prompt="Select Vimux Target Pane> " --header="Select pane to send commands to" --delimiter="\t" --with-nth=1',
        \ 'window': {'width': 0.8, 'height': 0.4}
        \ })
endfunction

" Callback function for popup selection
function! s:VimuxPaneSelected(pane_ids, id, result) abort
  if a:result > 0
    call s:SetVimuxRunner(a:pane_ids[a:result - 1])
  endif
endfunction

" Helper function to set the Vimux runner
function! s:SetVimuxRunner(pane_id) abort
  let g:VimuxRunnerIndex = a:pane_id
  " Get pane index for user-friendly display
  let pane_index = system("tmux display-message -t " . a:pane_id . " -p '#{pane_index}'")
  let pane_index = substitute(pane_index, '\n', '', '')
  echo "Vimux runner set to pane " . pane_index
endfunction

" FZF sink function
function! s:SetVimuxRunnerFromFzf(selection) abort
  " Extract pane ID from the end of the line (after tab)
  let parts = split(a:selection, "\t")
  if len(parts) >= 2
    let pane_id = parts[1]
    call s:SetVimuxRunner(pane_id)
  endif
endfunction

" Select which pane to run VimuxSlimeExe on 
nnoremap <leader>vss :call VimuxSelectPane()<CR>

" Conditional keymap for _spec.rb files only
au! BufRead **/*_spec.rb nnoremap <buffer><expr> <Leader>tt ShowVimuxRspec()
