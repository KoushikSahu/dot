return {
    {
        'tpope/vim-fugitive',
        config = function()
            -- Set up keybindings for diffget and diffput with auto-save
            local function setup_diff_keybindings()
                -- Function to save all visible buffers
                local function save_all_visible()
                    local windows = vim.api.nvim_list_wins()
                    local saved_buffers = {}

                    for _, win in ipairs(windows) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if not saved_buffers[buf] and vim.api.nvim_buf_get_option(buf, 'modified') then
                            vim.api.nvim_buf_call(buf, function()
                                vim.cmd('silent! write')
                            end)
                            saved_buffers[buf] = true
                        end
                    end
                end

                -- diffput (dp) - put diff from current buffer to other buffer
                vim.keymap.set('n', 'dp', function()
                    vim.cmd('diffput')
                    save_all_visible()
                    vim.cmd('call fugitive#ReloadStatus()')
                end, { desc = 'Diff put and save all visible buffers' })

                -- diffget (do) - get diff from other buffer to current buffer
                vim.keymap.set('n', 'do', function()
                    vim.cmd('diffget')
                    save_all_visible()
                    vim.cmd('call fugitive#ReloadStatus()')
                end, { desc = 'Diff get and save all visible buffers' })

                -- Visual mode versions for ranges
                vim.keymap.set('v', 'dp', function()
                    vim.cmd("'<,'>diffput")
                    save_all_visible()
                    vim.cmd('call fugitive#ReloadStatus()')
                end, { desc = 'Diff put range and save all visible buffers' })

                vim.keymap.set('v', 'do', function()
                    vim.cmd("'<,'>diffget")
                    save_all_visible()
                    vim.cmd('call fugitive#ReloadStatus()')
                end, { desc = 'Diff get range and save all visible buffers' })
            end

            -- Set up keybindings when fugitive is loaded
            vim.api.nvim_create_autocmd('User', {
                pattern = 'FugitiveChanged',
                callback = setup_diff_keybindings,
                once = false
            })

            -- Also set up immediately in case we're already in a diff
            setup_diff_keybindings()
        end
    },
    {
        'akinsho/git-conflict.nvim',
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
        cond = function() return vim.fn.finddir(".git", ".;") ~= "" end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
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

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk)
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
                    end)
                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
                    end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hb',
                        function()
                            gitsigns.blame_line { full = true }
                        end)
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end)
                    map('n', '<leader>td', gitsigns.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

                    vim.api.nvim_exec([[
                    autocmd User GitSignsChanged call fugitive#ReloadStatus()
                    ]], false)
                end
            }
        end,
        event = { "BufReadPre", "BufNewFile", "BufEnter" }
    }
}
