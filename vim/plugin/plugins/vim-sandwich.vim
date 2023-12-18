" -------------------------
" Configs
" -------------------------

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

" Add spaces inside brackets when using {, [, or (
" Source: https://github.com/machakann/vim-sandwich/wiki/Bracket-with-spaces
let g:sandwich#recipes += [
      \   {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['{']},
      \   {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['[']},
      \   {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1, 'kind': ['add', 'replace'], 'action': ['add'], 'input': ['(']},
      \   {'buns': ['{\s*', '\s*}'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['{']},
      \   {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['[']},
      \   {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1, 'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'], 'action': ['delete'], 'input': ['(']},
      \ ]

" Create a custom method for ruby
" https://evantravers.com/articles/2019/08/27/adding-ruby-and-elixir-mappings-for-vim-sandwich/
" example: on the text `args`, press saiwm, then type `some_method`<CR>
let g:sandwich#recipes += [
      \   {
      \     'buns'        : 'SandwichRubyMethodInput()',
      \     'filetype'    : ['ruby'],
      \     'kind'        : ['add', 'replace'],
      \     'action'      : ['add'],
      \     'input'       : ['m'],
      \     'listexpr'    : 1,
      \     'nesting'     : 1,
      \   },
      \   {
      \     'buns'        : ['#{', '}'],
      \     'filetype'    : ['ruby'],
      \     'kind'        : ['add', 'replace'],
      \     'action'      : ['add'],
      \     'input'       : ['s'],
      \     'nesting'     : 1,
      \   },
      \   {
      \     'buns'        : ['${', '}'],
      \     'filetype'    : ['javascript', 'javascriptreact'],
      \     'kind'        : ['add', 'replace'],
      \     'action'      : ['add'],
      \     'input'       : ['s'],
      \     'nesting'     : 1,
      \   },
      \   {
      \     'buns'        : ['${', '}'],
      \     'filetype'    : ['javascript', 'javascriptreact'],
      \     'kind'        : ['add', 'replace'],
      \     'action'      : ['add'],
      \     'input'       : ['s'],
      \     'nesting'     : 1,
      \   },
      \   {
      \     'buns'        : 'SandwichRubyArrayInput()',
      \     'filetype'    : ['ruby'],
      \     'kind'        : ['add', 'replace'],
      \     'action'      : ['add'],
      \     'input'       : ['a'],
      \     'listexpr'    : 1,
      \     'nesting'     : 1,
      \   },
      \ ]

function! SandwichRubyMethodInput() abort
  let s:MethodLast = input('Method: ')
  if s:MethodLast !=# ''
    let struct = 'def ' . s:MethodLast . '('
  else
    throw 'OperatorSandwichCancel'
  endif
  return [struct, ")\rend"]
endfunction

" enters w, or i, or whatever
function! SandwichRubyArrayInput() abort
  let s:ArrayLast = input('Array type: ')
  if s:ArrayLast !=# ''
    let struct = '%' . s:ArrayLast . '('
  else
    throw 'OperatorSandwichCancel'
  endif
  return [struct, ')']
endfunction


