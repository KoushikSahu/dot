require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    color_icons = true,
    show_buffer_icons = true,
    buffer_close_icon = '',
    indicator = {
      style = 'underline',
    },
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  },
}
