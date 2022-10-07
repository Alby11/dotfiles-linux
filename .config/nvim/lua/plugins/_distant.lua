local actions = require('distant.nav.actions')
require('distant').setup {
  -- Any settings defined here are applied to all hosts
  ['*'] = {
    distant = {
      args = '--shutdown-after 60',
      bin = 'distant'
    },
    file = {
      mappings = {
        ['-'] = actions.up,
      },
    },
    dir = {
      mappings = {
        ['<Return>'] = actions.edit,
        ['-']        = actions.up,
        ['K']        = actions.mkdir,
        ['N']        = actions.newfile,
        ['R']        = actions.rename,
        ['D']        = actions.remove,
      }
    },
  },

  -- Any settings defined here are applied only to example.com
  -- ['example.com'] = {
  --   distant = {
  --     bin = '/path/to/distant',
  --   },
  --   lsp = {
  --     ['My Rust Project'] = {
  --       cmd = { '/path/to/rust-analyzer' },
  --       filetypes = { 'rust' },
  --       root_dir = '/path/to/project-rs',
  --       on_attach = function()
  --         nnoremap('gD', '<CMD>lua vim.lsp.buf.declaration()<CR>')
  --         nnoremap('gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
  --         nnoremap('gh', '<CMD>lua vim.lsp.buf.hover()<CR>')
  --         nnoremap('gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
  --         nnoremap('gr', '<CMD>lua vim.lsp.buf.references()<CR>')
  --       end,
  --     },
  --   },
  -- },
}
