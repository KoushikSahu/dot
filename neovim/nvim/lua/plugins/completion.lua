return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '*',
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
        config = function()
          require('luasnip.loaders.from_snipmate').lazy_load()
        end,
      },
    },
    opts = {
      enabled = function()
        return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false and vim.bo.filetype ~= 'DressingInput'
      end,
      keymap = { preset = 'default', ['<CR>'] = { 'accept', 'fallback' } },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'normal',
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
      },
      completion = {
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = false } },
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = { auto_show = true, auto_show_delay_ms = 100 },
        ghost_text = { enabled = true },
        menu = {
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind' },
            },
          },
        },
        trigger = { show_on_blocked_trigger_characters = {} },
      },
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
}