-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  preselect = require('cmp').PreselectMode.None,
  complete = {
    completeopt=menu,menuone,noinsert,noselect
  },
})
