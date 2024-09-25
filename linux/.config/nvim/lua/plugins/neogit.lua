map("n", "<leader>gg", ":Neogit<CR>", { silent = true })

return {
  'NeogitOrg/neogit',
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require('neogit').setup {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true
      }
    }
  end,
}
