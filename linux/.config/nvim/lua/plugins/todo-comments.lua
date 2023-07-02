return {
  'folke/todo-comments.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  dependencies = 'nvim-lua/plenary.nvim',
  config = function() require("todo-comments").setup {} end
}
