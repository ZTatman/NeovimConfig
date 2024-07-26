local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	return
end

function BRANCH_FORMATTER(branch_name)
	local prefix = string.match(branch_name, "^(.-)/AOSDEV")
	if not prefix then
		return branch_name
	end
	local suffix = string.match(branch_name, "^.-/AOSDEV%-(%d*)")
	if not suffix then
		return prefix
	end
	return prefix .. "/AOSDEV-" .. suffix
end

local function get_project_name()
	local cwd = vim.fn.getcwd()
	local project_name = cwd:match("([^/]+)$")
	return project_name
end

local lazy_status = require("lazy.status")

function get_lazy_updates()
	return lazy_status.updates() .. "+"
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "kanagawa",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "NvimTree", "Outline", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				get_project_name,
				icon = { "", align = "left" },
			},
			{
				"branch",
				fmt = BRANCH_FORMATTER,
			},
		},
		lualine_c = {},
		lualine_x = {
			{
				get_lazy_updates,
				cond = lazy_status.has_updates,
				color = { fg = "#E6C384" },
			},
			{
				"searchcount",
				maxcount = 1999,
				timeout = 500,
				icon = { " ", align = "right" },
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = "󱗞 " },
				padding = { left = 1, right = 2 },
			},
		},
		lualine_y = {
			{ "filename", padding = { left = 1, right = 1 } },
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 2 } },
		},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "fugitive" },
})
