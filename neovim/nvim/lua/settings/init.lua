local set = vim.opt

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
set.softtabstop = 4

-- highlights
set.hlsearch = false
set.incsearch = true

-- debugging on windows does not working without this
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    vim.opt.shellslash = false             -- Enable shellslash for Windows compatibility
    vim.defer_fn(function()
        vim.opt.shellslash = false
    end, 5000)
end
