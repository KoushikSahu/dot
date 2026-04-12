local M = {}

M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
M.is_unix = not M.is_windows

function M.map(mode, lhs, rhs, opts)
	local options = vim.tbl_extend("force", {
		silent = true,
	}, opts or {})

	vim.keymap.set(mode, lhs, rhs, options)
end

return M
