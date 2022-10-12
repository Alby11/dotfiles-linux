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
