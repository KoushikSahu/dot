map('n', '<leader>tr', 'lua require("neotest").run.run()<CR>')
map('n', '<leader>tf', 'lua require("neotest").run.run(vim.fn.expand("%"))<CR>')
map('n', '<leader>td', 'lua require("neotest").run.run({strategy = "dap"})<CR>')
map('n', '<leader>ts', 'lua require("neotest").run.stop()<CR>')
map('n', '<leader>ta', 'lua require("neotest").run.attach()')

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-dotnet')({
            dap = {
              -- Extra arguments for nvim-dap configuration
              -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
              args = { justMyCode = false },
              -- Enter the name of your dap adapter, the default value is netcoredbg
              adapter_name = "netcoredbg"
            },
          }),
          -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
          dotnet_additional_args = {
            "--verbosity detailed"
          },
          -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
          -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
          --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
          discovery_root = "solution" -- Default
        }
      })
    end
  },
}
