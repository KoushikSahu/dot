return {
    {
        'mason-org/mason.nvim',
        config = function()
            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                    "github:nvim-java/mason-registry"
                },
            })
        end,
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = {
            'mason-org/mason.nvim'
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
                    "delve",
                    "eslint_d",
                    "gofumpt",
                    "golangci-lint",
                    "gopls",
                    "isort",
                    "java-debug-adapter",
                    "java-test",
                    "jdtls",
                    "jedi-language-server",
                    "jsonlint",
                    "kotlin-debug-adapter",
                    "kotlin-lsp",
                    "ktfmt",
                    "ktlint",
                    "lua-language-server",
                    "luacheck",
                    "luaformatter",
                    "marksman",
                    "mypy",
                    "netcoredbg",
                    "prettier",
                    "rust-analyzer",
                    "rustfmt",
                    "vtsls",
                },
                auto_update = true,
                run_on_start = true,
                debounce_hours = 24,
            }
        end
    }
}
