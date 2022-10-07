" Deal with trailing spaces
command! DeleteTrailingSpaces :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" CDC = Change to Directory of Current file
command CDC cd %:p:h

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
