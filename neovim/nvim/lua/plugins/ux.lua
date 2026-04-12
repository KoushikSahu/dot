return {
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = "LspAttach",
        config = function() require "fidget".setup {} end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            spec = {
                { "<leader>c",  group = "Code" },
                { "<leader>cp", group = "Competitive Programming" },
                { "<leader>d",  group = "Debug" },
                { "<leader>g",  group = "Git" },
                { "<leader>h",  group = "Hunks" },
                { "<leader>s",  group = "Search" },
                { "<leader>t",  group = "Tests" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Show Buffer Keymaps",
            },
        },
    }
}
