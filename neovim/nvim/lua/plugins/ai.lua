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
        "sudo-tee/opencode.nvim",
        config = function()
            require("opencode").setup({
                context = {
                    diagnostics = {
                        enabled = false,
                    },
                },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MeanderingProgrammer/render-markdown.nvim",
            'saghen/blink.cmp',
            'folke/snacks.nvim',
        },
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
