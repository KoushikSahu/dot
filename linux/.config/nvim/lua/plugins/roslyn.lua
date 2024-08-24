return {
  'seblj/roslyn.nvim',
  config = function()
    require("roslyn").setup({
      exe = {
        "dotnet",
        vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
      },
      -- NOTE: Set `filewatching` to false if you experience performance problems.
      -- Defaults to true, since turning it off is a hack.
      -- If you notice that the server is _super_ slow, it is probably because of file watching
      -- I noticed that neovim became super unresponsive on some large codebases, and that was because
      -- it schedules the file watching on the event loop.
      -- This issue went away by disabling that capability. However, roslyn will fallback to its own
      -- file watching, which can make the server super slow to initialize.
      -- Setting this option to false will indicate to the server that neovim will do the file watching.
      -- However, in `hacks.lua` I will also just don't start off any watchers, which seems to make the server
      -- a lot faster to initialize.
      filewatching = true,
      config = {
        -- Here you can pass in any options that that you would like to pass to `vim.lsp.start`
        -- The only options that I explicitly override are, which means won't have any effect of setting here are:
        --     - `name`
        --     - `cmd`
        --     - `root_dir`
        --     - `on_init`
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = false,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_name_completion_suggestions = true,
            dotnet_provide_regex_completions = true,
          }
        },
      },
    })
  end
}
