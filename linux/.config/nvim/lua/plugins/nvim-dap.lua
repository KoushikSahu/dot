map("n", "<leader>dt", "<Cmd>lua require('dapui').toggle()<CR>")
map("n", "<leader>de", ":DapTerminate<CR>")
map("n", "<leader>db", ":DapToggleBreakpoint<CR>")
map("n", "<leader>dj", ":DapStepOver<CR>")
map("n", "<leader>dl", ":DapStepInto<CR>")
map("n", "<leader>dk", ":DapStepOut<CR>")
map("n", "<leader>dc", ":DapContinue<CR>")

return {
    {'mfussenegger/nvim-dap', dependencies = {'nvim-neotest/nvim-nio'}}, {
        'rcarriga/nvim-dap-ui',
        dependencies = {{'mfussenegger/nvim-dap'}},
        config = function() require('dapui').setup() end
    }, {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {{'mfussenegger/nvim-dap'}},
        config = function() require('nvim-dap-virtual-text').setup() end
    }, {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {{'mfussenegger/nvim-dap'}},
        config = function()
            require('mason-nvim-dap').setup({handlers = {}})
        end
    }
}
