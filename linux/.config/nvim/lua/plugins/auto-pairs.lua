vim.g.AutoPairsMapCh = 0

return {
  'jiangmiao/auto-pairs',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
}
