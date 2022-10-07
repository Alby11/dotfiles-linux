" integration with vim-cutlass
" 'cut' operator will be added to the yank history
let g:yoinkIncludeDeleteOperations = 1

" swap the most recent paste around in the yank history
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
if exists('g:vscode')
    nmap [y <plug>(YoinkPostPasteSwapBack)
    nmap ]y <plug>(YoinkPostPasteSwapForward)
endif
nmap [y <plug>(YoinkPostPasteSwapBack)
nmap ]y <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

" permanently cycle through the history
" nmap [y <plug>(YoinkRotateBack)
" nmap ]y <plug>(YoinkRotateForward)

" toggling whether the current paste is formatted or not
nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

" ursor position will not change after performing a yank
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)