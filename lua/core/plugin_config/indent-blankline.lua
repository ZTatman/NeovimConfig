local status, indent = pcall(require, "indent_blankline")
if (not status) then return end

-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C586C0 gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append "space: "
vim.opt.listchars:append "eol: "

indent.setup({
    space_char_blankline = "",
    show_current_context = true,
    show_current_context_start = true,
    -- char_highlight_list = {
    -- "IndentBlanklineIndent6",
    --     "IndentBlanklineIndent2",
    --     "IndentBlanklineIndent3",
    --     "IndentBlanklineIndent4",
    --     "IndentBlanklineIndent5",
    --     "IndentBlanklineIndent6",
    -- },
    -- show_trailing_blankline_indent = true,
    show_first_indent_level = false,
    -- use_treesitter = true,
    indent_blankline_context_patterns = { 'class', 'function', 'method', '^table', 'arguments' },
    filetype_exclude = {
        "help",
        "lazy",
        "NvimTree",
        "dashboard",
        "markdown",
        "markdown-inline"
    },
})
