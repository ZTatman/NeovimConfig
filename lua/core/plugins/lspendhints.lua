local status, lspendhints = pcall(require, "nvim-lsp-endhints")
if not status then
	return
end

-- default settings
lspendhints.setup({
	icons = {
		type = "󰊄 ",
		parameter = "󰏪 ",
	},
	label = {
		padding = 1,
		marginLeft = 0,
		bracketedParameters = true,
	},
	autoEnableHints = true,
})
