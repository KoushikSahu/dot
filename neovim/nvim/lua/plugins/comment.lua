return {
  {
    'folke/todo-comments.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require("todo-comments").setup {} end,
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Search Todo Comments" },
      { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Search Todo And Fix Comments" },
      { "<leader>td", "<cmd>TodoQuickFix<CR>",                                                               desc = "Open Todo Quickfix" },
    },
  },
  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function() require('Comment').setup() end
  }
}
