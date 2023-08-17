local P = {}
keymaps = P

local term_opts = { silent = true }
local opts = { noremap = true, silent = true }

local map = function(mode, key, result)
    vim.keymap.set(mode, key, result)
end

-- LSP Keymaps --
function map_lsp_keys()
    map('n', "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    map("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    map("n", "gi", "<cmd>Lspsaga finder imp<CR>")
    map("n", "gr", "<cmd>Lspsaga finder ref<CR>")
    map("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
    map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
    map("n", "<space>f", "<cmd>Lspsaga finder<CR>")

    map("n", "H", "<cmd>Lspsaga hover_doc<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map("n", "rn", "<cmd>Lspsaga rename<CR>")
    map("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
    -- map(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>")
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    map("n", "<space>d", "<cmd>Lspsaga show_buf_diagnostics<CR>")
    map("n", "<space>D", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
    vim.cmd [[ command! Format execute "lua vim.lsp.buf.format({ async = true })" ]]
end

-- Java Keymaps --
function P.map_java_keys()
    map_lsp_keys()

    local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
    local spring_boot_run_command = ':lua require("toggleterm").exec("\' .. spring_boot_run .. \'")<CR>'
    local mvn_clean_install = 'mvn clean install -U'
    local mvn_clean_install_command = ':lua require("toggleterm").exec("\' .. mvn_clean_install .. \'")<CR>'

    map('n', '<leader>sr', spring_boot_run_command)
    map('n', '<leader>ci', mvn_clean_install_command)
    map('n', 'oi', ':lua require("jdtls").organize_imports()<CR>')
    map('n', '<leader>jc', ':lua require("jdtls).compile("incremental")')
end

-- General Keymaps --
--
-- Leader
vim.g.mapleader = '\\'

-- Open Mason and LspInfo
map('n', '<leader>m', '<cmd>:Mason<CR>')
map('n', '<leader>l', '<cmd>:LspInfo<CR>')
map('n', '<leader>n', '<cmd>:NullLsInfo<CR>')

-- Remap exit insert
map('i', '<c-space>', '<ESC>')

-- Move faster between windows
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Source files and init vim
map('n', '<leader>ev', ':vsplit $MYVIMRC<cr>')
map('n', '<leader>sv', ':source $MYVIMRC<cr>')
map('n', '<leader>so', ':source %<cr>')

-- Remap undo
map('n', '<c-z>', 'u')
map('i', '<c-z>', '<c-o>u')

-- Remap substitute
map('n', '<leader>s', ':%s/')

-- Remap write to buffer
map('i', '<c-s>', '<C-O>:update<CR>')

-- Navigate up/down to first non blank character of line
map('n', '<m-Up>', '<Up>^')
map('n', '<m-Down>', '<Down>^')

-- Move lines up and down
map('n', '<Space>k', ':m .-2<CR>==')
map('n', '<Space>j', ':m .+1<CR>==')
map('v', '<Space>j', ':m \'>+1<CR>gv=gv')
map('v', '<Space>k', ':m \'<-2<CR>gv=gv')

-- Exit insert mode
map('i', '<c-space>', '<Esc>')

-- Toggle nvim-tree
map('n', '<c-b>', ':NvimTreeToggle<CR>')
map('n', '<c-f>', ':NvimTreeFindFile<CR>')

-- Clear highlight
map('n', '<space><leader>', ':nohlsearch<CR>')

-- Tab create, delete, navigation
map('n', 'tn', ':tabnew<CR>')
map('n', 'tnf', ':tabnew<space>')
map('n', '[t', ':tabprevious<CR>')
map('n', ']t', ':tabnext<CR>')
map('n', 'tq', ':confirm tabclose<CR>')
map('n', 'tl', ':tabs<CR>')

-- Bufferline Keymaps
map('n', '<leader>bs', ':BufferLineSortByTabs<CR>')

-- Format Buffer
map('n', '<leader>f', ':Format<CR>')

-- Select All
map('n', '<c-a>', 'gg<S-v>G')

-- Sort Tailwind Classes
map('n', '<leader>ts', ':TailwindSort<CR>')

-- Resize Vertical Splits
map('n', '<leader>=', '<C-w>=')
map('n', '<leader>>', '<C-w>50>')
map('n', '<leader><', '<C-w>50<')

-- Gitsigns hunks
map('n', '[h', ':Gitsigns prev_hunk<CR>')
map('n', ']h', ':Gitsigns next_hunk<CR>')
map('n', 'ph', ':Gitsigns preview_hunk<CR>')
map('n', 'vh', ':Gitsigns select_hunk<CR>')
map('n', 'sh', ':Gitsigns stage_hunk<CR>')
map('n', 'uh', ':Gitsigns refresh_hunk<CR>')

return P
