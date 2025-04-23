return {
  'stevearc/quicker.nvim',
  event = "VeryLazy",
  config = function()
    require('quicker').setup({
      edit = {
        autosave = true,
      }
    })
  end,
}
