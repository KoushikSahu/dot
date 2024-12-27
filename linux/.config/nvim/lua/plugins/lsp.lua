return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'saghen/blink.cmp',
            'williamboman/mason-lspconfig.nvim', {
                'nvim-java/nvim-java',
                ft = 'java',
                config = function() require('java').setup() end
            }
        },
        config = function()
            vim.opt.signcolumn = 'yes'

            local lspconfig_defaults = require('lspconfig').util.default_config
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('blink.cmp').get_lsp_capabilities(
                capabilities)
            lspconfig_defaults.capabilities = capabilities

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
                        opts)
                    vim.keymap.set('n', 'gd',
                        '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD',
                        '<cmd>lua vim.lsp.buf.declaration()<cr>',
                        opts)
                    vim.keymap.set('n', 'gi',
                        '<cmd>lua vim.lsp.buf.implementation()<cr>',
                        opts)
                    vim.keymap.set('n', 'go',
                        '<cmd>lua vim.lsp.buf.type_definition()<cr>',
                        opts)
                    vim.keymap.set('n', 'gr',
                        '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs',
                        '<cmd>lua vim.lsp.buf.signature_help()<cr>',
                        opts)
                    vim.keymap.set('n', '<leader>rn',
                        '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<leader>f',
                        '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                        opts)
                    vim.keymap.set('n', '<leader>ca',
                        '<cmd>lua vim.lsp.buf.code_action()<cr>',
                        opts)
                end
            })

            vim.diagnostic.config({ virtual_text = false, underline = true })

            require('mason-lspconfig').setup({
                -- Replace the language servers listed here
                -- with the ones you want to install
                -- ensure_installed = { 'lua_ls', 'rust_analyzer' },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    clangd = function()
                        require("lspconfig").clangd.setup {
                            capabilities = capabilities,
                            cmd = { "clangd", "--offset-encoding=utf-16" }
                        }
                    end,
                    jdtls = function()
                        require("lspconfig").jdtls.setup({})
                    end
                }
            })
        end
    }, {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip' },
        version = '*',
        opts = {
            enabled = function()
                return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.bo.filetype ~= "DressingInput"
            end,

            keymap = { preset = 'default', ['<CR>'] = { 'accept', 'fallback' } },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'normal'
            },

            snippets = {
                expand = function(snippet)
                    require('luasnip').lsp_expand(snippet)
                end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                end,
                jump = function(direction)
                    require('luasnip').jump(direction)
                end
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'luasnip' }
            },

            completion = {
                keyword = { range = 'full' },

                accept = { auto_brackets = { enabled = false }, },

                list = { selection = 'auto_insert' },

                documentation = { auto_show = true, auto_show_delay_ms = 100 },

                ghost_text = { enabled = true },

                menu = {
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind" }
                        }
                    }
                }
            },

            signature = { enabled = true }
        },
        opts_extend = { "sources.default" }
    }, {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function()
            require('luasnip.loaders.from_snipmate').lazy_load()
        end
    }, {
        'VidocqH/lsp-lens.nvim',
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
        config = function() require 'lsp-lens'.setup({}) end
    }, {
        'seblj/roslyn.nvim',
        config = function()
            require("roslyn").setup({
                ft = "cs",
                config = {
                    settings = {
                        ["csharp|inlay_hints"] = {
                            csharp_enable_inlay_hints_for_implicit_object_creation = true,
                            csharp_enable_inlay_hints_for_implicit_variable_types = true,
                            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                            csharp_enable_inlay_hints_for_types = true,
                            dotnet_enable_inlay_hints_for_indexer_parameters = true,
                            dotnet_enable_inlay_hints_for_literal_parameters = true,
                            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                            dotnet_enable_inlay_hints_for_other_parameters = true,
                            dotnet_enable_inlay_hints_for_parameters = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false
                        },
                        ["csharp|code_lens"] = {
                            dotnet_enable_tests_code_lens = true
                        },
                        ["csharp|completion"] = {
                            dotnet_show_name_completion_suggestions = true,
                            dotnet_provide_regex_completions = true
                        }
                    }
                }
            })
        end
    }
}
