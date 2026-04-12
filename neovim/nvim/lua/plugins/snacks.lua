local function toggle_snack(id, factory)
  return function()
    local toggle = Snacks.toggle.get(id) or factory()
    toggle:toggle()
  end
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {},
    quickfile = {},
    dashboard = {
      enabled = true,
      sections = {
        {
          header = [[

       ▄▀▀▀▀▀▀▀▀▀▀▄▄
     ▄▀▀░░░░░░░░░░░░░▀▄
   ▄▀░░░░░░░░░░░░░░░░░░▀▄
   █░░░░░░░░░░░░░░░░░░░░░▀▄
  ▐▌░░░░░░░░▄▄▄▄▄▄▄░░░░░░░▐▌
  █░░░░░░░░░░░▄▄▄▄░░▀▀▀▀▀░░█
 ▐▌░░░░░░░▀▀▀▀░░░░░▀▀▀▀▀░░░▐▌
 █░░░░░░░░░▄▄▀▀▀▀▀░░░░▀▀▀▀▄░█
 █░░░░░░░░░░░░░░░░▀░░░▐░░░░░▐▌
 ▐▌░░░░░░░░░▐▀▀██▄░░░░░░▄▄▄░▐▌
  █░░░░░░░░░░░▀▀▀░░░░░░▀▀██░░█
  ▐▌░░░░▄░░░░░░░░░░░░░▌░░░░░░█
   ▐▌░░▐░░░░░░░░░░░░░░▀▄░░░░░█
    █░░░▌░░░░░░░░▐▀░░░░▄▀░░░▐▌
    ▐▌░░▀▄░░░░░░░░▀░▀░▀▀░░░▄▀
    ▐▌░░▐▀▄░░░░░░░░░░░░░░░░█
    ▐▌░░░▌░▀▄░░░░▀▀▀▀▀▀░░░█
    █░░░▀░░░░▀▄░░░░░░░░░░▄▀
   ▐▌░░░░░░░░░░▀▄░░░░░░▄▀
  ▄▀░░░▄▀░░░░░░░░▀▀▀▀█▀
 ▀░░░▄▀░░░░░░░░░░▀░░░▀▀▀▀▄▄▄▄▄

            ]],
          height = 5,
          padding = 1
        }, { section = "header" },
        { section = "keys",  gap = 1, padding = 1 }, {
        icon = " ",
        title = "Recent Files",
        section = "recent_files",
        indent = 2,
        padding = 1
      }, {
        icon = " ",
        title = "Projects",
        section = "projects",
        indent = 2,
        padding = 1
      }, {
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status -sb && git symbolic-ref --short HEAD",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
        indent = 3
      }, { section = "startup" }
      }
    },
    notifier = { enabled = true, timeout = 3000 },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    },
    input = {
      icon = " ",
      icon_hl = "SnacksInputIcon",
      icon_pos = "left",
      prompt_pos = "title",
      win = { style = "input" },
      expand = true,
    },
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          auto_close = true,
          diagnostics = false,
          git_status = false,
          git_untracked = false,
          hidden = true,
        }
      }
    },
    explorer = {
      replace_netrw = false,
    },
  },
  keys = {
    {
      "<leader>.",
      function() Snacks.scratch() end,
      desc = "Toggle Scratch Buffer"
    }, {
    "<leader>S",
    function() Snacks.scratch.select() end,
    desc = "Select Scratch Buffer"
  }, {
    "<leader>n",
    function() Snacks.notifier.show_history() end,
    desc = "Show Notification History"
  },
    {
      "<leader>bd",
      function() Snacks.bufdelete() end,
      desc = "Delete Buffer"
    }, {
    "<leader>cR",
    function() Snacks.rename.rename_file() end,
    desc = "Rename File"
  },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Open Git Browser" },
    {
      "<leader>gb",
      function() Snacks.git.blame_line() end,
      desc = "Show Git Blame"
    }, {
    "<leader>gf",
    function() Snacks.lazygit.log_file() end,
    desc = "Open File Git History"
  }, { "<leader>gg", function() Snacks.lazygit() end, desc = "Open Lazygit" },
    {
      "<leader>gl",
      function() Snacks.lazygit.log() end,
      desc = "Open Git Log"
    }, {
    "<leader>un",
    function() Snacks.notifier.hide() end,
    desc = "Dismiss Notifications"
  },
    { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
    {
      "]]",
      function() Snacks.words.jump(vim.v.count1) end,
      desc = "Go To Next Reference",
      mode = { "n", "t" }
    }, {
    "[[",
    function() Snacks.words.jump(-vim.v.count1) end,
    desc = "Go To Previous Reference",
    mode = { "n", "t" }
  }, {
    "<leader>N",
    desc = "Show Neovim News",
    function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 3
        }
      })
    end
  },
    { "<C-p>",      function() Snacks.picker.files() end,                                                                                       desc = "Find Files" },
    { "<C-f>",      function() Snacks.picker.grep() end,                                                                                        desc = "Grep Files" },
    { "<C-n>",      function() Snacks.explorer() end,                                                                                           desc = "Toggle File Explorer" },
    { "gd",         function() Snacks.picker.lsp_definitions() end,                                                                             desc = "Go To Definition" },
    { "gD",         function() Snacks.picker.lsp_declarations() end,                                                                            desc = "Go To Declaration" },
    { "gr",         function() Snacks.picker.lsp_references() end,                                                                              nowait = true,                  desc = "Show References" },
    { "gi",         function() Snacks.picker.lsp_implementations() end,                                                                         desc = "Go To Implementation" },
    { "gy",         function() Snacks.picker.lsp_type_definitions() end,                                                                        desc = "Go To Type Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end,                                                                                 desc = "Search Symbols" },
    { "<leader>us", toggle_snack("spell", function() return Snacks.toggle.option("spell", { name = "Spelling" }) end),                          desc = "Toggle Spelling" },
    { "<leader>uw", toggle_snack("wrap", function() return Snacks.toggle.option("wrap", { name = "Wrap" }) end),                                desc = "Toggle Wrap" },
    { "<leader>uL", toggle_snack("relativenumber", function() return Snacks.toggle.option("relativenumber",
        { name = "Relative Number" }) end),                                                                                                     desc = "Toggle Relative Number" },
    { "<leader>ud", toggle_snack("diagnostics", function() return Snacks.toggle.diagnostics() end),                                             desc = "Toggle Diagnostics" },
    { "<leader>ul", toggle_snack("line_number", function() return Snacks.toggle.line_number() end),                                             desc = "Toggle Line Numbers" },
    {
      "<leader>uc",
      toggle_snack("conceallevel", function()
        return Snacks.toggle.option("conceallevel", {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
        })
      end),
      desc = "Toggle Conceal"
    },
    { "<leader>uT", toggle_snack("treesitter", function() return Snacks.toggle.treesitter() end),   desc = "Toggle Treesitter Highlighting" },
    {
      "<leader>ub",
      toggle_snack("background", function()
        return Snacks.toggle.option("background", {
          off = "light",
          on = "dark",
          name = "Dark Background",
        })
      end),
      desc = "Toggle Background Theme"
    },
    { "<leader>uh", toggle_snack("inlay_hints", function() return Snacks.toggle.inlay_hints() end), desc = "Toggle Inlay Hints" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end
    })
  end
}
