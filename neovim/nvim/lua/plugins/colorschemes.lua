return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
      background = "hard",
      float_style = "dim",
      inlay_hints_background = "dimmed",
    })
  end,
}
