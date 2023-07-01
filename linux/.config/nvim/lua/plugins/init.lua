-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use 'marko-cerovac/material.nvim'
  use 'eddyekofo94/gruvbox-flat.nvim'

  -- for indentations
  use 'tpope/vim-sleuth'
  use "lukas-reineke/indent-blankline.nvim"

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- bufferline
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}

  -- file explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use 'nvim-tree/nvim-web-devicons'

  -- autoclose brackets
  use 'jiangmiao/auto-pairs'

  -- lsp, linters, formatters, autocompletion
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional
  
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
      {'github/copilot.vim'},
      {'saadparwaiz1/cmp_luasnip'},
      {'ray-x/lsp_signature.nvim'}
    }
  }

  -- comments
  use 'preservim/nerdcommenter'

  -- surround
  use 'tpope/vim-surround'

  -- language support
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- git integrations
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- search help
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- debugging integrations
  use 'puremourning/vimspector'

  -- notifications
  use 'rcarriga/nvim-notify'

  -- competitive programming integration
  use {
    'xeluxee/competitest.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function() require'competitest'.setup{
      compile_command = {
        cpp       = { exec = 'g++',           args = {'-O2', '-g', '-Wall', '-Wextra', '-Wno-unused-result', '-Wconversion', '-static', '-std=c++20', '$(FNAME)'} },
      },
      run_command = {
        cpp       = { exec = './a.out' },
      },
    } end
  }

  -- undo tree
  use 'mbbill/undotree'

  -- breadcurmbs
  use ({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup()
    end,
  })

  -- cursor highlighting
  use 'RRethy/vim-illuminate'

  -- shows colors for hex values
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup() end
  }

  -- symbols
  use {
    'simrat39/symbols-outline.nvim',
    config = function() require'symbols-outline'.setup() end
  }

  -- preview definitions, references and implementations
  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end
  }

  -- error and fix list
  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require("trouble").setup {} end
  }

  -- todo comments
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require("todo-comments").setup {} end
  }

  -- null ls with mason
  use{
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("null-ls").setup({
        sources = {}
      })
    end
  }
  use {
    'jay-babu/mason-null-ls.nvim',
    requires = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
  }
end)

