map("n", "<C-n>", ":NvimTreeToggle <CR>")

return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  tag = 'nightly', -- optional, updated every week. (see issue #1193)
  config = function()
    require("nvim-tree").setup()
  end
}
