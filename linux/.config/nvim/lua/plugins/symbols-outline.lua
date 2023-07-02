map('n', '<leader>s', ':SymbolsOutline<CR>', {noremap = true, silent = true})

return {
  'simrat39/symbols-outline.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  config = function() require'symbols-outline'.setup() end
}
