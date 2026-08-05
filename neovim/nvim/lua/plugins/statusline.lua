local ignored_tools = {
	copilot = true,
}

local provider_cache = {}

local function clear_provider_cache(bufnr)
	if bufnr then
		provider_cache[bufnr] = nil
	else
		provider_cache = {}
	end
end

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

local function cached_names(provider, discover)
	local bufnr = vim.api.nvim_get_current_buf()
	local cache = provider_cache[bufnr]
	if not cache then
		cache = {}
		provider_cache[bufnr] = cache
	end

	if not cache[provider] then
		cache[provider] = discover(bufnr)
	end

	return cache[provider]
end

local function get_lsp_names()
	return cached_names("lsp", function(bufnr)
		local names = {}
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			names[#names + 1] = client.name
		end
		return collect_unique(names)
	end)
end

local function get_linter_names()
	return cached_names("linter", function(bufnr)
		local ok, lint = pcall(require, "lint")
		if not ok then
			return {}
		end

		local linters = lint.linters_by_ft[vim.bo[bufnr].filetype]
		if not linters then
			return {}
		end

		if type(linters) == "string" then
			return collect_unique({ linters })
		end

		return collect_unique(linters)
	end)
end

local function get_formatter_names()
	return cached_names("formatter", function(bufnr)
		local ok, conform = pcall(require, "conform")
		if not ok then
			return {}
		end

		local names = {}
		for _, formatter in ipairs(conform.list_formatters_for_buffer(bufnr)) do
			if type(formatter) == "table" then
				names[#names + 1] = formatter.name
			else
				names[#names + 1] = formatter
			end
		end

		return collect_unique(names)
	end)
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
		local group = vim.api.nvim_create_augroup("StatuslineProviderCache", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "FileType", "BufWritePost", "LspAttach", "LspDetach" }, {
			group = group,
			callback = function(args)
				clear_provider_cache(args.buf)
			end,
		})
		vim.api.nvim_create_autocmd("DirChanged", {
			group = group,
			callback = function()
				clear_provider_cache()
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "MasonToolsUpdateCompleted",
			callback = function()
				clear_provider_cache()
			end,
		})
		vim.api.nvim_create_autocmd("BufWipeout", {
			group = group,
			callback = function(args)
				clear_provider_cache(args.buf)
			end,
		})

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
