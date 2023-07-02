vim.g.gitblame_enabled = 1
vim.g.gitblame_message_template = '       <summary> • <date> • <author>'

return {
  'f-person/git-blame.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  cond = function()
    return vim.fn.finddir(".git", ".;") ~= ""
  end
}
