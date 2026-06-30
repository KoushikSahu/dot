return {
    {
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "esmuellert/codediff.nvim",
            "folke/snacks.nvim"
        },
        cmd = "Neogit",
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>",     desc = "Show Neogit UI" },
            { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Show Neogit Log" },
        }
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = function()
            require('git-conflict').setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            local map = require('utils').map

            require('gitsigns').setup {
                signs = {
                    add = { text = '│' },
                    change = { text = '│' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked = { text = '┆' }
                },
                signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = { enable = true, follow_files = true },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 500,
                    ignore_whitespace = false
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,  -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')
                    local opts = { buffer = bufnr }

                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end, vim.tbl_extend('force', opts, { desc = 'Go To Next Hunk' }))

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end, vim.tbl_extend('force', opts, { desc = 'Go To Previous Hunk' }))

                    map('n', '<leader>hs', gitsigns.stage_hunk, vim.tbl_extend('force', opts, { desc = 'Stage Hunk' }))
                    map('n', '<leader>hr', gitsigns.reset_hunk, vim.tbl_extend('force', opts, { desc = 'Reset Hunk' }))
                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, vim.tbl_extend('force', opts, { desc = 'Stage Hunk' }))
                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, vim.tbl_extend('force', opts, { desc = 'Reset Hunk' }))
                    map('n', '<leader>hS', gitsigns.stage_buffer,
                        vim.tbl_extend('force', opts, { desc = 'Stage Buffer' }))
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk,
                        vim.tbl_extend('force', opts, { desc = 'Undo Stage Hunk' }))
                    map('n', '<leader>hR', gitsigns.reset_buffer,
                        vim.tbl_extend('force', opts, { desc = 'Reset Buffer' }))
                    map('n', '<leader>hp', gitsigns.preview_hunk,
                        vim.tbl_extend('force', opts, { desc = 'Preview Hunk' }))
                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end, vim.tbl_extend('force', opts, { desc = 'Show Line Blame' }))
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame,
                        vim.tbl_extend('force', opts, { desc = 'Toggle Line Blame' }))
                    map('n', '<leader>hd', gitsigns.diffthis,
                        vim.tbl_extend('force', opts, { desc = 'Diff Current File' }))
                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end, vim.tbl_extend('force', opts, { desc = 'Diff Against ~' }))
                    map('n', '<leader>ht', gitsigns.toggle_deleted,
                        vim.tbl_extend('force', opts, { desc = 'Toggle Deleted' }))
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',
                        vim.tbl_extend('force', opts, { desc = 'Select Hunk' }))
                end,
            }
        end,
        event = { "BufReadPre", "BufNewFile", "BufEnter" }
    }
}
