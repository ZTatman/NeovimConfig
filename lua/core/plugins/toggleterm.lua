local status_ok, toggleterm = pcall(require, "toggleterm")

if not status_ok then
    return
end

toggleterm.setup({
    size = 15,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    -- shading_factor = 1,
    -- highlights = {
    --     Normal = {
    --         guibg = "#1C1E25"
    --     },
    --     NormalFloat = {
    --        guibg = "#1C1E25",
    --     },
    --     FloatBorder = {
    --         guifg = "#1C1E25",
    --         guibg = "#1C1E25"
    --     }
    -- },
    autoScroll = true,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        width = 180,
        height = 30
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

    -- close current terminal
    vim.api.nvim_buf_set_keymap(0, 't', '<C-x>', '<C-c>exit<CR>', opts)
    --  Open a new terminal with an incremented ID, start in insert mode
    vim.api.nvim_buf_set_keymap(0, 't', '<C-n>', '<C-\\><C-n>:lua _OPEN_NEW_TERMINAL()<CR>', opts)
end

--  Open a floating lazygit terminal
vim.keymap.set('n', '<leader>g', '<cmd>TermExec cmd="lazygit" direction=float<CR>', {})

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lg", direction = "float" })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

function _OPEN_NEW_TERMINAL()
    local last_terminal_id = 0
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_option(buffer, 'buftype') == 'terminal' then
            local buffer_id = vim.api.nvim_buf_get_number(buffer)
            if buffer_id > last_terminal_id then
                last_terminal_id = buffer_id
            end
        end
    end
    vim.cmd(last_terminal_id .. 'ToggleTerm start_in_insert=true')
end
