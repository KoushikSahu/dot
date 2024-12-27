map('n', '<leader>cpp', ':CompetiTest receive testcases<CR>')
map('n', '<leader>cpr', ':CompetiTest run<CR>')
map('n', '<leader>cpa', ':CompetiTest add_testcase<CR>')
map('n', '<leader>cpd', ':CompetiTest delete_testcase<CR>')
map('n', '<leader>cpe', ':CompetiTest edit_testcase<CR>')

return {
    'xeluxee/competitest.nvim',
    dependencies = 'MunifTanjim/nui.nvim',
    cmd = { 'CompetiTest' },
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
                }
            },
            run_command = {
                cpp = { exec = './a.out' },
                rust = { exec = './target/$(FNOEXT)' }
            },
            -- runner_ui = {
            -- interface = 'split',
            -- },
            testcases_directory = "./.nvim",
            testcases_use_single_file = true
        }
    end
}
