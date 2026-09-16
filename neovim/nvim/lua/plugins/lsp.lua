return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'saghen/blink.cmp',
      { 'mason-org/mason-lspconfig.nvim', dependencies = { 'mason-org/mason.nvim' } },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local map = require('config.keymaps').map
      vim.opt.signcolumn = 'yes'

      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
          end

          map('n', 'K', function() vim.lsp.buf.hover() end,
            { buffer = bufnr, desc = 'Show Hover' })
          map('n', 'gs', function() vim.lsp.buf.signature_help() end,
            { buffer = bufnr, desc = 'Show Signature Help' })
          map('n', '<leader>rn', function() vim.lsp.buf.rename() end,
            { buffer = bufnr, desc = 'Rename Symbol' })
          map('n', '<leader>ca', function() vim.lsp.buf.code_action() end,
            { buffer = bufnr, desc = 'Code Action' })
        end,
      })

      require('mason').setup({
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
          'github:nvim-java/mason-registry',
        },
      })

      require('mason-tool-installer').setup({
        ensure_installed = {
          'autopep8', 'clang-format', 'clangd', 'codelldb', 'cpplint', 'csharpier', 'debugpy',
          'delve', 'eslint_d', 'gofumpt', 'golangci-lint', 'gopls', 'isort',
          'java-debug-adapter', 'java-test', 'jdtls', 'jsonlint', 'kotlin-debug-adapter',
          'kotlin-lsp', 'ktfmt', 'ktlint', 'lua-language-server', 'luacheck', 'luaformatter',
          'marksman', 'mypy', 'netcoredbg', 'prettier', 'rust-analyzer', 'tsc', 'ty',
        },
        auto_update = true,
        run_on_start = true,
        debounce_hours = 24,
      })

      require('mason-lspconfig').setup({
        automatic_enable = {
          exclude = {
            'jdtls',
          },
        },
      })

      vim.lsp.config('clangd', {
        cmd = { 'clangd', '--offset-encoding=utf-16' },
      })
      vim.diagnostic.config({ virtual_text = true, underline = true })
      vim.lsp.codelens.enable(true)
    end,
  },
  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
  },
  {
    'mfussenegger/nvim-jdtls',
    dependencies = { 'mfussenegger/nvim-dap' },
    ft = 'java',
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
}
