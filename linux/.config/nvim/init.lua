-- required to be loaded before plugin configurations
require('settings')
require('settings.plugins')
require('settings.keybindings')

require('lazy').setup('plugins')
require('mason').setup()

-- required to be loaded after plugin configurations
require('settings.colorscheme')
require('settings.lsp')
require('settings.suppress')

