return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
        dependencies = {
            'saghen/blink.cmp',
            'mason-org/mason-lspconfig.nvim',
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
                    local bufnr = event.buf
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
                    end

                    local opts = { buffer = bufnr }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
                        opts)
                    -- vim.keymap.set('n', 'gd',
                    --     '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    -- vim.keymap.set('n', 'gD',
                    --     '<cmd>lua vim.lsp.buf.declaration()<cr>',
                    --     opts)
                    -- vim.keymap.set('n', 'gi',
                    --     '<cmd>lua vim.lsp.buf.implementation()<cr>',
                    --     opts)
                    -- vim.keymap.set('n', 'go',
                    --     '<cmd>lua vim.lsp.buf.type_definition()<cr>',
                    --     opts)
                    -- vim.keymap.set('n', 'gr',
                    --     '<cmd>lua vim.lsp.buf.references()<cr>', opts)
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
                    end,
                    basedpyright = function()
                        require("lspconfig").basedpyright.setup({
                            settings = {
                                basedpyright = {
                                    analysis = {
                                        autoImportCompletions = true,
                                        diagnosticMode = "workspace"
                                    }
                                }
                            }
                        })
                    end
                }
            })
        end
    },
    {
        'saghen/blink.cmp',
        event = "LspAttach",
        dependencies = { 'rafamadriz/friendly-snippets',
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp",
                config = function()
                    require('luasnip.loaders.from_snipmate').lazy_load()
                end
            },
            -- TODO: use suggestion from https://github.com/Saghen/blink.cmp/issues/836 after it is closed
            'fang2hou/blink-copilot',
            'saghen/blink.compat'
        },
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
                preset = 'luasnip'
            },

            sources = {
                default = {
                    'snippets',
                    'lsp',
                    'path',
                    'buffer',
                    'copilot',
                    'avante_commands',
                    'avante_mentions',
                    'avante_files'
                },

                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                        opts = {
                            {
                                max_completions = 3,
                                max_attempts = 4,
                                kind_name = "Copilot", ---@type string | false
                                kind_icon = " ", ---@type string | false
                                kind_hl = false, ---@type string | false
                                debounce = 200, ---@type integer | false
                                auto_refresh = {
                                    backward = true,
                                    forward = true,
                                },
                            }
                        },
                    },
                    avante_commands = {
                        name = "avante_commands",
                        module = "blink.compat.source",
                        score_offset = 90,
                        opts = {},
                    },
                    avante_files = {
                        name = "avante_files",
                        module = "blink.compat.source",
                        score_offset = 100,
                        opts = {},
                    },
                    avante_mentions = {
                        name = "avante_mentions",
                        module = "blink.compat.source",
                        score_offset = 1000,
                        opts = {},
                    }
                }
            },

            completion = {
                keyword = { range = 'full' },

                accept = { auto_brackets = { enabled = false }, },

                list = { selection = { preselect = false, auto_insert = true } },

                documentation = { auto_show = true, auto_show_delay_ms = 100 },

                ghost_text = { enabled = true },

                menu = {
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind" }
                        }
                    }
                },

                trigger = {
                    show_on_blocked_trigger_characters = {}
                }
            },

            signature = { enabled = true },

        },
        opts_extend = { "sources.default" }
    },
    {
        'VidocqH/lsp-lens.nvim',
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
        config = function() require 'lsp-lens'.setup({}) end
    },
    {
        'seblj/roslyn.nvim',
        ft = { 'cs' },
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
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' }
    },
}
