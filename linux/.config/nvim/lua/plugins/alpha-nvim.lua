return {
  'goolord/alpha-nvim',
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    local plugins = vim.fn.len(vim.fn.globpath('~/.local/share/nvim/lazy/', '*', 0, 1))
    dashboard.section.header.val = {
      "                               ",
      "       ▄▀▀▀▀▀▀▀▀▀▀▄▄           ",
      "     ▄▀▀░░░░░░░░░░░░░▀▄        ",
      "   ▄▀░░░░░░░░░░░░░░░░░░▀▄      ",
      "   █░░░░░░░░░░░░░░░░░░░░░▀▄    ",
      "  ▐▌░░░░░░░░▄▄▄▄▄▄▄░░░░░░░▐▌   ",
      "  █░░░░░░░░░░░▄▄▄▄░░▀▀▀▀▀░░█   ",
      " ▐▌░░░░░░░▀▀▀▀░░░░░▀▀▀▀▀░░░▐▌  ",
      " █░░░░░░░░░▄▄▀▀▀▀▀░░░░▀▀▀▀▄░█  ",
      " █░░░░░░░░░░░░░░░░▀░░░▐░░░░░▐▌ ",
      " ▐▌░░░░░░░░░▐▀▀██▄░░░░░░▄▄▄░▐▌ ",
      "  █░░░░░░░░░░░▀▀▀░░░░░░▀▀██░░█ ",
      "  ▐▌░░░░▄░░░░░░░░░░░░░▌░░░░░░█ ",
      "   ▐▌░░▐░░░░░░░░░░░░░░▀▄░░░░░█ ",
      "    █░░░▌░░░░░░░░▐▀░░░░▄▀░░░▐▌ ",
      "    ▐▌░░▀▄░░░░░░░░▀░▀░▀▀░░░▄▀  ",
      "    ▐▌░░▐▀▄░░░░░░░░░░░░░░░░█   ",
      "    ▐▌░░░▌░▀▄░░░░▀▀▀▀▀▀░░░█    ",
      "    █░░░▀░░░░▀▄░░░░░░░░░░▄▀    ",
      "   ▐▌░░░░░░░░░░▀▄░░░░░░▄▀      ",
      "  ▄▀░░░▄▀░░░░░░░░▀▀▀▀█▀        ",
      " ▀░░░▄▀░░░░░░░░░░▀░░░▀▀▀▀▄▄▄▄▄ ",
      "                               ",
      "    " .. datetime,
      "        " .. "Neovim" .. nvim_version_info,
    }
    dashboard.section.buttons.val = {
      dashboard.button("e", "📂 New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "🔍 Find file", ":Telescope find_files <CR>"),
      dashboard.button("h", "⏳ Recently opened files", ":Telescope oldfiles <CR>"),
      dashboard.button("b", "🔖 Bookmarks", ":Telescope marks <CR>"),
      dashboard.button("c", "📰 Find word", ":Telescope live_grep <CR>"),
      dashboard.button("o", "🎨 Colorschemes",
        ":lua require (\"telescope.builtin\").colorscheme { enable_preview = true }<CR>"),
      dashboard.button("p", "🔌 Plugins", ":Lazy <CR>"),
      dashboard.button("x", "❌ Quit Neovim", ":qa <CR>"),
    }
    dashboard.section.footer.val = {
      " When I say I am going to do something they have to believe that it is impossible.",
      "  Because if doing things was possible they would have to do some soul searching  ",
      "               and ask the question why didn't they do anything.                  ",
      "                                                       ~ George Geohot Hotz (2023)",
      "                                                                                  ",
      "                                🪄 Loaded " .. plugins .. " plugins               ",
    }
    alpha.setup(dashboard.opts)
  end,
}
