return {
  'nvim-telescope/telescope.nvim',
  event = "VimEnter",
  dependencies = {
    { 'nvim-lua/plenary.nvim' }, {
    "nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0"
  }
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = { mappings = { i = { ["<esc>"] = actions.close } } }
    })

    map("n", "<C-P>",
      "<cmd>lua require('telescope.builtin').find_files()<cr>")
    map("n", "<C-F>",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
  end
}
