return {
  {
    'rcasia/neotest-java',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-jdtls',
      { 'mfussenegger/nvim-dap', dependencies = { 'rcarriga/nvim-dap-ui' } },
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
  },
  {
    'Issafalcon/neotest-dotnet',
    ft = { 'cs', 'fs' },
  },
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'vim-test/vim-test',
        dependencies = { 'tpope/vim-dispatch' },
        config = function()
          vim.g['test#strategy'] = 'dispatch'
        end,
      },
      'nvim-neotest/neotest-vim-test',
    },
    keys = {
      { '<leader>tr', function() require('neotest').run.run() end, desc = 'Run Nearest Test' },
      { '<leader>ts', function() require('neotest').run.stop() end, desc = 'Stop Test Run' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run Current Test File' },
      { '<leader>ta', function() require('neotest').run.attach() end, desc = 'Attach To Test Run' },
      { '<leader>te', function() require('neotest').summary.toggle() end, desc = 'Toggle Test Summary' },
      { '<leader>to', function() require('neotest').output.open() end, desc = 'Open Test Output' },
      { '<leader>tdc', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Start Debugging Nearest Test' },
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-dotnet')({
            dap = {
              args = { justMyCode = false },
              adapter_name = 'netcoredbg',
            },
            dotnet_additional_args = {
              '--verbosity detailed',
            },
            discovery_root = 'project',
          }),
          require('neotest-vim-test')({ ignore_filetypes = { 'cs' } }),
        },
      })
    end,
  },
}