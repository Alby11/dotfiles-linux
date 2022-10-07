augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

augroup vimrc
    au BufReadPre * setlocal foldmethod=indent " sets 'indent' as the fold method before a file is loaded, so that indent-based folds will be defined
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif "allows you to manually create folds while editing. It's executed after the modeline is read, so it won't change the fold method if the modeline set the fold method to something else"
augroup END

" *last-position-jump*
"   This autocommand jumps to the last known position in a file
"   just after opening it, if the '" mark is set:
:au BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif

" Set indentation to 2 spaces for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab " 
" Set indentation to 4 spaces for yaml files
autocmd FileType py setlocal ts=4 sts=4 sw=4 expandtab " 

" Set to auto read when a file is changed from the outside
au FocusGained,BufEnter * checktime