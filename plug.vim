if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

" Plugins {{{
" ------------------------------------------------------
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

if has("nvim")
  " Improved syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
  " Plug 'pangloss/vim-javascript'

  Plug 'tpope/vim-vinegar'      " Enhancement to netrw (file explorer)
  Plug 'tpope/vim-commentary'   " Code commenter
  Plug 'tpope/vim-surround'     " braces and tag add/delete
 
  Plug 'kyazdani42/nvim-tree.lua' " File tree
  Plug 'kyazdani42/nvim-web-devicons' " File tree icons
 
  " COC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  
  " Themes
  " Plug 'git@github.com:ful1e5/onedark.nvim.git
  Plug 'navarasu/onedark.nvim'
  Plug 'Everblush/everblush.nvim', { 'as': 'everblush' }
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'sainnhe/sonokai'

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
  
  " File Icons
  Plug 'ryanoasis/vim-devicons'
  
  " Lualine
  Plug 'hoob3rt/lualine.nvim'
  Plug 'SmiteshP/nvim-gps'
  
  "braces and tag completion
  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'

  " Clear highlight after search
  Plug 'jesseleite/vim-noh'
  
  " File Search Across Project
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'folke/which-key.nvim'   " Key map reminder
  Plug 'folke/zen-mode.nvim'    " Distraction free coding (zen mode)

  " Indentation guide
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Emmet abbreviations
  Plug 'mattn/emmet-vim'
endif

call plug#end()
" }}}
