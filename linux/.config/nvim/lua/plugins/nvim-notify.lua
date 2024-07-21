return {
  'rcarriga/nvim-notify',
  config = function()
    require('notify').setup({
      -- other stuff
      background_colour = "#000000",
      render = "wrapped-compact",
      animation = "fade_in_slide_out",
      max_width = 50,
    })
  end
}
