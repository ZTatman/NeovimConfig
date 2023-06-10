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
  'SmiteshP/nvim-navic',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  'mattn/emmet-vim',
  -- Color Schemes
  'Mofiqul/vscode.nvim',
  'sainnhe/edge',
  -- Tag / Bracket completion
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',
  'akinsho/toggleterm.nvim',
  'tpope/vim-commentary',
  'tpope/vim-surround',
  { 'nvim-treesitter/nvim-treesitter',  build = ":TSUpdate" },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim' }
  },
  -- Language Server Protocol (LSP)
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  -- Formatting
  'jose-elias-alvarez/null-ls.nvim',
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
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'onsails/lspkind.nvim',
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },
  -- Cursor Highlight
  { 'tzachar/local-highlight.nvim' },
  --  Indent-blankine
  { "lukas-reineke/indent-blankline.nvim" },
  -- Git Merge Conflicts
  { 'akinsho/git-conflict.nvim',          version = "*", config = true },
  --  Automatic highlight removal
  'jesseleite/vim-noh',
  -- LSPSAGA (glepnir)
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
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
