return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'cpp', 'lua', 'python', 'rust', 'go', 'java', 'typescript', 'javascript', 'markdown', 'json', 'yaml', 'toml', 'bash', 'cs' },
        callback = function(args)
          pcall(vim.treesitter.start, args.buf, args.match)
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local to = require('nvim-treesitter-textobjects')
      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')
      local map = require('config.keymaps').map

      to.setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      -- select
      map({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end,
        { desc = 'Around Function' })
      map({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end,
        { desc = 'Inside Function' })
      map({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end,
        { desc = 'Around Class' })
      map({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end,
        { desc = 'Inside Class' })
      map({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end,
        { desc = 'Inside Argument' })
      map({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end,
        { desc = 'Around Argument' })
      map({ 'x', 'o' }, 'iL', function() select.select_textobject('@loop.inner', 'textobjects') end,
        { desc = 'Inside Loop' })
      map({ 'x', 'o' }, 'aL', function() select.select_textobject('@loop.outer', 'textobjects') end,
        { desc = 'Around Loop' })
      map({ 'x', 'o' }, 'i?', function() select.select_textobject('@conditional.inner', 'textobjects') end,
        { desc = 'Inside Conditional' })
      map({ 'x', 'o' }, 'a?', function() select.select_textobject('@conditional.outer', 'textobjects') end,
        { desc = 'Around Conditional' })
      map({ 'n', 'x', 'o' }, ']C', function() move.goto_next_start('@class.outer', 'textobjects') end,
        { desc = 'Next Class Start' })
      map({ 'n', 'x', 'o' }, '[C', function() move.goto_previous_start('@class.outer', 'textobjects') end,
        { desc = 'Previous Class Start' })
      map({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer', 'textobjects') end,
        { desc = 'Next Function Start' })
      map({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end,
        { desc = 'Previous Function Start' })
      map({ 'n', 'x', 'o' }, ']F', function() move.goto_next_end('@function.outer', 'textobjects') end,
        { desc = 'Next Function End' })
      map({ 'n', 'x', 'o' }, '[F', function() move.goto_previous_end('@function.outer', 'textobjects') end,
        { desc = 'Previous Function End' })

      -- swap arguments
      map('n', '<leader>A>', function() require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner') end,
        { desc = 'Swap Argument Next' })
      map('n', '<leader>A<', function() require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner') end,
        { desc = 'Swap Argument Previous' })
    end,
  },
}