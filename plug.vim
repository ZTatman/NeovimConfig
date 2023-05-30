if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

" Plugins
" ------------------------------------------------------
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

if has("nvim")
  " Improved syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 

  Plug 'tpope/vim-vinegar'      " Enhancement to netrw (file explorer)
  Plug 'tpope/vim-commentary'   " Code commenter
  Plug 'tpope/vim-surround'     " braces and tag add/delete
 
  Plug 'kyazdani42/nvim-tree.lua' " File tree
  Plug 'kyazdani42/nvim-web-devicons' " File tree icons
  " File Icons
  Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons)
  Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

  " COC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  
  " Themes
  Plug 'navarasu/onedark.nvim'
  Plug 'rebelot/kanagawa.nvim'
  Plug 'srcery-colors/srcery-vim'
  Plug 'martinsione/darkplus.nvim'
  Plug 'Mofiqul/vscode.nvim'

  " Git signs
  Plug 'lewis6991/gitsigns.nvim'

  " Tmux pane navigation 
  Plug 'christoomey/vim-tmux-navigator'
  
  " ToggleTerm
  Plug 'akinsho/toggleterm.nvim'
  
  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  
  " Lualine
  Plug 'hoob3rt/lualine.nvim'
  " @Deprecated, use nvim-navic && nav-buddy instead (requires lsp-config)
  Plug 'SmiteshP/nvim-gps'
  
  "braces and tag completion
  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'

  " Clear highlight after search
  Plug 'jesseleite/vim-noh'
  
  " File Search Across Project
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  " Key map reminder
  Plug 'folke/which-key.nvim'

  " Indentation guide
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Emmet abbreviations
  Plug 'mattn/emmet-vim'
endif

call plug#end()
