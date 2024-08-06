return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  config = function()
    local pid = vim.fn.getpid()
    -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
    local omnisharp_bin =
    "C:\\Users\\koushiksahu\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.exe"
    -- on Windows
    -- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"

    local config = {
      cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
      -- rest of your settings
    }

    require 'lspconfig'.omnisharp.setup(config)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "cs" },
      callback = function()
        vim.schedule(function()
          map("n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>")
          map("n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>")
          map("n", "gr", "nnoremap gr <cmd>lua require('omnisharp_extended').lsp_references()<cr>")
        end)
      end
    })
  end
}
