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
  log = { level = "trace" }, -- The default print log level. One of: "trace", "debug", "info", "warn", "error",
})

---- Automatically set up your configuration after cloning packer.nvim
if packer_bootstrap then
  Packer.install()
end

cmd([[colorscheme slate]])

if CheckPlugin("catppuccin") then
  cmd([[colorscheme catppuccin]])
end

if CheckPlugin("notify") then
  Notify = require("notify")
  Notify.setup({
    stages = "fade",
    background_colour = "FloatShadow",
    timeout = 3000,
  })
  -- show a notification when PackerCompile finishes
  autocmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
      Notify("PackerCompile done", "info")
    end,
  })
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

  -- Buffer management
  use({
    "romgrk/barbar.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = get_setup("bufferline"),
  })
  -- say sayonara to buffers
  use({
    "mhinz/vim-sayonara",
    config = get_setup("sayonara"),
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
        { "junegunn/fzf", dir = "~/.fzf", run = "./install.ps1" },
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

  -- clipboard to sqlite
  use({
    "AckslD/nvim-neoclip.lua",
    requires = {
      "kkharji/sqlite.lua",
      config = get_setup("sqlite"),
    },
    config = get_setup("neoclip"),
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
        "sindrets/diffview.nvim",
        config = get_setup("diffview"),
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
    -- "nvim-treesitter/Highlight.lua",
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
      "tamago324/cmp-zsh",
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

  -- misc
  use({
    "lambdalisue/suda.vim",
  })
  use({
    "kosayoda/nvim-lightbulb",
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
      -- config = require("colorizer").setup(),
    },
  })

  -- Pretty UI
  use({
    {
      "catppuccin/nvim",
      as = "catppuccin",
      requires = {
        "kyazdani42/nvim-web-devicons",
        "yamatsum/nvim-nonicons",
      },
      config = get_setup("catppuccin"),
    },
    {
      "nvim-lualine/lualine.nvim",
      config = get_setup("lualine"),
    },
    {
      "b0o/incline.nvim",
      config = get_setup("incline"),
    },
    "stevearc/dressing.nvim",
    "rcarriga/nvim-notify",
    "vigoux/notifier.nvim",
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  })

  -- toggle terminal
  use({
    "akinsho/toggleterm.nvim",
    tag = "v2.*",
    config = get_setup("toggleterm"),
  })

  -- nvim cheatsheet
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
