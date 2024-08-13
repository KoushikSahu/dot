return {
  'akinsho/git-conflict.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  cond = function()
    return vim.fn.finddir(".git", ".;") ~= ""
  end
}
