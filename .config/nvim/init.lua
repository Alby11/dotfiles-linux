require("globals")

if is_vscode then
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