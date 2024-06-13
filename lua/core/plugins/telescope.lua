local tel_status, telescope = pcall(require, "telescope")
local a_status, actions = pcall(require, "telescope.actions")

local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local u = require("core.util.utils")

if (not tel_status) then return end
if (not a_status) then return end

-- Keymaps
local opts = { noremap = true, silent = true }
u.create_map('n', ';f',
    "<cmd>lua require('telescope.builtin').find_files({layout_strategy='bottom_pane', layout_config={width=0.45}})<cr>",
    opts)
u.create_map('n', ';r',
    "<cmd>lua require('telescope.builtin').live_grep({layout_strategy='bottom_pane', layout_config={width=0.45}})<cr>",
    opts)
u.create_map('n', ';rc',
    "<cmd>lua require('telescope.builtin').grep_string({layout_strategy='bottom_pane', layout_config={width=0.45}})<cr>",
    opts)
u.create_map('n', ';pf',
    "<cmd>lua require('telescope.builtin').oldfiles({layout_strategy='bottom_pane', layout_config={height=0.45}})<cr>",
    opts)
u.create_map('n', ';ps',
    "<cmd>lua require('telescope.builtin').search_history({layout_strategy='bottom_pane', layout_config={height=0.25}})<cr>",
    opts)
u.create_map('n', ';k',
    "<cmd>lua require('telescope.builtin').keymaps({layout_strategy='bottom_pane', layout_config={height=0.25}})<cr>",
    opts)
u.create_map('n', ';s',
    "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({layout_strategy='bottom_pane', layout_config={height=0.25}})<cr>",
    opts)
u.create_map('n', ';b', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
u.create_map('n', ';;', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
u.create_map('n', ';g',
    "<cmd>lua require('telescope.builtin').git_status({layout_strategy='bottom_pane', layout_config={width=0.45}})<cr>")

-- Lua functions
local telescope_buffer_dir = function()
    return vim.fn.expand('%:p:h')
end

-- Telescope setup
telescope.setup({
    defaults = {
        path_to_display = { "smart" },
        mappings = {
            n = {
                ["q"] = actions.close,
                ["<C-s>"] = actions.select_vertical,
                ["<C-x>"] = open_with_trouble
            },
            i = {
                ["Q"] = actions.close,
                ["<C-s>"] = actions.select_vertical,
                ['<C-l>'] = actions.cycle_history_next,
                ['<C-h>'] = actions.cycle_history_prev,
                ["<C-x>"] = open_with_trouble
            },
        },
        layout_config = {
            -- other layout configuration here
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        workspaces = {
            -- keep insert mode after selection in the picker, default is false
            keep_insert = true,
        }
    }
})

local extensions = {
    "fzf",
    "workspaces",
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
for e in ipairs(extensions) do
    telescope.load_extension(extensions[e])
end
