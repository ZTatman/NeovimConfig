local o, api = vim.o, vim.api
local fn = require("core.util.functions")
local create_cmd = require("core.util.utils").create_cmd

create_cmd("UpdateAndSyncAll", fn.update_all)
create_cmd("Help", fn.help_select)
create_cmd("HelpWord", fn.help_word)
create_cmd("HelpGrep", fn.help_grep)

-- fix conceallevel for json files
api.nvim_create_autocmd("Filetype", {
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

api.nvim_create_autocmd('CmdlineEnter', {
    group = vim.api.nvim_create_augroup(
        'cmdheight_1_on_cmdlineenter',
        { clear = true }
    ),
    desc = 'Don\'t hide the status line when typing a command',
    command = ':set cmdheight=1',
})

api.nvim_create_autocmd('CmdlineLeave', {
    group = vim.api.nvim_create_augroup(
        'cmdheight_0_on_cmdlineleave',
        { clear = true }
    ),
    desc = 'Hide cmdline when not typing a command',
    command = ':set cmdheight=0',
})

api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup(
        'hide_message_after_write',
        { clear = true }
    ),
    desc = 'Get rid of message after writing a file',
    pattern = { '*' },
    command = 'redrawstatus',
})
