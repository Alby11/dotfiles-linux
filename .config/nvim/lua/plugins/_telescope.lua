local telescope = require("telescope")

telescope.setup({
  defaults = {
    theme = "catppuccin",
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    color_devicons = true,
    dynamic_preview_title = true,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    default_mappings = {
      ["i"] = {
        -- your custom insert mode Mappings
        ["<C-h>"] = "which_key",
      },
      ["n"] = {
        -- your custom normal mode Mappings
        -- ["<leader>tf"] = telescope.builtin.find_files,
      },
    },
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    }, -- the default case_mode is "smart_case"
    find_hidden = {
      hidden_files = true, -- default: false
    },
    tmuxinator = {
      select_action = "switch", -- | 'stop' | 'kill'
      stop_action = "stop", -- | 'kill'
      disable_icons = false,
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--smart-case", "--ignore", "--follow", "--hidden", "--files" },
    },
  },
})

-- you need to call load_extension, somewhere after setup function:
telescope.load_extension("fzf")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<leader>tf", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "<leader>to", ":Telescope oldfiles<cr>", opts)
map("n", "<leader>tb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "<leader>tB", "<cmd>lua require('telescope.builtin').builtin()<cr>", opts)
map("n", "<leader>tt", "<cmd>lua require('telescope.builtin').tags()<cr>", opts)
map("n", "<leader>tT", "<cmd>lua require('telescope.builtin').treesitter()<cr>", opts)
map("n", "<leader>tgC", "<cmd>lua require('telescope.builtin').git_commits()<cr>", opts)
map("n", "<leader>tgc", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", opts)
map("n", "<leader>tg", "<cmd>lua require('telescope.builtin').git_status()<cr>", opts)
map("n", "<leader>tgs", "<cmd>lua require('telescope.builtin').git_stash()<cr>", opts)
map("n", "<leader>tgb", "<cmd>lua require('telescope.builtin').git_branches()<cr>", opts)
map("n", "<leader>tC", "<cmd>lua require('telescope.builtin').commands()<cr>", opts)
map("n", "<leader>tc", "<cmd>lua require('telescope.builtin').command_history()<cr>", opts)
map("n", "<leader>t/", "<cmd>lua require('telescope.builtin').search_history()<cr>", opts)
map("n", "<leader>tk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", opts)
map("n", "<leader>tH", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
map("n", "<leader>tq", "<cmd>lua require('telescope.builtin').quickfix()<cr>", opts)
map("n", "<leader>tr", "<cmd>lua require('telescope.builtin').registers()<cr>", opts)
map("n", "<leader>tm", "<cmd>lua require('telescope.builtin').marks()<cr>", opts)
map("n", "<leader>tl", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)

telescope.load_extension("file_browser")
map("n", "<leader>tF", ":Telescope file_browser<cr>", opts)
telescope.load_extension("repo")
vim.keymap.set({ "n" }, "<leader>tp", ":Telescope repo list<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n" }, "<leader>t.p", ":Telescope repo cached_list<cr>", { noremap = true, silent = true })

local z_utils = require("telescope._extensions.zoxide.utils")
require("telescope._extensions.zoxide.config").setup({
  prompt_title = "[ Zoxide List ]",
  -- Zoxide list command with score
  list_command = "zoxide query -ls",
  mappings = {
    default = {
      action = function(selection)
        vim.cmd("cd " .. selection.path)
      end,
      after_action = function(selection)
        print("Directory changed to " .. selection.path)
      end,
    },
    ["<C-s>"] = { action = z_utils.create_basic_command("split") },
    ["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
    ["<C-e>"] = { action = z_utils.create_basic_command("edit") },
    ["<C-b>"] = {
      keepinsert = true,
      action = function(selection)
        builtin.file_browser({ cwd = selection.path })
      end,
    },
    ["<C-f>"] = {
      keepinsert = true,
      action = function(selection)
        builtin.find_files({ cwd = selection.path })
      end,
    },
  },
})
vim.keymap.set({ "n" }, "<leader>tz", ":Telescope zoxide list<cr>", { noremap = true, silent = true })

-- ripgrep
vim.o.grepprg = "rg --smart-case --ignore --follow --hidden"
