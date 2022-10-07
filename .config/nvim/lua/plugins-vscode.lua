local vim = vim
local api = vim.api
local fn = vim.fn
local autocmd = api.nvim_create_autocmd
local stdpath = fn.stdpath
local execute = api.nvim_command
local has = function(x)
  return fn.has(x) == 1
end
local executable = function(x)
  return fn.executable(x) == 1
end
local is_wsl = (function()
  local output = fn.systemlist("uname -r")
  return not not string.find(output[1] or "", "WSL")
end)()
local is_mac = has("macunix")
local is_linux = not is_wsl and not is_mac
local max_jobs = nil
if is_mac then
  max_jobs = 32
end

-- Ensure packer is installed
local ensure_packer = function()
  local install_path = stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

function checkPlugin(pluginID)
  local status, pluginID = pcall(require, pluginID)
  if status then
    return true
  end
  print(string.format("%s is not installed", pluginID))
  return false
end

if checkPlugin("packer") then
  packer = require("packer")
  util = require("packer.util")
  init = packer.init
else
  local packer_bootstrap = ensure_packer()
end

init({
  auto_reload_compiled = true,
  compile_path = util.join_paths(
    stdpath("data"),
    "site",
    "pack",
    "loader",
    "start",
    "packer.nvim",
    "plugin",
    "packer-vscode.lua"
  ),
})

-- PackerCompile on save if your config file is in plugins-vscode.lua
autocmd("BufWritePost", {
  pattern = { "plugins-vscode.lua" },
  callback = function()
    vim.cmd("PackerCompile")
  end,
})

local get_setup = function(name)
  return string.format("require('plugins._%s')", name)
  --    if checkPlugin(name) then
  --    end
end

packer.reset()

return packer.startup(function(use)
  -- add you plugins here

  use({ "wbthomason/packer.nvim" })

  use({
    "lewis6991/impatient.nvim",
    config = get_setup("impatient"), -- may very based on config
  })

  use({
    "elijahmanor/export-to-vscode.nvim",
    config = get_setup("export-to-vscode"),
  })

  -- Movement
  use({
    {
      "phaazon/hop.nvim",
      branch = "v2", -- optional but strongly recommended
      config = get_setup("hop"),
    },
    {
      "ethanholz/nvim-lastplace",
      config = get_setup("nvim-lastplace"),
    },
  })

  -- Commenting
  use({
    "numToStr/Comment.nvim",
    config = get_setup("Comment"),
  })

  -- Wrapping/delimiters
  use({
    "tpope/vim-surround",
  })

  -- Text objects
  use({
    "wellle/targets.vim",
  })

  -- clipboard to sqlite
  use({
    {
      "AckslD/nvim-neoclip.lua",
      requires = {
        "kkharji/sqlite.lua",
        config = get_setup("sqlite"),
      },
      config = get_setup("neoclip"),
    },
  })
end)
