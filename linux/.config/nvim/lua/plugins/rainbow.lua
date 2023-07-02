vim.g.rainbow_active = true

return {
  'luochen1990/rainbow',
  event = { 'BufReadPre', 'BufNewFile', 'BufEnter' },
}
