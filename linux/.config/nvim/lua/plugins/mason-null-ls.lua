return {
  'jay-babu/mason-null-ls.nvim',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  dependencies = {
    'williamboman/mason.nvim',
    'jose-elias-alvarez/null-ls.nvim',
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = {},
      automatic_installation = true,
      handlers = {},
    })
  end
}
