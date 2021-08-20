" 'puremourning/vimspector'


" Vimspector
" Jest testing Inspired by
" Vim as IDE: Config Part 3 (Vimspector) 4:00+
" https://www.youtube.com/watch?v=-AZUIL1rY3U
function! GetCurrentFile()
  let l:name = expand('%:t')
  return l:name
endfunction

function! CallJestOnCurrentFile()
  let l:currentFileName = GetCurrentFile()
  call vimspector#LaunchWithSettings( #{FileName: l:currentFileName} )
endfunction


" PLUGIN: Vimspector (debugger)
" nnoremap <Leader>dd :call CallJestOnCurrentFile()<CR>
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

nmap <Leader>di <Plug>VimspectorBalloonEval
