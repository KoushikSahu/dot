return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      { '<leader>dc', function() require('dap').continue() end, desc = 'Continue Debugging' },
      { '<leader>de', function() require('dap').terminate() end, desc = 'Stop Debugging' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dj', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<leader>dl', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<leader>dk', function() require('dap').step_out() end, desc = 'Step Out' },
      { '<leader>dh', function() require('dap').run_to_cursor() end, desc = 'Run To Cursor' },
      { '<leader>du', function() require('dapui').eval(nil, { enter = true }) end, desc = 'Evaluate Expression' },
    },
    config = function()
      local dap = require('dap')
      local ui = require('dapui')
      local utils = require('config.utils')
      local mason_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages')

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()

      local debugpy_path = vim.fs.joinpath(mason_dir, 'debugpy', 'debugpy-adapter')
      local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
      dap.adapters.debugpy = {
        type = 'executable',
        command = debugpy_path,
      }
      dap.configurations.python = {
        {
          type = 'debugpy',
          request = 'launch',
          name = 'Python: Launch file',
          program = '${file}',
          pythonPath = venv_path
              and ((utils.is_windows and venv_path .. '/Scripts/python') or venv_path .. '/bin/python')
              or nil,
          console = 'integratedTerminal',
        },
      }

      local codelldb_path = vim.fs.joinpath(mason_dir, 'codelldb', 'extension', 'adapter', 'codelldb')
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = codelldb_path,
          args = { '--port', '${port}' },
        },
      }
      local launch_program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end
      dap.configurations.cpp = {
        {
          name = 'LLDB: Launch',
          type = 'codelldb',
          request = 'launch',
          program = launch_program,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          console = 'integratedTerminal',
        },
      }
      dap.configurations.rust = {
        {
          name = 'LLDB: Launch',
          type = 'codelldb',
          request = 'launch',
          program = launch_program,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          console = 'integratedTerminal',
        },
      }

      local netcoredbg_path = vim.fs.joinpath(mason_dir, 'netcoredbg', 'netcoredbg')
      if vim.fn.executable(netcoredbg_path) == 0 then
        netcoredbg_path = 'netcoredbg'
      end
      dap.adapters.netcoredbg = {
        type = 'executable',
        command = netcoredbg_path,
        args = { '--interpreter=vscode' },
      }
      dap.configurations.cs = {
        {
          name = 'Launch .NET Core',
          type = 'netcoredbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}/src/Service',
        },
      }

      dap.configurations.go = {
        {
          type = 'delve',
          name = 'Delve: Debug',
          request = 'launch',
          program = '${workspaceFolder}',
        },
        {
          type = 'delve',
          name = 'Delve: Debug (Arguments)',
          request = 'launch',
          program = '${workspaceFolder}',
          args = function()
            return vim.split(vim.fn.input('Args: '), ' ')
          end,
        },
        {
          type = 'delve',
          name = 'Delve: Debug test',
          request = 'launch',
          mode = 'test',
          program = '${file}',
        },
        {
          type = 'delve',
          name = 'Delve: Debug test (go.mod)',
          request = 'launch',
          mode = 'test',
          program = './${relativeFileDirname}',
        },
      }

      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = 'Debug (Attach) - Remote',
          hostName = '127.0.0.1',
          port = 5005,
        },
      }

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}