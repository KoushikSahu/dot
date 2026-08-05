return {
    'mfussenegger/nvim-lint',
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            cpp = { 'cpplint' },
            lua = { 'luacheck' },
            python = { 'mypy' },
            json = { 'jsonlint' },
            typescript = { 'eslint_d' },
            javascript = { 'eslint_d' },
            go = { 'golangcilint' },
            kotlin = { 'ktlint' }
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })

        lint.linters.golangcilint = function()
            local goci = require("lint.linters.golangcilint")
            goci.args = {
                "run",
                "--output.json.path=stdout",
                "--show-stats=false",
                "--issues-exit-code",
                "0",
            }
            return goci
        end
    end
}
