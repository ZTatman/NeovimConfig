local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local map = vim.keymap.set

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- Open Mason and LspInfo
map('n', '<leader>m', '<cmd>:Mason<CR>', opts)
map('n', '<leader>l', '<cmd>:LspInfo<CR>', opts)
map('n', '<leader>n', '<cmd>:NullLsInfo<CR>', opts)

-- Remap exit insert
map('i', '<c-space>', '<ESC>', opts)

-- Move faster between windows
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Source files and init vim
map('n', '<leader>ev', ':vsplit $MYVIMRC<cr>', opts)
map('n', '<leader>sv', ':source $MYVIMRC<cr>', opts)
map('n', '<leader>so', ':source %<cr>', opts)

-- Remap undo
map('n', '<c-z>', 'u', opts)
map('i', '<c-z>', '<c-o>u', opts)

-- Remap substitute
map('n', '<leader>s', ':%s/')

-- Remap write to buffer
map('i', '<c-s>', '<C-O>:update<CR>')

-- Navigate up/down to first non blank character of line
map('n', '<m-Up>', '<Up>^', opts)
map('n', '<m-Down>', '<Down>^', opts)

-- Move lines up and down
map('n', '<Space>k', ':m .-2<CR>==', opts)
map('n', '<Space>j', ':m .+1<CR>==', opts)
map('v', '<Space>j', ':m \'>+1<CR>gv=gv', opts)
map('v', '<Space>k', ':m \'<-2<CR>gv=gv', opts)

-- Exit insert mode
map('i', '<c-space>', '<Esc>', opts)

-- Toggle nvim-tree
map('n', '<c-b>', ':NvimTreeToggle<CR>', opts)
map('n', '<c-f>', ':NvimTreeFindFile<CR>', opts)

-- Clear highlight
map('n', '<space><leader>', ':nohlsearch<CR>')

-- Tab create, delete, navigation
map('n', 'tn', ':tabnew<CR>', opts)
map('n', 'tnf', ':tabnew<space>', opts)
map('n', ']t', ':tabnext<CR>', opts)
map('n', '[t', ':tabprevious<CR>', opts)
map('n', 'tq', ':confirm tabclose<CR>', opts)
map('n', 'tl', ':tabs<CR>', opts)

-- Bufferline Keymaps
map('n', '<leader>bs', ':BufferLineSortByTabs<CR>', opts)

-- Format Buffer
map('n', '<leader>f', ':Format<CR>', opts)

-- Select All
map('n', '<c-a>', 'gg<S-v>G', opts)

-- Sort Tailwind Classes
map('n', '<leader>ts', ':TailwindSort<CR>')

--- Abbreviations ---
