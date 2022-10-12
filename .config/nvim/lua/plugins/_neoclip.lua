require("neoclip").setup({
  history = 1000,
  -- enable_persistent_history = false,
  enable_persistent_history = true,
  length_limit = 1048576,
  -- continuous_sync = false,
  continuous_sync = true,
  -- db_path = vim.fn.stdpath("config") .. "/databases/neoclip.sqlite3",
  db_path = Config_dir .. "/databases/neoclip.sqlite3",
  filter = nil,
  preview = true,
  default_register = '"',
  default_register_macros = "q",
  enable_macro_history = true,
  content_spec_column = false,
  on_paste = {
    set_reg = false,
  },
  on_replay = {
    set_reg = false,
  },
  keys = {
    telescope = {
      i = {
        select = "<cr>",
        paste = "<c-p>",
        paste_behind = "<c-k>",
        replay = "<c-q>", -- replay a macro
        delete = "<c-d>", -- delete an entry
        custom = {},
      },
      n = {
        select = "<cr>",
        paste = "p",
        --- It is possible to map to more than one key.
        -- paste = { 'p', '<c-p>' },
        paste_behind = "P",
        replay = "q",
        delete = "d",
        custom = {},
      },
    },
  },
})

if not is_vscode == 0 then
  require("telescope").load_extension("neoclip")
  vim.keymap.set("n", "<leader>tn", ":Telescope neoclip<cr>", { noremap = true, silent = true })
end
