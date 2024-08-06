return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters_by_ft = {
      cpp = { 'cpplint' },
      lua = { 'luacheck' },
      python = { 'mypy' },
      json = { 'jsonlint' },
      typescript = { 'eslint_d' },
      javascript = { 'eslint_d' },
      cs = { 'trivy' },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
