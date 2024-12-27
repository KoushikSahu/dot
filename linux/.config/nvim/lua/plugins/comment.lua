return {
  {
    'folke/todo-comments.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require("todo-comments").setup {} end
  },
  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
      require('Comment').setup()
      map('n', '<leader>td', ':TodoQuickFix<CR>')
    end
  }
}
