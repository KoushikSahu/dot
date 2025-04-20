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
            preset = "helix"
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    }
}
