return {
    'CRAG666/code_runner.nvim',
    cmd = {
        "RunCode", "RunFile", "RunFile tab", "RunProject", "RunClose",
        "CRFiletype", "CRProjects"
    },
    config = function()
        require('code_runner').setup({
            filetypes = {
                rust = {
                    "cd $dir",
                    "rustc --edition=2021 -O --out-dir target $fileName",
                    "./target/$fileNameWithoutExt"
                }
            }
        })

        map('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
        map('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
        map('n', '<leader>rft', ':RunFile tab<CR>',
            { noremap = true, silent = false })
        map('n', '<leader>rp', ':RunProject<CR>',
            { noremap = true, silent = false })
        map('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
        map('n', '<leader>crf', ':CRFiletype<CR>',
            { noremap = true, silent = false })
        map('n', '<leader>crp', ':CRProjects<CR>',
            { noremap = true, silent = false })
    end
}
