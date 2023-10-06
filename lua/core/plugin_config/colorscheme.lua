local hl = vim.api.nvim_set_hl
local g = vim.g
local o = vim.o

-- vim.cmd [[colorscheme zephyr]]

-- Edge
-- o.termguicolors = true
-- g.edge_style = 'default'
-- g.edge_transparent_background = 1
-- g.edge_better_performance = 1
-- vim.cmd [[ colorscheme edge ]]

-- Vscode
-- For dark theme (neovim's default)
-- o.background = 'dark'
-- For light theme
-- o.background = 'light'
-- local c = require('vscode.colors').get_colors()
-- local vsc_status, vscode = pcall(require, "vscode");
-- vscode.setup({
--     -- Alternatively set style in setup
--     -- style = 'light'

--     -- Enable transparent background
--     transparent = true,

--     -- Enable italic comment
--     italic_comments = true,

--     -- Disable nvim-tree background color
--     disable_nvimtree_bg = false,

--     -- Override colors (see ./lua/vscode/colors.lua)
--     color_overrides = {
--         -- vscLineNumber = '#FFFFFF',
--     },

--     -- Override highlight groups (see ./lua/vscode/theme.lua)
--     group_overrides = {
--         -- this supports the same val table as vim.api.nvim_set_hl
--         -- use colors from this colorscheme by requiring vscode.colors!
--         Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
--         Function = { fg = c.vscYellow, bg = 'NONE', bold = true },
--         -- jsVariableDef = { fg = c.vscpink, bg = 'none' },
--         -- typescriptVariableDeclaration = { fg = c.vscBlueGreen, bg = 'none' }
--     }
-- })
-- vscode.load()

-- Kanagawa
local overrides = function(colors)
    local p = colors.palette
    -- local t = colors.theme
    return {
        CursorLine = {
            bold = true,
            italic = true,
            bg = p.sumiInk5,
        },
        Visual = {
            bold = true,
        },
        TreesitterContextBottom = {
            link = "Visual",
        },
        IlluminatedCurWord = {
            italic = false,
        },
        IlluminatedWordText = {
            link = "CursorLine",
            italic = true,
        },
        IlluminatedWordRead = {
            link = "CursorLine",
            italic = true,
        },
        IlluminatedWordWrite = {
            link = "CursorLine",
            italic = true,
        },
        Folded = {
            bg = p.sumiInk3,
        },
        StatusColumnFoldClosed = {
            fg = p.springViolet1,
            bold = false,
        },
        DashboardHeader = {
            fg = p.peachRed,
            bg = p.sumiInk3,
        },
        DashboardIcon = {
            fg = p.springBlue,
            bg = p.sumiInk3,
        },
        DashboardDesc = {
            fg = p.fujiWhite,
            bg = p.sumiInk3,
            italic = true,
        },
        DashboardKey = {
            fg = p.lightBlue,
            bg = p.sumiInk3,
            bold = true,
        },
        Pmenu = {
            fg = p.fujiWhite,
            bg = p.waveBlue1,
        },
        PmenuSel = {
            fg = p.waveBlue1,
            bg = p.springViolet2,
            bold = true,
        },
        UfoFoldedBg = {
            bg = p.waveBlue1,
            bold = true,
        },
        Constant = {
            fg = p.waveRed,
            bg = p.sumiInk3
        }
    }
end

require("kanagawa").setup({
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = true,
    terminalColors = true,
    colors = {
        palette = {},
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    bg_gutter = "none",
                },
            },
        },
    },
    overrides = overrides,
})
vim.cmd.colorscheme("kanagawa-wave")
