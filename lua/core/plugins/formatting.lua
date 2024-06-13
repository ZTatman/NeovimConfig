local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { { "eslint_d" } },
		typescript = {},
		svelte = { "prettier" },
		css = { "prettier" },
		yaml = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
	},
	formatters = {
		eslint_d = {
			prepend_args = { "--config", os.getenv("ESLINT_CHARTER_CONFIG") },
			env = {
				browser = true,
			},
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })
