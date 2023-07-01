--vim.g.material_style = "deep ocean"
--vim.cmd 'colorscheme material'

vim.g.gruvbox_flat_style = "hard"
vim.cmd 'colorscheme gruvbox-flat'
require('lualine').setup {
  options = {
    theme = 'gruvbox-flat'
  }
}
