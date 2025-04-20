return {
    {
        'williamboman/mason.nvim',
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = {
            'williamboman/mason.nvim'
        },
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    "autopep8",
                    "clang-format",
                    "clangd",
                    "codelldb",
                    "cpplint",
                    "csharpier",
                    "debugpy",
                    "eslint_d",
                    "isort",
                    "jedi-language-server",
                    "jsonlint",
                    "ltex-ls",
                    "lua-language-server",
                    "luacheck",
                    "luaformatter",
                    "mypy",
                    "netcoredbg",
                    "prettier",
                    "rust-analyzer",
                    "rustfmt",
                    "vtsls",
                    "gopls",
                    "delve",
                    "gofumpt",
                    "golangci-lint",
                },
                auto_update = true,
                run_on_start = true,
                debounce_hours = 24,
            }
        end
    }
}
