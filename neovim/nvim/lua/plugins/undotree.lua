vim.cmd.packadd("nvim.undotree")

local map = require("utils").map
map("n", "<leader>u", "<cmd>Undotree<CR>", { desc = "Toggle Undotree" })

return {}
