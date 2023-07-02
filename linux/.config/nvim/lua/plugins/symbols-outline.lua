map('n', '<leader>s', ':SymbolsOutline<CR>', {noremap = true, silent = true})

return {
  'simrat39/symbols-outline.nvim',
  config = function() require'symbols-outline'.setup() end
}
