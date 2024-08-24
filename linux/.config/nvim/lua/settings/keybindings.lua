-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader key
vim.g.mapleader = ' '

-- focus split mappings
map("n", "<C-J>", "<C-W><C-J>", { silent = true })
map("n", "<C-K>", "<C-W><C-K>", { silent = true })
map("n", "<C-L>", "<C-W><C-L>", { silent = true })
map("n", "<C-H>", "<C-W><C-H>", { silent = true })

-- shift line mappings
map("n", "<A-j>", ":m .+1<CR>==", { silent = true })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- using ctrl backspace to delete previous words
map("i", "<C-H>", "<C-W>", { silent = true })
