"  Change the default mapping and the default command to invoke CtrlP:
let g:ctrlp_map = '<leader-p>'
let g:ctrlp_cmd = 'CtrlP'

" show hidden files
let g:ctrlp_show_hidden = 1

" max search history
let g:ctrlp_max_history = 1000

" follow symlinks
let g:ctrlp_follow_symlinks = 1

"  When invoked, unless a starting directory is specified, CtrlP will set its local working directory according to this variable:
let g:ctrlp_working_path_mode = 'ra'
