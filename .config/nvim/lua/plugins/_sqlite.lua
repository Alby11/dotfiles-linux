if vim.fn.has('win32') then
    vim.cmd([[
      if has('win32')
        let g:sqlite_clib_path = "C:/Users/" .. $USERNAME .. "/OneDrive/profileFiles/nvim/databases/sqlite3.dll"
      endif
    ]])
end
local sqlite = require'sqlite'
