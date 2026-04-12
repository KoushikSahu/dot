return {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    cmd = { 'CompetiTest' },
    keys = {
        { '<leader>cpp', '<cmd>CompetiTest receive testcases<CR>', desc = 'Receive Test Cases' },
        { '<leader>cpr', '<cmd>CompetiTest run<CR>',               desc = 'Run Competitive Program' },
        { '<leader>cpa', '<cmd>CompetiTest add_testcase<CR>',      desc = 'Add Test Case' },
        { '<leader>cpd', '<cmd>CompetiTest delete_testcase<CR>',   desc = 'Delete Test Case' },
        { '<leader>cpe', '<cmd>CompetiTest edit_testcase<CR>',     desc = 'Edit Test Case' },
    },
    config = function()
        require 'competitest'.setup {
            compile_command = {
                cpp = {
                    exec = 'g++',
                    args = {
                        '-O2', '-g', '-Wall', '-Wextra', '-Wno-unused-result',
                        '-Wconversion', '-static', '-std=c++20', '$(FNAME)'
                    }
                },
                rust = {
                    exec = 'rustc',
                    args = {
                        '--edition=2021', '-C', 'debug-assertions', '-O',
                        '--out-dir', 'target', '$(FNAME)'
                    }
                },
                kotlin = {
                    exec = 'kotlinc',
                    args = {
                        '$(FNAME)', '-include-runtime', '-d', 'a.jar'
                    }
                }
            },
            run_command = {
                cpp = { exec = './a.out' },
                rust = { exec = './target/$(FNOEXT)' },
                kotlin = { exec = 'java', args = { '-jar', 'a.jar' } }
            },
            -- runner_ui = {
            -- interface = 'split',
            -- },
            testcases_directory = "./.nvim",
            testcases_use_single_file = true
        }
    end
}
