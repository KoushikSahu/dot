local set = vim.opt
local utils = require("utils")

-- fast loadup
vim.loader.enable()

-- core editor options
set.clipboard = "unnamedplus"
set.mouse = "a"
set.hidden = true
set.backspace = "indent,eol,start"
set.wrap = true
set.ignorecase = true
set.swapfile = false
set.autoread = true
set.smartcase = true

-- appearance
set.number = true
set.relativenumber = true
set.cursorline = true
set.ruler = true
set.termguicolors = true
set.showmode = false
set.colorcolumn = "80"
set.winborder = "rounded"
set.background = "dark"

-- indentations
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = -1
set.autoindent = true

-- highlights
set.hlsearch = false
set.incsearch = true

-- shellslash is only modifiable on Windows.
if utils.is_windows then
	vim.opt.shellslash = false
end
