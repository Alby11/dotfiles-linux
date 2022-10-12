require("globals")

if is_vscode then
  require("basic-vscode")
  require("mappings")
else
  require("basic-neovim")
  require("mappings")
  require("autocommands")
  require("commands")
end
require("plugins-pre")
