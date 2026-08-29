return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'esmuellert/codediff.nvim',
      'folke/snacks.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
      { '<leader>gl', '<cmd>Neogit log<cr>', desc = 'Show Neogit Log' },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      attach_to_untracked = true,
      preview_config = { border = 'single' },
      on_attach = function(bufnr)
        local map = require('config.keymaps').map
        local gitsigns = require('gitsigns')

        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { buffer = bufnr, desc = 'Go To Next Hunk' })
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { buffer = bufnr, desc = 'Go To Previous Hunk' })

        map('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Stage Hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Reset Hunk' })
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { buffer = bufnr, desc = 'Stage Hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { buffer = bufnr, desc = 'Reset Hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Stage Buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Undo Stage Hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { buffer = bufnr, desc = 'Reset Buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { buffer = bufnr, desc = 'Show Line Blame' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle Line Blame' })
        map('n', '<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = 'Diff Current File' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis('~')
        end, { buffer = bufnr, desc = 'Diff Against ~' })
        map('n', '<leader>ht', gitsigns.toggle_deleted, { buffer = bufnr, desc = 'Toggle Deleted' })
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr, desc = 'Select Hunk' })
      end,
    },
  },
  {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
    keys = {
      { '<leader>cd', '<cmd>CodeDiff<CR>', desc = 'Toggle Code Diff' },
    },
  },
}