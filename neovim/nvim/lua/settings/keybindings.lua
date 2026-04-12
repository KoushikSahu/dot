local map = require("utils").map

-- leader key
vim.g.mapleader = ' '

-- focus split mappings
map("n", "<C-J>", "<C-W><C-J>", { desc = "Focus Split Down" })
map("n", "<C-K>", "<C-W><C-K>", { desc = "Focus Split Up" })
map("n", "<C-L>", "<C-W><C-L>", { desc = "Focus Split Right" })
map("n", "<C-H>", "<C-W><C-H>", { desc = "Focus Split Left" })

-- shift line mappings
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move Line Down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

-- using ctrl backspace to delete previous words
map("i", "<C-H>", "<C-W>", { desc = "Delete Previous Word" })
