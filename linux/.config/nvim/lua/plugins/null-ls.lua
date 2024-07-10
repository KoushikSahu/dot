return {
    'jose-elias-alvarez/null-ls.nvim',
    event = {"BufReadPre", "BufNewFile", "BufEnter"},
    config = function()
        -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local is_git_repo = function()
            local handle = io.popen(
                               "git rev-parse --is-inside-work-tree 2>/dev/null")
            local result = handle:read("*a")
            handle:close()
            return result:match("^true") ~= nil
        end
        require("null-ls").setup({
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentRangeFormattingProvider and
                    is_git_repo() then
                    local lsp_format_modifications =
                        require "lsp-format-modifications"
                    lsp_format_modifications.attach(client, bufnr,
                                                    {format_on_save = true})
                else
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                                -- vim.lsp.buf.formatting_sync()
                                vim.lsp.buf.format({async = false})
                            end
                        })
                    end
                end
            end,
            sources = {}
        })
    end
}
