local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

autopairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    enable_check_bracket_line = false, --if next character is a close pair and it doesn't have an open pair in same line, then it will not add a close pair
    ignored_next_char = "[%w%.]",    -- will ignore alphanumeric and `.` symbol
    fast_wrap = {},
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

npairs.add_rule(Rule("$","$",{"tex", "markdown"}))
npairs.add_rule(Rule("**","**", "markdown"))
npairs.add_rule(Rule("_","_", "markdown"))
