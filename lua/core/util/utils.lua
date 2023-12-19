-- Credit: Catgoose @ https://github.com/catgoose/nvim/blob/main/lua/util/utils.lua
local fn, cmd, api, o, g, ui = vim.fn, vim.cmd, vim.api, vim.o, vim.g, vim.ui

local M = {}

M.create_cmd = function(command, f, opts)
    opts = opts or {}
    api.nvim_create_user_command(command, f, opts)
end

M.create_map = function(mode, key, result, opts)
    vim.keymap.set(mode, key, result, opts)
end


M.current_word = function()
    local current_word = fn.expand("<cword>")
    return current_word
end

return M
