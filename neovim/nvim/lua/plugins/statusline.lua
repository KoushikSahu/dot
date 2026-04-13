local ignored_tools = {
	copilot = true,
}

local function sanitize_name(name)
	if type(name) ~= "string" or name == "" then
		return nil
	end

	local lowered = name:lower()
	if ignored_tools[lowered] then
		return nil
	end

	return name
end

local function collect_unique(items)
	local names = {}
	local seen = {}

	for _, item in ipairs(items) do
		local name = sanitize_name(item)
		if name and not seen[name] then
			seen[name] = true
			names[#names + 1] = name
		end
	end

	table.sort(names)
	return names
end

local function format_names(icon, names)
	if #names == 0 then
		return nil
	end

	return string.format("%s  %s", icon, table.concat(names, ", "))
end

local function has_names(getter)
	return function()
		return #getter() > 0
	end
end

local function get_lsp_names()
	local names = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		names[#names + 1] = client.name
	end
	return collect_unique(names)
end

local function get_linter_names()
	local ok, lint = pcall(require, "lint")
	if not ok then
		return {}
	end

	local linters = lint.linters_by_ft[vim.bo.filetype]
	if not linters then
		return {}
	end

	if type(linters) == "string" then
		return collect_unique({ linters })
	end

	return collect_unique(linters)
end

local function get_formatter_names()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return {}
	end

	local names = {}
	for _, formatter in ipairs(conform.list_formatters_for_buffer(0)) do
		if type(formatter) == "table" then
			names[#names + 1] = formatter.name
		else
			names[#names + 1] = formatter
		end
	end

	return collect_unique(names)
end

local function lsp_component()
	return format_names("", get_lsp_names())
end

local function formatter_component()
	return format_names("", get_formatter_names())
end

local function linter_component()
	return format_names("", get_linter_names())
end

return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	event = { "VimEnter", "BufReadPost", "BufNewFile" },
	config = function()
		local lsp_status = {
			lsp_component,
			cond = has_names(get_lsp_names),
			color = {
				fg = "#61AFEF",
				gui = "bold"
			}
		}

		local formatter_status = {
			formatter_component,
			cond = has_names(get_formatter_names),
			color = {
				fg = "#98C379",
			}
		}

		local linter_status = {
			linter_component,
			cond = has_names(get_linter_names),
			color = {
				fg = "#E5C07B",
			}
		}

		require('lualine').setup {
			options = {
				theme = 'auto',
				globalstatus = true,
			},
			-- +-------------------------------------------------+
			-- | A | B | C                             X | Y | Z |
			-- +-------------------------------------------------+
			sections = {
				lualine_b = { "branch", "diff" },
				lualine_x = {
					"diagnostics",
					lsp_status,
					formatter_status,
					linter_status,
					"encoding",
					"filetype"
				},
			}
		}
	end
}
