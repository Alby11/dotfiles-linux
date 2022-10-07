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
opt.autochdir = true -- cd to file dir
opt.autoread = true -- set to auto read when a file is changed from the outside
opt.backup = false -- Disable Backup
opt.breakindent = true -- Enable break indent
opt.cc = "80" -- set an 80 column border for good coding style
opt.clipboard = "unnamedplus" -- using system clipboard if supported (vim --version and look for +clipboard or +xterm_clipboard)
opt.cmdheight = 1 -- Better Error Messages
opt.concealcursor = "nc"
opt.conceallevel = 2
opt.cursorline = true
opt.display = "msgsep"
opt.encoding = "utf-8"
opt.expandtab = true
opt.fileencoding = "utf-8" -- Set File Encoding
opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.hidden = true -- Do not save when switching buffers
opt.hlsearch = false -- Set highlight on search
opt.ignorecase = true -- Case insensitive searching
opt.inccommand = "nosplit" -- Incremental live completion
opt.joinspaces = false
opt.laststatus = 3
opt.lazyredraw = true
opt.list = true
opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<,space:." -- see while spaces
opt.modeline = false
opt.modifiable = true
-- opt.mouse = "a" -- Enable mouse mode
opt.mouse = "nivh"
opt.number = true -- Display Line Number
opt.previewheight = 5
opt.pumheight = 10 -- Pop up Menu Height
opt.relativenumber = true -- Make relative line numbers default
opt.scrolloff = 7 -- Vertical Scroll Offset
opt.shada = [['20,<50,s10,h,/100]]
opt.shiftwidth = 2
-- opt.shortmess:append("c")
opt.shortmess:append({ W = true, a = true })
opt.showmatch = true
opt.showmode = false -- Don't Show MODES
opt.showtabline = 2 -- Always Show Tabline
opt.sidescrolloff = 8 -- Horizontal Scroll Offset
opt.signcolumn = "yes" -- Sign Column
opt.signcolumn = "yes:1" -- Sign Column
opt.smartcase = true -- If Upper Case Char > case sensitive search
opt.smartindent = true -- Smart Indenting
opt.smarttab = true -- Smart Tabs
-- opt.softtabstop = 0
opt.softtabstop = 2
opt.spell = false -- enable spell check (may need to download language package)
opt.spellfile = Config_dir .. "/spell/mywords.utf-8.add"
opt.spelllang = "en,it,fr"
opt.splitbelow = true -- Force Split Below
opt.splitright = true -- Force Split Right
opt.swapfile = false -- Don't create Swap Files
opt.synmaxcol = 500
opt.tabstop = 2 -- Tabstop
opt.termencoding = "utf-8"
opt.termguicolors = true -- Set Terminal Colors
opt.textwidth = 100
opt.timeoutlen = 250 -- Time for mapped sequence to complete (in ms)
opt.title = true -- Display File Info on Title
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.undofile = true -- Save undo history
opt.updatetime = 100 -- Decrease update time
opt.whichwrap:append("<,>,h,l")
opt.wildignore = { "*.o", "*~", "*.pyc" }
opt.wildmode = "longest,full"
cmd([[set spelllang = "en, it, fr"]]) -- enable spell check (may need to download language package)

opt.termguicolors = true
opt.background = "dark"

-- Set shell
cmd([[
  if has('win32') " Use PowerShell Core
    set shell=pwsh "\ -NoLogo
    set shellpipe=\|
    set shellxquote=
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
  elseif has('wsl')
    set shell=/usr/bin/zsh
  elseif has('linux')
    set shell=/bin/bash
  endif
  ]])

-- GUI options
cmd([[set guifont=CaskaydiaCove\ NF:h9,FiraCode\ NF:h9,Consolas:h9]])
if fn.exists("g:neovide") then
  require("_neovide")
elseif fn.exists("g:fvim_loaded") then
  require("_fvim")
end
