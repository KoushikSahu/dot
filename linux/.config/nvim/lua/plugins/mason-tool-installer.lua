return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  config = function()
    require('mason-tool-installer').setup {

      -- a list of all tools you want to ensure are installed upon
      -- start
      ensure_installed = {
        "autopep8",
        "clang-format",
        "clangd",
        "codelldb",
        "cpplint",
        "csharpier",
        "debugpy",
        "eslint_d",
        "isort",
        "jsonlint",
        "ltex-ls",
        "lua-language-server",
        "luacheck",
        "luaformatter",
        "mypy",
        "netcoredbg",
        "prettier",
        "pyright",
        "rust-analyzer",
        "rustfmt",
        "vtsls",
      },

      -- if set to true this will check each tool for updates. If updates
      -- are available the tool will be updated. This setting does not
      -- affect :MasonToolsUpdate or :MasonToolsInstall.
      -- Default: false
      auto_update = true,

      -- automatically install / update on startup. If set to false nothing
      -- will happen on startup. You can use :MasonToolsInstall or
      -- :MasonToolsUpdate to install tools and check for updates.
      -- Default: true
      run_on_start = true,

      -- set a delay (in ms) before the installation starts. This is only
      -- effective if run_on_start is set to true.
      -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
      -- Default: 0
      -- start_delay = 3000, -- 3 second delay

      -- Only attempt to install if 'debounce_hours' number of hours has
      -- elapsed since the last time Neovim was started. This stores a
      -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
      -- This is only relevant when you are using 'run_on_start'. It has no
      -- effect when running manually via ':MasonToolsInstall' etc....
      -- Default: nil
      debounce_hours = 24, -- at least 24 hours between attempts to install/update

      -- By default all integrations are enabled. If you turn on an integration
      -- and you have the required module(s) installed this means you can use
      -- alternative names, supplied by the modules, for the thing that you want
      -- to install. If you turn off the integration (by setting it to false) you
      -- cannot use these alternative names. It also suppresses loading of those
      -- module(s) (assuming any are installed) which is sometimes wanted when
      -- doing lazy loading.
      -- integrations = {
      --   ['mason-lspconfig'] = true,
      --   ['mason-nvim-dap'] = true,
      -- },
    }
  end
}
