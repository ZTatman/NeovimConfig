local o, api = vim.o, vim.api
local fn = require("core.util.functions")
local create_cmd = require("core.util.utils").create_cmd

create_cmd("UpdateAndSyncAll", fn.update_all)
create_cmd("Help", fn.help_select)
create_cmd("HelpWord", fn.help_word)
create_cmd("HelpGrep", fn.help_grep)

-- fix conceallevel for json files
api.nvim_create_autocmd("Filetype", {
    pattern = {"json", "jsonc"},
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

-- o.autoread = true
-- api.nvim_create_autocmd(
--     { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
--         command = "if mode() != 'c' | checktime | endif",
--         pattern = { "*" },
--     })
