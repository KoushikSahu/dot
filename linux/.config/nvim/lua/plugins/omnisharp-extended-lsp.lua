return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  config = function ()
    local pid = vim.fn.getpid()
    -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
    local omnisharp_bin = "C:\\Users\\koushiksahu\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.exe"
    -- on Windows
    -- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"

    local config = {
      handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
      },
      cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) },
      -- rest of your settings
    }

    require'lspconfig'.omnisharp.setup(config)
  end
}
