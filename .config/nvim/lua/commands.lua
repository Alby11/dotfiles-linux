local vim = vim
local cmd = vim.cmd

cmd([[
  function! Fix_dos()
      " This would be the correct syntax, but no need for :normal:
      "execute "normal :e ++ff=dos\<cr>"
      " Also, no need for execute:
      "execute "e ++ff=dos"
      edit ++ff=dos
  endfunction
  :command! FixDos edit ++ff=dos
]])
