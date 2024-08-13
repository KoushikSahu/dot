return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  config = function()
    require('Comment').setup()
  end
}
