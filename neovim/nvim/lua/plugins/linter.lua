return {
    'mfussenegger/nvim-lint',
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
        require('lint').linters_by_ft = {
            cpp = { 'cpplint' },
            lua = { 'luacheck' },
            python = { 'mypy' },
            json = { 'jsonlint' },
            typescript = { 'eslint_d' },
            javascript = { 'eslint_d' },
            go = { 'golangcilint' },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufReadPre" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })

        -- golang
        local goci = require("lint.linters.golangcilint")
        goci.args = {
            "run",
            "--output.json.path=stdout",
            "--show-stats=false",
            "--issues-exit-code",
            "0",
        }
    end
}
