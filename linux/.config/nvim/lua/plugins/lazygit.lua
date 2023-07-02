map("n", "<leader>gg", ":LazyGit<CR>", { silent = true })

return {
  'kdheepak/lazygit.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  cond = function()
    return vim.fn.finddir(".git", ".;") ~= ""
  end
}
