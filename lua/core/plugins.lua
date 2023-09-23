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
    'glepnir/zephyr-nvim',
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
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
            'nvim-lua/popup.nvim',
            "natecraddock/workspaces.nvim",
        }
    },
    -- Fzf-native (speeds up telescope)
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- Language Server Protocol (LSP)
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { 'mfussenegger/nvim-jdtls' },
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
    -- Split/Join objects, arrays, lists, nested blocks of code
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({ use_default_keymaps = false, max_join_length = 240 })
        end,
    },
    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" }
    },
    -- Bufferline
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
    },
    --- Pretter List (Diagnostics, references, implementations, quickfixes, etc...)
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            use_diagnostic_signs = true,
        },
    },
    -- Start Screen
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = "doom",
                hide = {
                    statusline = false,
                    tabline = true,
                    winbar = true,
                },
                config = {
                    header = {
                        [[]],
                        [[]],
                        [[]],
                        [[]],
                        [[]],
                        [[]],
                        [[]],
                        [[╔══╗ ╔╗   ╔═══╗╔═══╗╔╗╔═╗    ╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗╔═╗ ╔╗    ╔═══╗╔════╗╔╗ ╔╗ ╔═══╗ ╔═══╗]],
                        [[║╔╗║ ║║   ║╔═╗║║╔═╗║║║║╔╝    ║╔═╗║║╔═╗║║╔═╗║║╔══╝║╔══╝║║╚╗║║    ║╔═╗║║╔╗╔╗║║║ ║║ ║╔══╝ ║╔══╝]],
                        [[║╚╝╚╗║║   ║║ ║║║║ ╚╝║╚╝╝     ║╚══╗║║ ╚╝║╚═╝║║╚══╗║╚══╗║╔╗╚╝║    ║╚══╗╚╝║║╚╝║║ ║║ ║╚══╗ ║╚══╗]],
                        [[║╔═╗║║║ ╔╗║╚═╝║║║ ╔╗║╔╗║     ╚══╗║║║ ╔╗║╔╗╔╝║╔══╝║╔══╝║║╚╗║║    ╚══╗║  ║║  ║║ ║║ ║╔══╝ ║╔══╝]],
                        [[║╚═╝║║╚═╝║║╔═╗║║╚═╝║║║║╚╗    ║╚═╝║║╚═╝║║║║╚╗║╚══╗║╚══╗║║ ║║║    ║╚═╝║ ╔╝╚╗ ║╚═╝║╔╝╚╗  ╔╝╚╗  ]],
                        [[╚═══╝╚═══╝╚╝ ╚╝╚═══╝╚╝╚═╝    ╚═══╝╚═══╝╚╝╚═╝╚═══╝╚═══╝╚╝ ╚═╝    ╚═══╝ ╚══╝ ╚═══╝╚══╝  ╚══╝  ]],
                        [[]],
                        [[]],
                        [[]],
                        [[]],
                        [[]]
                    },
                    center = {
                        {
                            icon = "",
                            desc = "   Lazy sync / TSUpdate / MasonToolsUpdate   ",
                            key = "s",
                            action = "UpdateAndSyncAll",
                        },
                        {
                            icon = "",
                            desc = "   Lazy sync   ",
                            key = "l",
                            action = "Lazy sync",
                        },
                        {
                            icon = "",
                            desc = "   Mason   ",
                            key = "m",
                            action = "Mason",
                        },
                        {
                            icon = "",
                            desc = "   Telescope   ",
                            key = "t",
                            action = "Telescope",
                        },
                        {
                            icon = "",
                            desc = "   Find files   ",
                            key = "f",
                            action = "Telescope find_files",
                        },
                        -- {
                        --     icon = "",
                        --     desc = "Harpoon",
                        --     key = "h",
                        --     action = "require('harpoon.ui').toggle_quick_menu()",
                        -- },
                        {
                            icon = "",
                            desc = "   Restore session   ",
                            key = "r",
                            action = "SessionRestore",
                        },
                        {
                            icon = "",
                            desc = "   Workspaces   ",
                            key = "w",
                            action = "Telescope workspaces",
                        },
                        {
                            icon = "",
                            desc = "   Empty buffer   ",
                            key = "e",
                            action = "enew",
                        },
                        {
                            icon = "",
                            desc = "   Quit   ",
                            key = "q",
                            action = "qa!",
                        },
                    },
                },
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    -- Markdown Syntax Highlighting
    {
        'lukas-reineke/headlines.nvim',
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = 'markdown',
        event = 'VeryLazy',
        config = function()
            require('headlines').setup {
                markdown = {
                    query = vim.treesitter.query.parse(
                        'markdown',
                        [[
              (atx_heading [
                (atx_h1_marker)
                (atx_h2_marker)
                (atx_h3_marker)
                (atx_h4_marker)
                (atx_h5_marker)
                (atx_h6_marker)
              ] @headline)

              (thematic_break) @dash

              (fenced_code_block) @codeblock

              (block_quote_marker) @quote
              (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
                    ),
                    headline_highlights = {
                        'Headline1',
                        'Headline2',
                        'Headline3',
                        'Headline4',
                        'Headline5',
                        'Headline6',
                    },
                    codeblock_highlight = 'CodeBlock',
                    dash_highlight = 'Dash',
                    dash_string = '-',
                    quote_highlight = 'Quote',
                    quote_string = '┃',
                    fat_headlines = true,
                    fat_headline_upper_string = '▃',
                    fat_headline_lower_string = '▀',
                },
            }

            vim.api.nvim_set_hl(0, 'Headline1', { fg = '#cb7676', bg = '#402626', italic = false })
            vim.api.nvim_set_hl(0, 'Headline2', { fg = '#c99076', bg = '#66493c', italic = false })
            vim.api.nvim_set_hl(0, 'Headline3', { fg = '#80a665', bg = '#3d4f2f', italic = false })
            vim.api.nvim_set_hl(0, 'Headline4', { fg = '#4c9a91', bg = '#224541', italic = false })
            vim.api.nvim_set_hl(0, 'Headline5', { fg = '#6893bf', bg = '#2b3d4f', italic = false })
            vim.api.nvim_set_hl(0, 'Headline6', { fg = '#d3869b', bg = '#6b454f', italic = false })
            vim.api.nvim_set_hl(0, 'CodeBlock', { bg = '#444444' })
        end,
    },
    -- Markdown Preview
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && npm install',
        cmd = 'MarkdownPreview',
        ft = 'markdown',
        event = 'VeryLazy',
        init = function()
            vim.api.nvim_create_augroup('MD_Preview', { clear = true })
            vim.api.nvim_create_autocmd('Filetype', {
                group = 'MD_Preview',
                pattern = { 'markdown' },
                callback = function()
                    vim.keymap.set('n', '<C-m>', '<Cmd>MarkdownPreview<CR>', { silent = true, buffer = true })
                end,
            })
        end,
        config = function()
            vim.g.mkdp_page_title = '${name} - Preview'
            vim.g.mkdp_echo_preview_url = 1
        end,
    },
    -- Markdown Folds & Formatting
    {
        'plasticboy/vim-markdown',
        dependencies = 'godlygeek/tabular',
        ft = 'markdown',
        event = 'VeryLazy',
        config = function()
            vim.g.vim_markdown_folding_disabled = 1
            vim.g.vim_markdown_toc_autofit = 1
            vim.g.vim_markdown_follow_anchor = 1
            vim.g.vim_markdown_conceal = 1
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_strikethrough = 1
            vim.g.vim_markdown_new_list_item_indent = 4
            vim.g.vim_markdown_edit_url_in = 'tab'

            vim.o.conceallevel = 2
            vim.g.tex_conceal = ''

            vim.api.nvim_create_augroup('Markdown', { clear = true })
            vim.api.nvim_create_autocmd('Filetype', {
                group = 'Markdown',
                pattern = { 'markdown' },
                callback = function()
                    vim.keymap.set('x', '<C-Enter>', ':<C-U>TableFormat<CR>', { silent = true })
                end,
            })
        end,
    },
    -- Simple automatic session managment
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            log_level = "error",
            auto_session_suppress_dirs = { "~/" },
            auto_restore_enabled = false,
            auto_session_enabled = true,
            bypass_session_save_file_types = {
                "dashboard",
            },
        },
        cmd = { "SessionRestore" },
    },
    -- Workspace Directory Management
    {
        "natecraddock/workspaces.nvim",
        opts = {
            hooks = {
                open = { "Telescope find_files" },
            },
        },
        cmd = { "Telescope", "WorkspacesAdd" },
        keys = {
            vim.keymap.set("n", "<leader>w", "<cmd>:Telescope workspaces<CR>"),
        },
    }
}

local opts = {}

require("lazy").setup(plugins, opts)
require("lazy").setup(plugins, opts)
