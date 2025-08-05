return {
  'stevearc/quicker.nvim',
  event = "VeryLazy",
  config = function()
    require('quicker').setup({
      edit = {
        enabled = true,
        autosave = true,
      }
    })
  end,
}
