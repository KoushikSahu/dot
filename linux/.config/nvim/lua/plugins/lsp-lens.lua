return {
  'VidocqH/lsp-lens.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  config = function()
    require 'lsp-lens'.setup({})
  end,
}
