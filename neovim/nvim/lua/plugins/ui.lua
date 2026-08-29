return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'helix',
      spec = {
        { '<leader>c', group = 'Code' },
        { '<leader>cp', group = 'Competitive Programming' },
        { '<leader>d', group = 'Debug' },
        { '<leader>g', group = 'Git' },
        { '<leader>h', group = 'Hunks' },
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Tests' },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Show Buffer Keymaps',
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    opts = {
      options = {
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = true })
          return icon, hl
        end,
        separator_style = 'slope',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match('error') and '' or ''
          return ' ' .. icon .. count
        end,
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>st', function() Snacks.picker.todo_comments() end, desc = 'Search Todo Comments' },
      { '<leader>sT', function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end, desc = 'Search Todo And Fix Comments' },
      { '<leader>td', '<cmd>TodoQuickFix<CR>', desc = 'Open Todo Quickfix' },
    },
  },
  {
    'nvzone/typr',
    dependencies = { 'nvzone/volt' },
    opts = {},
    cmd = { 'Typr', 'TyprStats' },
  },
}