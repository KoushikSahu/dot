return {
  {
    'rcasia/neotest-java',
    ft = 'java',
    dependencies = {
      'mfussenegger/nvim-jdtls',
      { 'mfussenegger/nvim-dap', dependencies = { 'rcarriga/nvim-dap-ui' } },
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
  },
  {
    'Issafalcon/neotest-dotnet',
    ft = { 'cs', 'fs' },
  },
  -- Rust: cargo-nextest aware; falls back to nothing — `cargo nextest` is
  -- required at runtime.
  {
    'rouge8/neotest-rust',
    ft = 'rust',
    dependencies = {
      'nvim-neotest/neotest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- Go: `go test` runner with table-test/nested/subtest discovery.
  {
    'fredrikaverpil/neotest-golang',
    ft = 'go',
    dependencies = {
      'nvim-neotest/neotest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- debugger.lua only sets `dap.configurations.go` (type = 'delve') but
      -- never registers a `delve` adapter. neotest-golang's manual DAP config
      -- needs it, so register one backed by mason's `delve` (PATH fallback).
      local ok, dap = pcall(require, 'dap')
      if ok and not dap.adapters.delve then
        local mason_dlv = vim.fs.joinpath(vim.fn.stdpath('data'), 'mason', 'packages', 'delve', 'dlv')
        dap.adapters.delve = {
          type = 'server',
          port = '${port}',
          executable = {
            command = vim.fn.executable(mason_dlv) == 1 and mason_dlv or 'dlv',
            args = { 'dap', '-l', '127.0.0.1:${port}' },
          },
        }
      end
    end,
  },
  -- Python: pytest via neotest-python, debugged through debugger.lua's debugpy.
  {
    'nvim-neotest/neotest-python',
    ft = 'python',
    dependencies = {
      'nvim-neotest/neotest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- neotest-python hardcodes its DAP strategy type to `python` (via
      -- vim.tbl_extend 'keep'), so alias the `debugpy` adapter registered in
      -- debugger.lua under the name nvim-dap will look up.
      local ok, dap = pcall(require, 'dap')
      if ok and dap.adapters.debugpy and not dap.adapters.python then
        dap.adapters.python = dap.adapters.debugpy
      end
    end,
  },
  -- JavaScript / TypeScript: Jest and Vitest each get a dedicated adapter.
  -- Mocha / Playwright intentionally fall through to `neotest-vim-test`.
  {
    'nvim-neotest/neotest-jest',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'marilari88/neotest-vitest',
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  -- C++: CTest-backed CMake projects + standalone GoogleTest binaries.
  {
    'alfaix/neotest-gtest',
    ft = 'cpp',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'orjangj/neotest-ctest',
    ft = 'cpp',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-neotest/neotest',
    event = 'VeryLazy',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      {
        'vim-test/vim-test',
        config = function()
          vim.g['test#strategy'] = 'neovim'
        end,
      },
      'nvim-neotest/neotest-vim-test',
    },
    keys = {
      { '<leader>tr', function() require('neotest').run.run() end, desc = 'Run Nearest Test' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run Current Test File' },
      { '<leader>tD', function() require('neotest').run.run(vim.fn.expand('%:p:h')) end, desc = 'Run Test Directory' },
      { '<leader>tA', function() require('neotest').run.run(vim.fn.getcwd()) end, desc = 'Run All Tests' },
      { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Run Last Test' },
      { '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand('%')) end, desc = 'Toggle Test Watch' },
      { '<leader>ts', function() require('neotest').run.stop() end, desc = 'Stop Test Run' },
      { '<leader>to', function() require('neotest').output.open() end, desc = 'Open Test Output' },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle Test Output Panel' },
      { '<leader>te', function() require('neotest').summary.toggle() end, desc = 'Toggle Test Summary' },
      { ']t', function() require('neotest').jump.next({ status = 'failed' }) end, desc = 'Next Failed Test' },
      { '[t', function() require('neotest').jump.prev({ status = 'failed' }) end, desc = 'Previous Failed Test' },
      { '<leader>tq', function() require('neotest').quickfix() end, desc = 'Open Test Quickfix' },
      { '<leader>td', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Debug Nearest Test' },
      { '<leader>tdc', function() require('neotest').run.run({ strategy = 'dap' }) end, desc = 'Start Debugging Nearest Test' },
      { '<leader>ta', function() require('neotest').run.attach() end, desc = 'Attach To Test Run' },
    },
    config = function()
      -- Directories that never contain discoverable tests. Skipping them keeps
      -- `concurrent` file parsing cheap and avoids picking up vendored copies.
      local ignored_dirs = {
        ['.git'] = true,
        ['node_modules'] = true,
        ['target'] = true,
        ['build'] = true,
        ['dist'] = true,
        ['out'] = true,
        ['bin'] = true,
        ['obj'] = true,
        ['vendor'] = true,
        ['venv'] = true,
        ['.venv'] = true,
        ['__pycache__'] = true,
        ['.mypy_cache'] = true,
        ['.pytest_cache'] = true,
        ['.tox'] = true,
        ['coverage'] = true,
        ['.next'] = true,
        ['.cache'] = true,
      }
      local ignored_prefixes = { 'cmake-build', 'build-' }

      require('neotest').setup({
        adapters = {
          -- JavaScript / TypeScript -------------------------------------------------
          -- Jest: `npm test` is the common entrypoint; run from the package that
          -- owns the test file so per-package configs/scripts resolve in monorepos.
          require('neotest-jest')({
            jestCommand = 'npm test --',
            -- Keep off: neotest's own discovery is enabled, and jest_test_discovery
            -- spawns a jest process per file. Parameterized (`it.each`) tests are
            -- still runnable by position; only their child nodes are not listed.
            jest_test_discovery = false,
            cwd = function(file)
              local dir = file and vim.fn.fnamemodify(file, ':h') or vim.fn.expand('%:p:h')
              return vim.fs.root(dir, {
                'package.json',
                'jest.config.js',
                'jest.config.ts',
                'jest.config.mjs',
                'jest.config.cjs',
              }) or vim.fn.getcwd()
            end,
          }),
          -- Vitest: `{}` required — the adapter indexes `opts` unconditionally,
          -- so a bare `()` call errors. Defaults auto-detect vitest + config.
          require('neotest-vitest')({}),

          -- C++ ---------------------------------------------------------------------
          -- CTest projects (`cmake -B build` emits build/CTestTestfile.cmake): the
          -- adapter locates the test directory itself (depth <= 3), so no build
          -- dir/command config is required per project.
          require('neotest-ctest').setup({
            dap_adapter = 'codelldb',
            frameworks = { 'gtest', 'catch2', 'doctest' },
            is_test_file = function(file)
              local name = vim.fs.basename(file)
              if not name:match('%.(cpp|cc|cxx|cppm|c%+%+)$') then
                return false
              end
              local stem = name:gsub('%.[^.]+$', '')
              return vim.startswith(stem, 'test_') or vim.endswith(stem, '_test')
            end,
          }),
          -- Standalone GoogleTest binaries (no CTest registration). Executables are
          -- assigned once per project via :ConfigureGtest and persisted on disk.
          require('neotest-gtest').setup({
            debug_adapter = 'codelldb',
            is_test_file = function(file)
              local name = vim.fs.basename(file)
              if not name:match('%.(cpp|cppm|cc|cxx|c%+%+)$') then
                return false
              end
              local stem = name:gsub('%.[^.]+$', '')
              if not (vim.startswith(stem, 'test_') or vim.endswith(stem, '_test')) then
                return false
              end
              -- CTest-registered projects are owned by neotest-ctest; skip them
              -- here so the same test is not discovered by both adapters.
              local dir = vim.fn.fnamemodify(file, ':h')
              local root = vim.fs.root(dir, { 'CMakePresets.json', 'compile_commands.json', 'build', 'out', '.git' })
              if root then
                for _, sub in ipairs({ '/build', '/out' }) do
                  if vim.uv.fs_stat(root .. sub .. '/CTestTestfile.cmake') then
                    return false
                  end
                end
              end
              return true
            end,
          }),

          -- Java (JUnit via jdtls) --------------------------------------------------
          require('neotest-java')({
            incremental_build = true,
            jvm_args = { '-Xmx512m' },
          }),
          -- C# (.NET via netcoredbg) -------------------------------------------------
          require('neotest-dotnet')({
            dap = {
              args = { justMyCode = false },
              adapter_name = 'netcoredbg',
            },
            dotnet_additional_args = {
              '--verbosity detailed',
            },
            discovery_root = 'project',
          }),
          -- Rust -------------------------------------------------------------------
          -- cargo-nextest based; `args` are extra `cargo nextest run` flags.
          require('neotest-rust')({
            args = { '--no-capture' },
            dap_adapter = 'codelldb',
          }),
          -- Go ---------------------------------------------------------------------
          -- `runner = 'go'` uses `go test -json`; add gotestsum only if the
          -- binary is installed to avoid stdout corruption on some terminals.
          require('neotest-golang')({
            runner = 'go',
            go_test_args = { '-v', '-race', '-count=1' },
            -- debugger.lua defines no nvim-dap-go config, so use the manual
            -- delve setup (adapter registered in this plugin's config above).
            dap_mode = 'manual',
            dap_manual_config = {
              name = 'Debug go test',
              type = 'delve',
              request = 'launch',
              mode = 'test',
            },
          }),
          -- Python -----------------------------------------------------------------
          require('neotest-python')({
            runner = 'pytest',
            -- Merge target of the DAP launch config; type is fixed to 'python'
            -- by the adapter (alias registered in this plugin's config above).
            dap = { justMyCode = false },
          }),
          -- Fallback: neotest-vim-test MUST stay last so dedicated adapters win.
          -- ignore_filetypes mirrors every dedicated adapter's filetype.
          require('neotest-vim-test')({
            ignore_filetypes = {
              'rust',
              'go',
              'python',
              'javascript',
              'javascriptreact',
              'typescript',
              'typescriptreact',
              'cpp',
              'java',
              'cs',
              'fs',
            },
          }),
        },
        -- 0 = auto-scale workers to CPU count; keeps detection fast on large repos.
        discovery = {
          enabled = true,
          concurrent = 0,
          filter_dir = function(name)
            if ignored_dirs[name] then
              return false
            end
            for _, prefix in ipairs(ignored_prefixes) do
              if vim.startswith(name, prefix) then
                return false
              end
            end
            return true
          end,
        },
        running = { concurrent = true },
        default_strategy = 'integrated',
        strategies = {
          integrated = { width = 120, height = 40 },
        },
        -- `open_on_run` only opens output for a failing test under the cursor,
        -- so passing runs stay quiet while failures surface automatically.
        output = { enabled = true, open_on_run = true },
        output_panel = { enabled = true },
        quickfix = { enabled = true, open = false },
        status = { enabled = true, virtual_text = true, signs = true },
        diagnostic = { enabled = true, severity = vim.diagnostic.severity.ERROR },
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
        },
        watch = { enabled = true },
        floating = { border = 'rounded', max_width = 0.8, max_height = 0.8 },
        icons = {
          passed = '󰄬',
          running = '󰦖',
          failed = '󰅖',
          skipped = '󰜺',
          unknown = '󰋗',
          watching = '󰈈',
          test = '󰙨',
          file = '󰈙',
          dir = '󰉋',
          namespace = '󰌗',
          running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        },
      })
    end,
  },
}