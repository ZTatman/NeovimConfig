-- local diff = require "core.utils.diff"
local fn = require("core.util.functions")
local P = {}
keymaps = P

-- local term_opts = { silent = true }
local opts = { noremap = false, silent = true }

local map = function(mode, key, result)
    vim.keymap.set(mode, key, result, opts)
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
    map("n", "<leader>es", "<cmd>EslintFixAll<CR>")

    map("n", "H", "<cmd>Lspsaga hover_doc<CR>")
    map("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    map("n", "rn", "<cmd>Lspsaga rename<CR>")
    map("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
    -- map(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>")
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    map("n", "<leader>d", function() require("trouble").open("document_diagnostics") end)
    map("n", "<leader>D", function() require("trouble").open("workspace_diagnostics") end)
    vim.cmd [[ command! Format execute "lua vim.lsp.buf.format({ async = true })" ]]

    -- Trouble.nvim Keymaps
    map("n", "<leader>t", "<cmd>TroubleToggle<CR>")
    map("n", "<leader>tq", function() require("trouble").open("quickfix") end)
    map("n", "<leader>tl", function() require("trouble").open("loclist") end)
    map("n", "gR", function() require("trouble").open("lsp_references") end)
end

-- Java Keymaps --
function P.map_java_keys()
    print("Mapping java keys...")
    map_lsp_keys()

    local spring_boot_run_command = ':lua require("toggleterm").exec("mvn spring-boot:run -Dspring-boot.run.profiles=local")<CR>'
    local mvn_clean_install_command = ':lua require("toggleterm").exec("mvn clean install -U")<CR>'
    local mcv_dependency_sources = 'lua:require("toggleterm).exec("mvn dependency:sources)<CR>'

    map('n', '<leader>sr', spring_boot_run_command)
    map('n', '<leader>ci', mvn_clean_install_command)
    map('n', '<leader>sc', mcv_dependency_sources)
    map('n', 'oi', ':lua require("jdtls").organize_imports()<CR>')
    map('n', '<leader>jc', ':lua require("jdtls").compile("incremental")<CR>')
end

---------------------
-- General Keymaps --
---------------------

-- Leader
vim.g.mapleader = '\\'

-- Open Mason and LspInfo
map('n', '<leader>m', '<cmd>:Mason<CR>')
map('n', '<leader>l', '<cmd>:Lazy<CR>')
map('n', '<leader>li', '<cmd>:LspInfo<CR>')
map('n', '<leader>n', '<cmd>:NullLsInfo<CR>')

-- Help
map('n', '<leader>hh', '<cmd>:Help<CR>')
map('n', '<leader>hw', '<cmd>:HelpWord<CR>')
map('n', '<leader>hg', '<cmd>:HelpGrep<CR>')

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
map('n', '<leader>s', fn.substitute_word_under_cursor)
map('n', '<leader>si', fn.substitute_word_under_cursor_insensitive)


-- Remap write to buffer
map('i', '<c-s>', '<C-O>:update<CR>')

-- Remap half-page up/down
map('n', '<c-u>', '<c-u>zz')
map('n', '<c-d>', '<c-d>zz')

-- Navigate up/down to first non blank character of line
map('i', '<c-k>', '<ESC><Up><ESC>^i')
map('i', '<c-j>', '<ESC><Down><ESC>^i')

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

-- Print highlight group under cursor
map('n',
    '<leader>hi',
    function() local result = vim.treesitter.get_captures_at_cursor(0) print(vim.inspect(result)) end
)
map('n', '<leader>hl', fn.print_hl_under_cursor)

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

map('n', '<space>m', ':TSJToggle<CR>')

-- Gitsigns hunks
map('n', '[h', ':Gitsigns prev_hunk<CR>')
map('n', ']h', ':Gitsigns next_hunk<CR>')
map('n', 'ph', ':Gitsigns preview_hunk<CR>')
map('n', 'vh', ':Gitsigns select_hunk<CR>')
map('n', 'sh', ':Gitsigns stage_hunk<CR>')
map('n', 'rh', ':Gitsigns reset_hunk<CR>')

-- Git diff this file
map('n', '<leader>df', '<cmd>lua require("core.util.diff")()<CR>')

return P
