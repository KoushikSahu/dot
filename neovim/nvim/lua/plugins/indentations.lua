return {
	{
		'lukas-reineke/indent-blankline.nvim',
		event = { "BufReadPre", "BufNewFile", "BufEnter" },
		config = function()
			local highlight = {
				"RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange",
				"RainbowGreen", "RainbowViolet", "RainbowCyan"
			}
			local hooks = require "ibl.hooks"
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)
			vim.g.rainbow_delimiters = { highlight = highlight }

			hooks.register(hooks.type.SCOPE_HIGHLIGHT,
				hooks.builtin.scope_highlight_from_extmark)
			require("ibl").setup { scope = { highlight = highlight } }
		end,
	},
	{
		'nmac427/guess-indent.nvim',
		config = function()
			local guess_indent = require('guess-indent')
			guess_indent.setup {}

			local group = vim.api.nvim_create_augroup("GuessIndentOnSave", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = group,
				pattern = "*",
				callback = function(args)
					guess_indent.set_from_buffer(args.buf, true, true)
				end,
			})
		end,
	}
}
