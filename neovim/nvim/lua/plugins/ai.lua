return {
    {
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<Tab>",
                    }
                }
            })
        end,
    }, {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
        { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
        { "nvim-lua/plenary.nvim" }   -- for curl, log wrapper
    },
    opts = {
        debug = true, -- Enable debugging
        -- See Configuration section for rest
        window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1
        }
    },
    config = function()
        require("CopilotChat").setup()
        map("v", "<leader>h", ":CopilotChat<CR>")
        map("n", "<leader>h", ":CopilotChatOpen<CR>")
    end
    -- See Commands section for default commands if you want to lazy load on them
}, {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    disabled_tools = {
        "list_files",
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash"
    },
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
                    -- required for Windows users
                    use_absolute_path = true
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
            -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
            build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
            config = function()
                require("mcphub").setup({
                    use_bundled_binary = true,
                    auto_approve = true,
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
            copilot = { model = "claude-3.7-sonnet" },
            behaviour = {
                enable_cursor_planning_mdoe = true
            }
        })
    end
}
}
