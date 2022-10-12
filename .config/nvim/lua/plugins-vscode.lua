-- Ensure packer is installed
local ensure_packer = function()
  local install_path = Stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if Fn.empty(Fn.glob(install_path)) > 0 then
    Fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    Cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

CheckPlugin = function(pluginID)
  local status, pluginID = pcall(require, pluginID)
  if status then
    return true
  end
  print(string.format("%s is not installed", pluginID))
  return false
end

if CheckPlugin("packer") then
  Packer = require("packer")
  Util = require("packer.util")
  Init = Packer.init
else
  local packer_bootstrap = ensure_packer()
end

Init({
  auto_reload_compiled = true,
  display = {
    open_fn = function()
      local result, win, buf = Util.float({
        border = {
          { "╭", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╮", "FloatBorder" },
          { "│", "FloatBorder" },
          { "╯", "FloatBorder" },
          { "─", "FloatBorder" },
          { "╰", "FloatBorder" },
          { "│", "FloatBorder" },
        },
      })
      Api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
      return result, win, buf
    end,
  },
})

---- Automatically set up your configuration after cloning packer.nvim
if packer_bootstrap then
  Packer.sync()
end

-- PackerCompile on save if your config file is in plugins.lua or catppuccin.lua
Autocmd("BufWritePost", {
  pattern = { "plugins-neovim.lua" },
  callback = function()
    -- vim.cmd("source %")
    Cmd("PackerCompile")
  end,
})

local get_setup = function(name)
  return string.format("require('plugins._%s')", name)
end

Packer.reset()

return Packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })

  use({
    "lewis6991/impatient.nvim",
    config = get_setup("impatient"),
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

  -- Folding
  use({
    "kevinhwang91/nvim-ufo",
    requires = {
      "kevinhwang91/promise-async",
    },
    config = get_setup("ufo"),
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
    "AckslD/nvim-neoclip.lua",
    requires = {
      "kkharji/sqlite.lua",
      config = get_setup("sqlite"),
    },
    config = get_setup("neoclip"),
  })

end)
