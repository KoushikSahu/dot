return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'
        },
        ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
        config = function() require('render-markdown').setup({}) end,
        opts = {
            anti_conceal = { enabled = false },
            file_types = { 'markdown', 'opencode_output' },
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        build = "cd app && yarn install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }
    }
}
