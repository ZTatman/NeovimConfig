local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Navic
    'SmiteshP/nvim-navic',
    -- Fugitive
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    -- Gitsigns
    'lewis6991/gitsigns.nvim',
    -- NvimTree
    'nvim-tree/nvim-tree.lua',
    -- Web Dev Icons
    'nvim-tree/nvim-web-devicons',
    -- Lualine
    'nvim-lualine/lualine.nvim',
    -- Color Schemes
    'Mofiqul/vscode.nvim',
    'sainnhe/edge',
    -- Tag / Bracket completion
    'windwp/nvim-autopairs',
    'windwp/nvim-ts-autotag',
    -- Toggleterm
    'akinsho/toggleterm.nvim',
    -- Comments
    'tpope/vim-commentary',
    -- Auto Brackets
    'tpope/vim-surround',
    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        build = ":TSUpdate"
    },
    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim'
        }
    },
    -- Fzf-native (speeds up telescope)
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- Language Server Protocol (LSP)
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    -- Lspsaga (glepnir's but maintained by nvimdev)
    {
        'nvimdev/lspsaga.nvim',
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" }
        }
    },

    -- Formatting
    'jose-elias-alvarez/null-ls.nvim',
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" }
    },
    { 'akinsho/bufferline.nvim',            version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    -- Completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'onsails/lspkind.nvim',
        }
    },
    -- Tailwind Support
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    },
    -- Tailwind Class Sorter
    {
        'laytan/tailwind-sorter.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        build = 'cd formatter && npm i && npm run build',
        config = {},
    },
    -- Cursor Highlight
    { 'tzachar/local-highlight.nvim' },
    -- Indentation guides
    { "lukas-reineke/indent-blankline.nvim" },
    -- Git Merge Conflicts
    { 'akinsho/git-conflict.nvim',          version = "*", config = true },
    --  Automatic highlight removal
    'jesseleite/vim-noh',
    -- Colorizer
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    tailwind = true
                }
            })
        end
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
