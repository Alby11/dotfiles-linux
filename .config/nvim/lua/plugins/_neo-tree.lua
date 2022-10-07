vim.g.neo_tree_remove_legacy_commands = true
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<Leader>N", "<Cmd>Neotree toggle reveal_force_cwd<CR>", opts)
map("n", "<Leader>n", "<Cmd>Neotree reveal<CR>", opts)

-- barbar.nvim integration
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      require("bufferline.state").set_offset(31, "FileTree")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    if vim.fn.expand("<afile>"):match("NvimTree") then
      require("bufferline.state").set_offset(0)
    end
  end,
})
