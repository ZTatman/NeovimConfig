if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

if has("nvim")
  " Improved syntax highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 
  " Netwr Enhancement
  Plug 'tpope/vim-vinegar'
  Plug 'preservim/nerdtree'

  " Commenting code
  Plug 'tpope/vim-commentary'


  " COC langauage support/completion
  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Themes
  Plug 'git@github.com:ful1e5/onedark.nvim.git'
  Plug 'wadackel/vim-dogrun'
  Plug 'liuchengxu/space-vim-dark'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'sainnhe/sonokai'
  
  " Git signs
  Plug 'lewis6991/gitsigns.nvim'
  
  " Diff view 
  Plug 'sindrets/diffview.nvim'

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

  "braces and tag completion
  Plug 'windwp/nvim-autopairs'
  Plug 'windwp/nvim-ts-autotag'

  " braces and tag add/delete
  Plug 'tpope/vim-surround'

  " Clear highlight after search
  Plug 'jesseleite/vim-noh'

  " Key Map Reminder
  Plug 'folke/which-key.nvim'

  " File Search Across Project
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  
endif

call plug#end()
