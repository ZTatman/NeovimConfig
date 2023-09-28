-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

local DEFAULT_WIDTH = 25;

nvimtree.setup({
    on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- options
        local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- custom mappings
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end,
    auto_reload_on_write = true,
    update_focused_file = {
        enable = true
    },
    sort_by = "name",
    filters = {
        custom = {
            ".git"
        }
    },
    renderer = {
        highlight_opened_files = "name",
    },
    view = {
        side = "left",
        adaptive_size = true,
        centralize_selection = true,
        width = DEFAULT_WIDTH
    }
})
