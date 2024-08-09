return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim",  -- Optional, but highly recommended for debugging
  },
  config = function()
    require("mason").setup()
    require("csharp").setup {
      lsp = {
        omnisharp = {
          enable = false,
        },
        -- Sets if you want to use roslyn as your LSP
        roslyn = {
          -- When set to true, csharp.nvim will launch roslyn automatically.
          enable = true,
          -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
          cmd_path = vim.fn.stdpath('config') .. "/lsp/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll",
        },
        enable_editor_config_support = true,
        organize_imports = true,
        load_projects_on_demand = false,
        enable_analyzers_support = true,
        enable_import_completion = true,
        include_prerelease_sdks = true,
        analyze_open_documents_only = true,
        enable_package_auto_restore = true,
        debug = false,
        -- The capabilities to pass to the omnisharp server
        capabilities = nil,
        -- on_attach function that'll be called when the LSP is attached to a buffer
        on_attach = nil
      },
      logging = {
        -- The minimum log level.
        level = "INFO",
      },
      dap = {
        -- When set, csharp.nvim won't launch install and debugger automatically. Instead, it'll use the debug adapter specified.
        --- @type string?
        adapter_name = nil,
      }
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "cs" },
      callback = function()
        vim.schedule(function()
          map("n", "<leader>dp", "<cmd>lua require('csharp').debug_project()<cr>")
        end)
      end
    })
  end
}
