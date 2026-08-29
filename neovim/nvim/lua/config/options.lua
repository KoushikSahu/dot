vim.loader.enable()

local set = vim.opt

set.clipboard = "unnamedplus"
set.mouse = "a"
set.ignorecase = true
set.smartcase = true
set.swapfile = false

set.number = true
set.relativenumber = true
set.cursorline = true
set.termguicolors = true
set.showmode = false
set.colorcolumn = "80"
set.winborder = "rounded"
set.background = "dark"

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = -1

set.hlsearch = false
set.undofile = true
set.undodir = vim.fn.stdpath("state") .. "/undo"

set.diffopt:append("inline:word")

if vim.uv.os_uname().sysname:find("Windows") then
  vim.opt.shellslash = false
end