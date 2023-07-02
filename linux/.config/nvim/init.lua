-- required to be loaded before plugin configurations
require('settings')
require('settings.plugins')
require('settings.keybindings')

require('lazy').setup('plugins')

-- required to be loaded after plugin configurations
require('settings.colorscheme')
require('settings.suppress')

