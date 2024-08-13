map("n", "<C-P>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<C-F>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")

return {
  'nvim-telescope/telescope.nvim',
  event = "VimEnter",
  dependencies = { {'nvim-lua/plenary.nvim'} },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    })
  end
}
