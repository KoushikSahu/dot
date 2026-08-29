return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ lsp_format = 'fallback', async = true })
      end,
      mode = { 'n', 'x' },
      desc = 'Format Buffer/Selection',
    },
  },
  opts = {
    formatters_by_ft = {
      cpp = { 'clang-format' },
      javascript = { 'prettier' },
      lua = { 'luaformatter' },
      typescript = { 'prettier' },
      python = { 'isort', 'autopep8' },
      rust = { 'rustfmt' },
      cs = { 'csharpier' },
      markdown = { 'prettier' },
      json = { 'prettier' },
      go = { 'gofumpt' },
      kotlin = { 'ktfmt' },
    },
  },
}