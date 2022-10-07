local vim = vim
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

-- Leader/local leader
g.mapleader = " "
-- g.maplocalleader = " "

-- Skip some remote provider loading
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  "gzip",
  "man",
  "matchit",
  "matchparen",
  "netrwPlugin",
  "shada_plugin",
  "tar",
  "tarPlugin",
  "zip",
  "zipPlugin",
}

for i = 1, 10 do
  g["loaded_" .. disabled_built_ins[i]] = 1
end

-- Settings
local opt = vim.opt
opt.modifiable = true
opt.swapfile = false -- Don't create Swap Files
-- opt.undodir = vim.fn.stdpath("cache") .. "/undo"
-- opt.undofile = true -- Save undo history
-- opt.updatetime = 100 -- Decrease update time
