local fn = require("core.util.functions")
local create_cmd = require("core.util.utils").create_cmd

create_cmd("UpdateAndSyncAll", fn.update_all)

create_cmd("Help", fn.help_select)
create_cmd("HelpWord", fn.help_word)
create_cmd("HelpGrep", fn.help_grep)
