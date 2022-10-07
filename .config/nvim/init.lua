-- cd to home direcotory if not opening a file
local vim = vim
local fn = vim.fn
local cmd = vim.cmd

-- set config directory
if vim.loop.os_uname().sysname == "Windows_NT" then
  Config_dir = os.getenv("OneDriveConsumer") .. "/profileFiles/nvim"
else
  Config_dir = fn.stdpath("config")
end

cmd([[
  if has('win32')
    redir => config_dir
    lua print(Config_dir)
    redir end
    lua print("")
  else
    let config_dir = stdpath('config')
  endif
]])

-- add dirs to package.path
package.path = Config_dir .. "/lua/?.lua" .. ";" .. package.path
package.path = Config_dir .. "/lua/plugins/?.lua" .. ";" .. package.path
package.path = Config_dir .. "/lua/config/?.lua" .. ";" .. package.path

if fn.exists("g:vscode") == 1 then
  require("basic-vscode")
  require("mappings")
  require("plugins-vscode")
else
  require("basic-neovim")
  require("mappings")
  require("autocommands")
  require("commands")
  require("plugins-neovim")
end
