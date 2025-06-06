return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
        config = function()
            -- Default configuration
            require("tiny-inline-diagnostic").setup({
                signs = {
                    left = "",
                    right = "",
                    diag = "●",
                    arrow = "    ",
                    up_arrow = "    ",
                    vertical = " │",
                    vertical_end = " └",
                },
                hi = {
                    error = "DiagnosticError",
                    warn = "DiagnosticWarn",
                    info = "DiagnosticInfo",
                    hint = "DiagnosticHint",
                    arrow = "NonText",
                    background = "CursorLine",
                    mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
                },
                blend = {
                    factor = 0.27,
                },
                options = {
                    -- Show the source of the diagnostic.
                    show_source = true,

                    -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
                    -- You can increase it if you have performance issues.
                    -- Or set it to 0 to have better visuals.
                    throttle = 20,

                    -- The minimum length of the message, otherwise it will be on a new line.
                    softwrap = 15,

                    -- If multiple diagnostics are under the cursor, display all of them.
                    multiple_diag_under_cursor = true,

                    -- Enable diagnostic message on all lines.
                    -- /!\ Still an experimental feature, can be slow on big files.
                    multilines = true,

                    overflow = {
                        -- Manage the overflow of the message.
                        --    - wrap: when the message is too long, it is then displayed on multiple lines.
                        --    - none: the message will not be truncated.
                        --    - oneline: message will be displayed entirely on one line.
                        mode = "wrap",
                    },

                    --- Enable it if you want to always have message with `after` characters length.
                    break_line = {
                        enabled = false,
                        after = 30,
                    },

                    virt_texts = {
                        priority = 2048,
                    },
                },
            })
        end
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
    }
}
