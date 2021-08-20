" 'ludovicchabant/vim-gutentags'

" Gutentags {{{
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git']

" Make it faster by ignoring these files
let g:gutentags_ctags_exclude = [
  \ '*.git', '*.svg', '*.hg',
  \ '*/tests/*',
  \ 'build',
  \ 'dist',
  \ 'bin',
  \ 'node_modules',
  \ 'cache',
  \ 'compiled',
  \ 'bundle',
  \ 'vendor',
  \ '*.md',
  \ '*-lock.json',
  \ '*.lock',
  \ '*bundle*.js',
  \ '*build*.js',
  \ '.*rc*',
  \ '*.json',
  \ '*.min.*',
  \ '*.map',
  \ '*.bak',
  \ '*.zip',
  \ '*.tmp',
  \ 'tags*',
  \ 'cscope.*',
  \ '*.css',
  \ '*.less',
  \ '*.scss',
  \ '*.swp', '*.swo',
  \ ]
" }}}

