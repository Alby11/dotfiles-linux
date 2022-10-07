require("incline").setup()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<Leader>I", "<cmd>lua require('incline').toggle()<CR>", opts)
