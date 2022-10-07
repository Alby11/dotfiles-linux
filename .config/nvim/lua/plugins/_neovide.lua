vim.cmd([[
    let g:neovide_transparency=0.95
    let g:neovide_floating_blur_amount_x = 2.0
    let g:neovide_floating_blur_amount_y = 2.0
    let g:neovide_remember_window_size = v:true
    let g:neovide_scroll_animation_length = 0.3
    let g:neovide_cursor_trail_length=0.8
    let g:neovide_cursor_antialiasing=v:true
    let g:neovide_cursor_trail_length=0.8
    let g:neovide_cursor_vfx_mode = "torpedo"
    let g:neovide_cursor_vfx_mode = "sonicboom"
    let g:neovide_cursor_vfx_opacity=100.0
    let g:neovide_cursor_vfx_particle_lifetime=1.0
    let g:neovide_cursor_vfx_particle_density=5.0
    let g:neovide_cursor_vfx_particle_speed=10.0
    set guifont=CaskaydiaCove\ NF:h9,FiraCode\ NF:h9,Consolas:h9
]])

vim.g.gui_font_default_size = 9
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "CaskaydiaCove NF,FiraCode NF, Consolas"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set({ "n", "i" }, "<C-+>", function()
  ResizeGuiFont(1)
end, opts)
vim.keymap.set({ "n", "i" }, "<C-->", function()
  ResizeGuiFont(-1)
end, opts)
