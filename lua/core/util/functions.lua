-- Credit: Catgoose @ https://github.com/catgoose/nvim/blob/main/lua/util/functions.lua
local fn, cmd, api, o, g, ui = vim.fn, vim.cmd, vim.api, vim.o, vim.g, vim.ui
local u = require("core.util.utils")

local M = {}

M.update_all = function()
    local cmds = {
        "MasonUpdate",
        "TSUpdate",
        "Lazy sync",
    }
    for _, c in ipairs(cmds) do
        print("Running: " .. c)
        cmd(c)
    end
end

local open_help_tab = function(help_cmd, topic)
    cmd.tabe()
    local winnr = api.nvim_get_current_win()
    cmd("silent! " .. help_cmd .. " " .. topic)
    api.nvim_win_close(winnr, false)
end

M.help_select = function()
    ui.input({ prompt = "Open help for> " }, function(input)
        if not input then
            return
        end
        open_help_tab("help", input)
    end)
end

M.help_word = function()
    local current_word = u.current_word()
    open_help_tab("help", current_word)
end

M.help_grep = function()
    ui.input({ prompt = "Grep help for: " }, function(input)
        if input == "" or not input then
            return
        end
        open_help_tab("helpgrep", input)
        require("trouble").open("quickfix")
    end)
end

return M
