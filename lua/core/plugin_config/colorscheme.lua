local hl = vim.api.nvim_set_hl
local g = vim.g
local o = vim.o

-- o.termguicolors = true
-- g.edge_style = 'default'
-- g.edge_transparent_background = 1
-- g.edge_better_performance = 1
-- vim.cmd [[ colorscheme edge ]]

-- Lua:
-- For dark theme (neovim's default)
o.background = 'dark'
-- For light theme
-- o.background = 'light'

local c = require('vscode.colors').get_colors()

local vsc_status, vscode = pcall(require, "vscode");
vscode.setup({
    -- Alternatively set style in setup
    -- style = 'light'

    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = false,

    -- Override colors (see ./lua/vscode/colors.lua)
    color_overrides = {
        -- vscLineNumber = '#FFFFFF',
    },

    -- Override highlight groups (see ./lua/vscode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        Function = { fg = c.vscYellow, bg = 'NONE', bold = true },
        -- jsVariableDef = { fg = c.vscpink, bg = 'none' },
        -- typescriptVariableDeclaration = { fg = c.vscBlueGreen, bg = 'none' }
    }
})

vscode.load()
