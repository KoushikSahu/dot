local set = vim.opt

-- fast loadup
vim.loader.enable()

-- core editor options
set.clipboard = "unnamedplus"
set.mouse = "a"
set.hidden = true
set.backspace = "indent,eol,start"
set.wrap = true

-- appearance
set.number = true
set.relativenumber = true
set.cursorline = true
set.ruler = true
set.termguicolors = true
set.showmode = false
set.colorcolumn = "80"

-- indentations
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4

-- highlights
set.hlsearch = false
set.incsearch = true
