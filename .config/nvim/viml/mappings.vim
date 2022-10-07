" map leader to space
let mapleader = " "         " maps leader key <\> to <'>

" open below vertical terminal
" if has('nvim')
"     nmap <leader>tt :bel vs term://zsh<CR>
" else
"     nmap <leader>tt :bel vert term<CR>
" endif

" esc in insert & visual mode
inoremap jk <C-C> <esc>
" vnoremap jk <C-C> <esc>

" esc in command mode
" cnoremap jk <C-C> <esc>
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" existing which is Ctrl-C

" Copy to clipboard
" vnoremap  <leader>y  "+y
" nnoremap  <leader>Y  "+yg_
" nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy
" 
" Paste from clipboard
" nnoremap <leader>p "+p
" nnoremap <leader>P "+P
" vnoremap <leader>p "+p
" vnoremap <leader>P "+P

" Toggle search highlight
nnoremap <silent><expr> <Leader>HH (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
"
" Toggle spellchecking
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo "Spellcheck ON"
  else
    echo "Spellcheck OFF"
  endif
endfunction

nnoremap <silent> <Leader>SS :call ToggleSpellCheck()<CR>
