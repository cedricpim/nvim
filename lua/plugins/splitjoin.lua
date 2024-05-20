return {
  'Wansmer/treesj',
  keys = { '<space>v', '<space>j', '<space>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function() require('treesj').setup() end,
}
