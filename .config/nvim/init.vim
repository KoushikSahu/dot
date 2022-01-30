call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'kshenoy/vim-signature'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'puremourning/vimspector'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'yggdroot/indentline'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'glepnir/lspsaga.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'flazz/vim-colorschemes'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" leader mapping
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" editor settings
syntax enable
set clipboard=unnamedplus
set relativenumber
set cursorline
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ruler
set autoindent
set smartcase
set backspace=indent,eol,start
set termguicolors

" keybindings
nmap <leader>y ggVGy
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <silent> <C-H> <C-R>=AutoPairsDelete()<CR><C-W>

" compilation and build key bindings
autocmd filetype cpp nnoremap <leader>b :<C-U>AsyncRun -mode=terminal -pos=bottom -rows=10 g++ -O2 -DLOCAL -std=c++20 -Wshadow -Wall -Wextra -Wno-unused-result -static -g %:r.cpp<CR>
autocmd filetype cpp nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 for ((i = 1; ; ++i)); do echo "CASE $i:"; /usr/bin/time -f "[CPU time: \%U sec]" ./a.out; echo ''; done<CR>
autocmd filetype python nnoremap <leader>b :<C-U>AsyncRun -mode=terminal -pos=bottom -rows=10 python3 -m mypy %:r.py<CR>
autocmd filetype python nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 python3 %:r.py<CR>
autocmd filetype java nnoremap <leader>b :<C-U>AsyncRun -mode=terminal -pos=bottom -rows=10 javac %:r.java<CR>
autocmd filetype java nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 java Main<CR>
autocmd filetype sh nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 bash %:r.sh<CR>
autocmd filetype javascript nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 node %:r.js<CR>

" nerdtree settings
nnoremap <C-n> :NERDTreeToggle<CR>

" dashboard-nvim settings
let g:dashboard_default_executive ='telescope'

" telescope settings
nnoremap <C-P> <cmd>Telescope find_files<cr>
nnoremap <C-F> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
lua <<EOF
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})
EOF

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" colorscheme settings
"colorscheme gruvbox
colorscheme nightfly

" asyncrun settings
let g:asyncrun_open = 8
let g:asyncrun_trim = 1
let g:asyncrun_stdin = 1

" autopair settings
let g:AutoPairsMapCh = 0

" markdown-preview settings

" vimspector settings
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>dd :call vimspector#Launch()<CR>
nmap <leader>de :call vimspector#Reset()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>dc :call vimspector#Continue()<CR>
nmap <leader>dw :VimspectorWatch 
nmap <leader>dv :VimspectorEval 
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>drc <Plug>VimspectorRunToCursor

" treesitter settings
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" lspconfig settings
lua <<EOF
local keymap = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }
keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
EOF

" ultisnips settings
let g:UltiSnipsSnippetDirectories = ["snips"]

" lspsaga settings
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> <leader>ca :Lspsaga code_action<CR>
vnoremap <silent> <leader>ca :<C-U>Lspsaga range_code_action<CR>
"nnoremap <silent> K :Lspsaga hover_doc<CR>
"nnoremap <silent> gs :Lspsaga signature_help<CR>
"nnoremap <silent> gr :Lspsaga rename<CR>
"nnoremap <silent> gd :Lspsaga preview_definition<CR>
"nnoremap <silent> <leader>t :Lspsaga open_floaterm<CR>
"tnoremap <silent> <leader>t <C-\><C-n>:Lspsaga close_floaterm<CR>

" lspinstall settings
lua <<EOF
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)
EOF

" nvim-cmp settings
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')[<lsp-server>].setup {
    -- capabilities = capabilities
  -- }
EOF

