local pluginID = "leap"
if not checkPlugin(pluginID) then return end

require('leap').setup {
  max_aot_targets = nil,
  highlight_unlabeled = false,
  case_sensitive = false,
  -- Sets of characters that should match each other.
  -- Obvious candidates are braces and quotes ('([{', ')]}', '`"\'').
  equivalence_classes = { ' \t\r\n', },
  -- Leaving the appropriate list empty effectively disables "smart" mode,
  -- and forces auto-jump to be on or off.
  safe_labels = {},
  labels = {},
  special_keys = {
    repeat_search  = '<enter>',
    next_aot_match = '<enter>',
    next_match     = { ';', '<enter>' },
    prev_match     = { ',', '<tab>' },
    next_group     = '<space>',
    prev_group     = '<tab>',
  },
}

vim.keymap.set({'n', 'x', 'o'}, '<leader>l', function() require'leap-ast'.leap() end, {})