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
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
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
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'xeluxee/competitest.nvim'
Plug 'chipsenkbeil/distant.nvim'
Plug 'jamestthompson3/nvim-remote-containers'
Plug 'sindrets/diffview.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
Plug 'mhinz/vim-startify'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lukas-reineke/indent-blankline.nvim'

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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ruler
set autoindent
set smartcase
set smartindent
set smarttab
set backspace=indent,eol,start
set termguicolors
set hidden

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
autocmd filetype cpp nnoremap <leader>b :<C-U>AsyncRun -mode=terminal -pos=bottom -rows=10 g++ -O2 -DLOCAL -std=c++20 -Wshadow -Wall -Wextra -Wno-unused-result -static -g -o '%:p:h/a.out' '%:r.cpp'<CR>
"autocmd filetype cpp nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 for ((i = 1; ; ++i)); do echo "CASE $i:"; /usr/bin/time -f "[CPU time: \%U sec]" ./a.out; echo ''; done<CR>
autocmd filetype cpp nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 /usr/bin/time -f "[CPU time: \%U sec]" '%:p:h/a.out'<CR>
autocmd filetype python nnoremap <leader>b :<C-U>AsyncRun -mode=terminal -pos=bottom -rows=10 python3 -m mypy %:r.py<CR>
autocmd filetype python nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 python3 %:r.py<CR>
autocmd filetype java nnoremap <leader>b :<C-U>AsyncRun -mode=terminal -pos=bottom -rows=10 javac %:r.java<CR>
autocmd filetype java nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 java Main<CR>
autocmd filetype sh nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 bash %:r.sh<CR>
autocmd filetype javascript nnoremap <leader>r :<C-U>AsyncRun -mode=terminal -pos=right -cols=30 node %:r.js<CR>

" nerdtree settings
nnoremap <C-n> :NERDTreeToggle<CR>

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

" colorscheme settings
" colorscheme gruvbox
let g:material_style = 'deep ocean'
colorscheme material

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
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
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
local cmp = require'cmp'

cmp.setup({
    snippet = {
            expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
            end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, 
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), 
        ["<Tab>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
    },
    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, 
        }, {
            { name = 'buffer' },
        }
    )
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline', keyword_pattern=[[\!\@<!\w*]]}
    })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
EOF

" competitest settings
nnoremap <leader>l :CompetiTestReceive <CR>
nnoremap <leader>t :CompetiTestRun <CR>
lua <<EOF
require('competitest').setup {
    compile_command = {
        cpp       = { exec = 'g++',           args = {'-O2', '-g', '-Wall', '-Wextra', '-Wno-unused-result', '-Wconversion', '-static', '-std=c++20', '$(FNAME)'} },
    },
    run_command = {
        cpp       = { exec = './a.out' },
    },
}
EOF

" lsp signature settings
lua <<EOF
cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    -- default is  ~/.cache/nvim/lsp_signature.log
    verbose = false, -- show debug line number

    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    floating_window_off_x = 1, -- adjust float windows x position.
    floating_window_off_y = 1, -- adjust float windows y position.


    fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🐼 ",  -- Panda for parameter
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    -- to view the hiding contents
    max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none
    },

    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
require'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
EOF

" lualine settings
lua << END
require('lualine').setup()
END

" bufferline settings
lua << EOF
require("bufferline").setup{}
EOF

" vim startify settings
let g:startify_custom_header = [
            \ "",
            \ "       __                _                  __             __ _       _     _ _ _ _            ",
            \ "     /\ \\ \\___  _____   _(_)_ __ ___        / /  __ _      / /(_) __ _| |__ (_) (_) |_ _   _    ",
            \ "    /  \\/ / _ \\/ _ \\ \\ / / | '_ ` _ \\     / /  / _` |    / / | |/ _` | '_ \\| | | | __| | | |   ",
            \ "   / /\\  /  __/ (_) \\ V /| | | | | | |   / /__| (_| |   / /__| | (_| | |_) | | | | |_| |_| |   ",
            \ "   \\_\\ \\/ \\___|\\___/ \\_/ |_|_| |_| |_|   \\____/\\__,_|___\\____/_|\\__,_|_.__/|_|_|_|\\__|\\__, |   ",
            \ "                                                   |_____|                            |___/    ",
            \ "                            [ Author: Koushik Sahu (La_Liablity) ]                         ",
            \ "                            [        Good luck, have fun!        ]                         ",
            \]
let g:startify_custom_footer = [
            \ '   +------------------------------------------- +',
            \ '   |       Talk is cheap Show me the code       |',
            \ '   |             ~ Linus Torvalds               |',
            \ '   |                                            |',
            \ '   | When something is important enough, you do |',
            \ '   | it even if the odds are not in your favour |',
            \ '   |                ~ Elon Musk                 |',
            \ '   |                                            |',
            \ '   |            Github: KoushikSahu             |',
            \ '   +------------------------------------------- +',
            \]

" indent-blankline settings
lua<<EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF
