local status, navic = pcall(require, "nvim-navic")
if (not status) then return end

-- NOTE: You can set vim.b.navic_lazy_update_context = true for specific buffers,
-- where you want the the updates to not occur on every CursorMoved event.
-- It should help if you are facing performance issues in large files.
-- Read the docs for example usage of this variable.
vim.b.navic_lazy_update_context = true

navic.setup {
    icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘 ",
        Interface     = "󰕘 ",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = "󰀬  ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪  ",
        Object        = "󰅩  ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
    },
    lsp = {
        auto_attach = false,
        preference = { "eslint_d", "tsserver" },
    },
    highlight = true,
    separator = " -> ",
    depth_limit = 4,
    depth_limit_indicator = "...",
    safe_output = true,
    click = true
}
