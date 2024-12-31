return {
  'nvim-telescope/telescope.nvim',
  event = "VimEnter",
  dependencies = {
    { 'nvim-lua/plenary.nvim' }, {
      "molecule-man/telescope-menufacture",
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

    vim.keymap.set('n', '<C-P>', require('telescope').extensions.menufacture.find_files, { silent = true })
    vim.keymap.set('n', '<C-F>', require('telescope').extensions.menufacture.live_grep, { silent = true })
  end
}
