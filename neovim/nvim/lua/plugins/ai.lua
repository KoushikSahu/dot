return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = {
        enabled = false,
      },
    },
  },
  {
    'folke/sidekick.nvim',
    event = 'InsertEnter',
    cmd = 'Sidekick',
    opts = {
      nes = { enabled = true },
    },
    keys = {
      {
        '<tab>',
        function()
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>'
          end
        end,
        expr = true,
        desc = 'Go To Or Apply Next Edit Suggestion',
      },
    },
  },
}