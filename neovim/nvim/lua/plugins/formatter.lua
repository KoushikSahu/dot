-- Add this line to automatically format and fix indentation on save
-- vim.api.nvim_command("autocmd BufWritePre * FormatDocument")
return {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
        -- vim.api.nvim_create_user_command('FormatDocument', function(details)
        --     local format = require("conform").format
        --     local start_line, end_line
        --     if details.count == -1 then
        --         start_line = 1
        --         end_line = vim.fn.line("$")
        --     else
        --         start_line = details.line1
        --         end_line = details.line2
        --     end
        --     if vim.fn.finddir(".git", ".;") ~= "" then
        --         local hunks = require("gitsigns").get_hunks()
        --         for i = #hunks, 1, -1 do
        --             local hunk = hunks[i]
        --             if hunk ~= nil and hunk.type ~= "delete" and hunk.added.start >= start_line and (hunk.added.start + hunk.added.count - 1) <= end_line then
        --                 local start = hunk.added.start
        --                 local last = start + hunk.added.count
        --                 -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
        --                 local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
        --                 local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
        --                 format({ range = range, lsp_fallback = true, async = false, timeout_ms = 1000 })
        --             end
        --         end
        --     else
        --         local range = { start = { start_line, 0 }, ["end"] = { end_line, vim.fn.strwidth(vim.fn.getline(end_line)) } }
        --         format({ range = range, lsp_fallback = true, async = false, timeout_ms = 1000 })
        --     end
        --     local pos = vim.fn.winsaveview()
        --     vim.cmd("silent! normal! gg=G")
        --     vim.fn.winrestview(pos)
        -- end, { range = true }
        -- )

        -- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        --     callback = function()
        --         require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
        --     end,
        -- })

        vim.keymap.set({ 'n', 'x' }, '<leader>f',
            '<cmd>lua require("conform").format({ lsp_format = "fallback", async = true })<cr>',
            { noremap = true, silent = true })

        require("conform").setup({
            formatters_by_ft = {
                cpp = { "clang-format" },
                javascript = { "prettier" },
                lua = { "luaformatter" },
                typescript = { "prettier" },
                python = { "isort", "autopep8" },
                rust = { "rustfmt" },
                cs = { "csharpier" },
                markdown = { "prettier" },
                json = { "prettier" },
                go = { "gofumpt" },
            },
            -- format_on_save = {
            --     timeout_ms = 400,
            --     lsp_format = "fallback",
            -- }
        })
    end,
}
