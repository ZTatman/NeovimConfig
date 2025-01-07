local fn, api = vim.fn, vim.api

local U = {}

U.create_cmd = function(command, f, opts)
	opts = opts or {}
	api.nvim_create_user_command(command, f, opts)
end

U.create_map = function(mode, key, result, opts)
	vim.keymap.set(mode, key, result, opts)
end

U.current_word = function()
	local current_word = fn.expand("<cword>")
	return current_word
end

-- SOURCE: mcauley-penney - https://github.com/mcauley-penney/nvim/blob/d77644e1a79d5f53f00696f8b461ab8225e2732b/lua/globals.lua#L93
---Get a hl group's rgb
---Note: Always gets linked colors
---@param opts table
---@param ns_id integer?
---@return table
U.get_hl_hex = function(opts, ns_id)
	opts, ns_id = opts or {}, ns_id or 0
	assert(opts.name or opts.id, "Error: must have hl group name or ID!")
	opts.link = true

	local hl = vim.api.nvim_get_hl(ns_id, opts)

	return {
		fg = hl.fg and ("#%06x"):format(hl.fg),
		bg = hl.bg and ("#%06x"):format(hl.bg),
	}
end

return U
