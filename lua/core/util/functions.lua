-- Credit for inspiration: Catgoose @ https://github.com/catgoose/nvim/blob/main/lua/util/functions.lua
local cmd, api, ui, fn = vim.cmd, vim.api, vim.ui, vim.fn
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
	ui.input({ prompt = "Open help for: " }, function(input)
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

-- Function to dump a table to output
M.dump = function(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

-- Function to format a table for output
M.dump_formatted = function(o, indent)
	if type(o) == "table" then
		local s = "{\n"
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. indent .. "[" .. k .. "] = " .. M.dumpFormatted(v, indent .. "  ") .. ",\n"
		end
		return s .. indent .. "}"
	else
		return tostring(o)
	end
end

-- Function to dump a table to a file with formatted output
M.dump_to_file = function(o, filename, indent)
	indent = indent or "  "
	local file = io.open(filename, "w")
	if file then
		local output = M.dump_formatted(o, indent)
		file:write(output)
		file:close()
		print("Table dumped to file: " .. filename)
	else
		print("Error: Unable to open file " .. filename)
	end
end

M.print_hl_under_cursor = function()
	if not fn.exists("*synstack") then
		return
	end
	local syn_stack = fn.synstack(fn.line("."), fn.col("."))
	local names = {}
	for _, id in ipairs(syn_stack) do
		table.insert(names, fn.synIDattr(id, "name"))
	end
	print(table.concat(names, " -> "))
end

M.substitute_word_under_cursor = function()
	local current_word = u.current_word()
	ui.input({ prompt = "Substitute '" .. current_word .. "' with: " }, function(input)
		if not input then
			return
		end
		cmd("%s/\\<" .. current_word .. "\\>/" .. input .. "/gc")
	end)
	cmd("nohlsearch")
end

M.substitute_word_under_cursor_insensitive = function()
	local current_word = u.current_word()
	ui.input({ prompt = "Substitute '" .. current_word .. "' with: " }, function(input)
		if not input then
			return
		end
		cmd("%s/\\<" .. current_word .. "\\>/" .. input .. "/gci")
	end)
	cmd("nohlsearch")
end

return M
