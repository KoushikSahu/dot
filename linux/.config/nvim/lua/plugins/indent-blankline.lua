vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

return {
  'lukas-reineke/indent-blankline.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("ibl").setup {
      scope = {
        enabled = true,
        show_exact_scope = true,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
      },
    }
  end
}
