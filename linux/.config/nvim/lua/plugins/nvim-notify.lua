return {
  'rcarriga/nvim-notify',
  event = "VimEnter",
  config = function()
    require('notify').setup({
      -- other stuff
      render = "wrapped-compact",
      animation = "fade_in_slide_out",
      max_width = 50,
      top_down = false,
    })
  end
}
