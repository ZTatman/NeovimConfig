local status, indent = pcall(require, "ibl")
if (not status) then return end

vim.opt.list = true
vim.opt.listchars:append "space: "
vim.opt.listchars:append "eol: "

vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowTeal", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowPurple", { fg = "#C586C0" })

indent.setup({
    scope = {
        highlight = {
            "RainbowRed"
        },
    },
    exclude = {
        filetypes = {
            "help",
            "NvimTree",
            "dashboard",
            "markdown",
            "markdown-inline",
            "telescope",
            "telescope_prompt"
        }
    }
})

local hooks = require "ibl.hooks"
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)
