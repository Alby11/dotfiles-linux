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
    "packer.lua"
  ),
  display = {
    open_fn = function()
      local result, win, buf = util.float({
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
      api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
      return result, win, buf
    end,
  },
})

---- Automatically set up your configuration after cloning packer.nvim
if packer_bootstrap then
  packer.sync()
else
  vim.cmd([[colorscheme evening]])
  --if has("linux") then
  --  if checkPlugin("catppuccin") then
  --    vim.cmd([[colorscheme catppuccin]])
  --  end
  --end
end

if checkPlugin("notify") then
  vim.notify = require("notify")
  require("notify").setup({
    stages = "fade",
    background_colour = "FloatShadow",
    timeout = 3000,
  })
  -- Create an autocmd User PackerCompileDone to update it every time packer is compiled
  if checkPlugin("catppuccin") then
    autocmd("User", {
      pattern = "PackerCompileDone",
      callback = function()
        vim.cmd("CatppuccinCompile")
        vim.defer_fn(function()
          vim.cmd("colorscheme catppuccin")
        end, 0) -- Defered for live reloading
      end,
    })
  end
  -- show a notification when PackerCompile finishes
  autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
      vim.notify("PackerCompile done", "info")
    end,
  })
end

-- PackerCompile on save if your config file is in plugins.lua or catppuccin.lua
autocmd("BufWritePost", {
  pattern = { "plugins-neovim.lua", "_catppuccin.lua" },
  callback = function()
    -- vim.cmd("source %")
    vim.cmd("PackerCompile")
  end,
})

local get_setup = function(name)
  return string.format("require('plugins._%s')", name)
end

packer.reset()

return packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })

  use({
    "lewis6991/impatient.nvim",
    config = get_setup("impatient"),
  })

  use({
    "elijahmanor/export-to-vscode.nvim",
    config = get_setup("export-to-vscode"),
  })

  -- Buffer management
  use({
    {
      "mhinz/vim-sayonara",
      config = get_setup("sayonara"),
    },
    {
      "romgrk/barbar.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = get_setup("bufferline"),
    },
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

  -- Indentation tracking
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = get_setup("indent_blankline"),
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

  -- Telescope
  use({
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        "BurntSushi/ripgrep",
        "nvim-lua/plenary.nvim",
        {
          "ahmedkhalf/project.nvim",
          config = get_setup("project_nvim"),
        },
        { "junegunn/fzf", dir = "~/.fzf", run = "./install --all" },
      },
      config = get_setup("telescope"),
    },
    "crispgm/telescope-heading.nvim",
    "cljoly/telescope-repo.nvim",
    "jvgrootveld/telescope-zoxide",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-frecency.nvim",
      requires = "kkharji/sqlite.lua",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      run = "make",
    },
  })

  -- Git stuff
  use({
    {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = get_setup("gitsigns"),
    },
    {
      "TimUntersberger/neogit",
      requires = {
        {
          "sindrets/diffview.nvim",
          config = get_setup("diffview"),
        },
      },
      config = get_setup("neogit"),
    },
    {
      "akinsho/git-conflict.nvim",
      tag = "*",
      config = function()
        require("git-conflict").setup()
      end,
    },
  })

  -- code runner
  -- REPLs
  use({
    {
      "hkupty/iron.nvim",
      config = get_setup("iron"),
    },
    {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      config = get_setup("sniprun"),
    },
  })

  use({
    "winston0410/cmd-parser.nvim",
    -- highlight range written in cmeline
    {
      "winston0410/range-highlight.nvim",
      config = get_setup("range-highlight"),
    },
    -- Highlight chunk of code
    {
      "folke/twilight.nvim",
      config = get_setup("twilight"),
    },
    -- Highlight colors
    {
      "norcalli/nvim-colorizer.lua",
      config = require("colorizer").setup(),
    },
  })

  -- Treesitter
  use({
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = get_setup("nvim-treesitter"),
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
    "nvim-treesitter/Highlight.lua",
    "RRethy/nvim-treesitter-endwise",
  })

  -- Path navigation
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = get_setup("neo-tree"),
  })

  -- LSP Support
  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "onsails/lspkind.nvim",
      "ray-x/lsp_signature.nvim",
      -- Autocompletion
      {
        "hrsh7th/nvim-cmp",
        "David-Kunz/cmp-npm",
        "Dosx001/cmp-commit",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "lukas-reineke/cmp-under-comparator",
        "petertriho/cmp-git",
        "saadparwaiz1/cmp_luasnip",
        "tzachar/cmp-fuzzy-buffer",
        "tzachar/fuzzy.nvim",
      },
      {
        "tamago324/cmp-zsh",
        cond = vim.fn.has("linux"),
      },
      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")
      lsp.setup()
    end,
  })

  -- null_ls
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = get_setup("null-ls"),
  })

  -- Quickfix
  use({
    "folke/trouble.nvim",
    config = get_setup("trouble"),
  })

  -- Debugger
  use({
    "mfussenegger/nvim-dap",
    requires = {
      "Pocco81/dap-buddy.nvim",
      {
        "rcarriga/nvim-dap-ui",
        config = get_setup("dapui"),
      },
    },
    config = get_setup("dap"),
  })

  -- Pretty UI
  use({
    {
      "catppuccin/nvim",
      as = "catppuccin",
      requires = {
        "yamatsum/nvim-nonicons",
        requires = "kyazdani42/nvim-web-devicons",
      },
      config = get_setup("catppuccin"),
      -- run = ":CatppuccinCompile",
    },
    {
      "nvim-lualine/lualine.nvim",
      config = get_setup("lualine"),
    },
    {
      "b0o/incline.nvim",
      config = get_setup("incline"),
    },
    {
      "stevearc/dressing.nvim",
    },
    {
      "rcarriga/nvim-notify",
    },
    {
      "vigoux/notifier.nvim",
    },
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  })

  -- -- Tmux
  use({
    "aserowy/tmux.nvim",
    requires = {
      {
        "danielpieper/telescope-tmuxinator.nvim",
        requires = "nvim-telescope/telescope.nvim",
      },
      {
        "christoomey/vim-tmux-navigator",
      },
    },
    config = get_setup("tmux"),
  })

  -- Misc
  use({
    "lambdalisue/suda.vim",
  })
  use({
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = get_setup("toggleterm"),
  })
  -- neovim cheatsheet
  use({
    "sudormrfbin/cheatsheet.nvim",
    requires = {
      "nvim-lua/popup.nvim",
    },
  })
  -- keymap hints
  use({
    "folke/which-key.nvim",
    config = get_setup("which-key"),
  })

  -- Firenvim
  use({
    "glacambre/firenvim",
    run = function()
      fn["firenvim#install"](0)
    end,
  })
end)
