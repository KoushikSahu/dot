vim.g.mapleader = ' '

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true }, opts or {}))
end

map('n', '<C-J>', '<C-W><C-J>', { desc = 'Focus Split Down' })
map('n', '<C-K>', '<C-W><C-K>', { desc = 'Focus Split Up' })
map('n', '<C-L>', '<C-W><C-L>', { desc = 'Focus Split Right' })
map('n', '<C-H>', '<C-W><C-H>', { desc = 'Focus Split Left' })

map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move Line Down' })
map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move Line Up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move Selection Down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move Selection Up' })

map('i', '<C-H>', '<C-W>', { desc = 'Delete Previous Word' })

map('n', '<leader>u', '<cmd>Undotree<CR>', { desc = 'Toggle Undotree' })

local diagnostics_open = false
map('n', '<leader>tt', function()
  diagnostics_open = not diagnostics_open
  if diagnostics_open then
    vim.diagnostic.setloclist({ open = true })
  else
    vim.cmd.lclose()
  end
end, { desc = 'Toggle Diagnostics List' })

map('n', '<leader>o', 'gO', { desc = 'Show Document Symbols' })

return { map = map }