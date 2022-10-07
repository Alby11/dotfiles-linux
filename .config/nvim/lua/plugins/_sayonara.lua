vim.cmd([[let g:sayonara_confirm_quit = 1]])

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<Leader>bs", "<Cmd>Sayonara<CR>", opts)
