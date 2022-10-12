if is_win then
  cmd([[
        let g:sqlite_clib_path=config_dir . '/databases/sqlite3.dll'
    ]])
end
local sqlite = require("sqlite")
