-- Functional wrapper for mapping custom keybindings
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

if vim.fn.exists("g:vscode") == 1 then
  map("n", "z=", "vim.fn.VSCodeNotify('keyboard-quickfix.openQuickFix')<cr>", { noremap = true, silent = true })
end

-- toggle search highlight
vim.cmd([[
    nnoremap <silent><expr> <Leader>HH (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
    ]])

-- toggle spell check
vim.keymap.set("n", "<Leader>SS", function()
  vim.o.spell = not vim.o.spell
  print("spell: " .. tostring(vim.o.spell))
end)

-- Quit, close buffers, etc.
map("n", "<leader>q", "<cmd>q<cr>", opts)
map("n", "<leader>qa", "<cmd>qa<cr>", opts)
map("n", "<leader>Q", "<cmd>q!<cr>", opts)
map("n", "<leader>QA", "<cmd>qa!<cr>", opts)
map("n", "<leader>x", "<cmd>x!<cr>", opts)

-- Save buffer
map("i", "<c-s>", "<esc><cmd>w<cr>a", opts)
map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>W", "<cmd>w!<cr>", opts)

-- Esc in the terminal
map("t", "jj", [[<C-\><C-n>]], opts)

-- Yank to clipboard
map("n", "y+", "<cmd>set opfunc=util#clipboard_yank<cr>g@", opts)
map("v", "y+", "<cmd>set opfunc=util#clipboard_yank<cr>g@", opts)

-- Window movement
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)
map("n", "<c-l>", "<c-w>l", opts)

-- Tab movement
map("n", "<c-Left>", "<cmd>tabpre<cr>", opts)
map("n", "<c-Right>", "<cmd>tabnext<cr>", opts)

-- Dot-Repeat in Vim and Neovim
-- https://www.vikasraj.dev/blog/vim-dot-repeat
-- function _G.__dot_repeat(motion)
--   local is_visual = string.match(motion or "", "[vV]") -- 2.
--
--   if not is_visual and motion == nil then
--     vim.o.operatorfunc = "v:lua.__dot_repeat"
--     return "g@"
--   end
--
--   if is_visual then
--     print("VISUAL mode")
--   else
--     print("NORMAL mode")
--   end
--
--   local range = { -- 3.
--     starting = vim.api.nvim_buf_get_mark(0, is_visual and "<" or "["),
--     ending = vim.api.nvim_buf_get_mark(0, is_visual and ">" or "]"),
--   }
--
--   print(vim.inspect(range))
-- end
--
-- vim.keymap.set("n", "gt", _G.__dot_repeat, { expr = true })
-- vim.keymap.set("x", "gt", "<ESC><CMD>lua _G.__dot_repeat(vim.fn.visualmode())<CR>") -- 1.
