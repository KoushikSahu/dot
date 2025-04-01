return {
    {
        'mfussenegger/nvim-dap',
        dependencies = { 'nvim-neotest/nvim-nio', 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text' },
        config = function()
            local dap = require('dap')
            local ui = require('dapui')
            local mason_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages")

            require('dapui').setup()
            require('nvim-dap-virtual-text').setup()

            -- python
            local debugpy_path = vim.fs.joinpath(mason_dir, "debugpy", "debugpy-adapter")
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
                        and ((vim.fn.has('win32') == 1 and venv_path .. '/Scripts/python') or venv_path .. '/bin/python')
                        or nil,
                    console = 'integratedTerminal',
                },
            }

            -- cpp
            local codelldb_path = vim.fs.joinpath(mason_dir, "codelldb", "extension", "adapter", "codelldb")
            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = codelldb_path,
                    args = { '--port', '${port}' }
                }

            }
            dap.configurations.cpp = {
                {
                    name = 'LLDB: Launch',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
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
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                    console = 'integratedTerminal',
                },
            }

            -- c#
            local netcoredbg_path = "C:\\Users\\koushiksahu\\Downloads\\netcoredbg-win64\\netcoredbg\\netcoredbg.exe"
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
                    cwd = "${workspaceFolder}/src/Service",
                },
            }

            -- go
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

            -- keybindings
            vim.keymap.set("n", "<leader>dc", dap.continue, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>de", dap.terminate, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>dj", dap.step_over, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>dl", dap.step_into, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>dk", dap.step_out, { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>dh", dap.run_to_cursor, { noremap = true, silent = true })
            vim.keymap.set("n", "<space>?", function()
                ui.eval(nil, { enter = true })
            end)

            -- open dap ui automatically
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
        end
    },
}
