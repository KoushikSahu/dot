return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  config = function()
    local pid = vim.fn.getpid()
    -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
    -- local omnisharp_bin = "C:\\Users\\koushiksahu\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.exe"
    -- on Windows
    local omnisharp_bin =
    "C:\\Users\\koushiksahu\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.exe"

    local config = {
      cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
      -- rest of your settings
      settings = {
        FormattingOptions = {
          -- Enables support for reading code style, naming convention and analyzer
          -- settings from .editorconfig.
          EnableEditorConfigSupport = true,
          -- Specifies whether 'using' directives should be grouped and sorted during
          -- document formatting.
          OrganizeImports = true,
        },
        MsBuild = {
          -- If true, MSBuild project system will only load projects for files that
          -- were opened in the editor. This setting is useful for big C# codebases
          -- and allows for faster initialization of code navigation features only
          -- for projects that are relevant to code that is being edited. With this
          -- setting enabled OmniSharp may load fewer projects and may thus display
          -- incomplete reference lists for symbols.
          LoadProjectsOnDemand = false,
        },
        RoslynExtensionsOptions = {
          -- Enables support for roslyn analyzers, code fixes and rulesets.
          EnableAnalyzersSupport = true,
          -- Enables support for showing unimported types and unimported extension
          -- methods in completion lists. When committed, the appropriate using
          -- directive will be added at the top of the current file. This option can
          -- have a negative impact on initial completion responsiveness,
          -- particularly for the first few completion sessions after opening a
          -- solution.
          EnableImportCompletion = true,
          -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
          -- true
          AnalyzeOpenDocumentsOnly = true,
        },
        Sdk = {
          -- Specifies whether to include preview versions of the .NET SDK when
          -- determining which version to use for project loading.
          IncludePrereleases = false,
        },
      },
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
