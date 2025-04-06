return {
  {
    'folke/todo-comments.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require("todo-comments").setup {} end,
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
      { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
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
