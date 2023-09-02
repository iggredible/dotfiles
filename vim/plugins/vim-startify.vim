" -------------------------
" Configs
" -------------------------

let g:startify_bookmarks = [ {'vc': '~/Project/dotfiles/vim/'}, {'zc': '~/.zshrc'}, {'tc': '~/Project/dotfiles/tmux.conf'} ]
let g:startify_update_oldfiles = 0
let g:startify_files_number = 5

let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
      \ ]

let g:startify_custom_header = [
      \'                              .-o',
      \'                 .           /  |',
      \'        .                 . /   |   .',
      \'                           /    |',
      \'                  .       /     |',
      \'  .                      /      /         .',
      \'             .          /    _./   .',
      \'                   _.---~-.=:_',
      \'                  (_.-=() <~`-`-.',
      \'                 _/ _() ~`-==-._,>',
      \'         ..--====--" `~-._.__()',
      \'     o==="~~              |__()',
      \'                .         \   |             .',
      \'                           \  \',
      \'                            \  \     .',
      \'        .                    \  \           ',
      \'                 .            \  \          ',
      \'                               \_ \        .',
      \'                       LS        ~o',
      \]
