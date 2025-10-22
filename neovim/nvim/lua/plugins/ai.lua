-- avante relative path hack
vim.g.root_spec = { { ".git" }, "lsp", "cwd" }

return {
    {
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true
                },
                panel = {
                    enabled = false,
                },
            })
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = true,
        version = false, -- set this if you want to always pull the latest change
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = function()
            if vim.fn.has('win32') == 1 then
                return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            else
                return "make"
            end
        end,
        dependencies = {
            "stevearc/dressing.nvim", "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",        --- The below dependencies are optional,
            -- "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",      -- for providers='copilot'
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = { insert_mode = true },
                        use_absolute_path = vim.fn.has('win32') == 1
                    }
                }
            }, {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = { file_types = { "markdown", "Avante" } },
            ft = { "markdown", "Avante" }
        },
            {
                "ravitemer/mcphub.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                },
                cmd = "MCPHub",
                build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
                -- build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
                config = function()
                    require("mcphub").setup({
                        -- use_bundled_binary = true,
                        auto_approve = true,
                        extensions = {
                            avante = {
                                make_slash_commands = true,
                            }
                        }
                    })
                end,
            }
        },
        config = function()
            require("avante").setup({
                system_prompt = function()
                    local hub = require("mcphub").get_hub_instance()
                    return hub:get_active_servers_prompt()
                end,
                custom_tools = function()
                    return {
                        require("mcphub.extensions.avante").mcp_tool(),
                    }
                end,
                provider = "copilot",
                auto_suggestion_provider = "copilot",
                providers = {
                    copilot = { model = "claude-sonnet-4.5" },
                },
                behaviour = {
                    enable_cursor_planning_mode = true,
                    enable_token_counting = false,
                },
                selector = {
                    provider = "snacks",
                    provider_opts = {}
                }
            })
        end
    },
    {
        "folke/sidekick.nvim",
        lazy = false,
        opts = {
            nes = { enabled = true },
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
        },
    }
}
