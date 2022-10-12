-- Functional wrapper for mapping custom keybindings
if is_vscode then
  Map("n", "z=", "vim.fn.VSCodeNotify('keyboard-quickfix.openQuickFix')<cr>", Opts)
end

-- toggle search highlight
Cmd([[
    nnoremap <silent><expr> <Leader>HH (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
    ]])

-- toggle spell check
vim.keymap.set("n", "<Leader>SS", function()
  vim.o.spell = not vim.o.spell
  print("spell: " .. tostring(vim.o.spell))
end)

-- Quit, close buffers, etc.
Map("n", "<leader>q", "<cmd>q<cr>", opts)
Map("n", "<leader>qa", "<cmd>qa<cr>", opts)
Map("n", "<leader>Q", "<cmd>q!<cr>", opts)
Map("n", "<leader>QA", "<cmd>qa!<cr>", opts)
Map("n", "<leader>x", "<cmd>x!<cr>", opts)

-- Save buffer
Map("i", "<c-s>", "<esc><cmd>w<cr>a", opts)
Map("n", "<leader>w", "<cmd>w<cr>", opts)
Map("n", "<leader>W", "<cmd>w!<cr>", opts)

-- Esc in the terminal
Map("t", "jj", [[<C-\><C-n>]], opts)

-- Yank to clipboard
Map("n", "y+", "<cmd>set opfunc=util#clipboard_yank<cr>g@", opts)
Map("v", "y+", "<cmd>set opfunc=util#clipboard_yank<cr>g@", opts)

-- Window movement
Map("n", "<c-h>", "<c-w>h", opts)
Map("n", "<c-j>", "<c-w>j", opts)
Map("n", "<c-k>", "<c-w>k", opts)
Map("n", "<c-l>", "<c-w>l", opts)

-- Tab movement
Map("n", "<c-Left>", "<cmd>tabpre<cr>", opts)
Map("n", "<c-Right>", "<cmd>tabnext<cr>", opts)

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
