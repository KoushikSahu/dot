return {
  'echasnovski/mini.files',
  version = '*',
  config = function()
    require('mini.files').setup()

    vim.keymap.set('n', '<C-N>', function()
      local MiniFiles = require("mini.files")
      local _ = MiniFiles.close() or
          MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
      vim.defer_fn(function() MiniFiles.reveal_cwd() end, 30)
    end, { noremap = true, silent = true })
  end,
  opts = { windows = { preview = true, width_focus = 30, width_preview = 30 } }
}
