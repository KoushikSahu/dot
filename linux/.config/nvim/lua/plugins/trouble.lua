map('n', '<leader>tt', ':TroubleToggle <CR>', {silent = true})

return {
  'folke/trouble.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function() require("trouble").setup {} end
}
