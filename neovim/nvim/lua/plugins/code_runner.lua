return {
    'CRAG666/code_runner.nvim',
    cmd = { 'RunCode', 'RunFile', 'RunProject', 'RunClose', 'CRFiletype', 'CRProjects' },
    keys = {
        { '<leader>r',   '<cmd>RunCode<CR>',     desc = 'Run Code',               silent = false },
        { '<leader>rf',  '<cmd>RunFile<CR>',     desc = 'Run File',               silent = false },
        { '<leader>rft', '<cmd>RunFile tab<CR>', desc = 'Run File In Tab',        silent = false },
        { '<leader>rp',  '<cmd>RunProject<CR>',  desc = 'Run Project',            silent = false },
        { '<leader>rc',  '<cmd>RunClose<CR>',    desc = 'Close Runner',           silent = false },
        { '<leader>crf', '<cmd>CRFiletype<CR>',  desc = 'Select Runner Filetype', silent = false },
        { '<leader>crp', '<cmd>CRProjects<CR>',  desc = 'Select Runner Project',  silent = false },
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
    end
}
