return {
  'norcalli/nvim-colorizer.lua',
  event = { "BufReadPre", "BufNewFile", "BufEnter" },
  config = function() require 'colorizer'.setup() end
}
