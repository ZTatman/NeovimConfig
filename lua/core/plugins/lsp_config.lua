local fn = vim.fn
local u = require("core.util.utils")
local k = require("core.keymaps")
local lspconfig = require("lspconfig")

-- Quickfix code_action
function quickfix()
	vim.lsp.buf.code_action({
		filter = function(a)
			return a.isPreferred
		end,
		apply = true,
	})
end

function on_attach(client, bufnr)
	if client.name == "tailwindcss" then
		client.server_capabilities.documentFormattingProvider = false
	else
		client.server_capabilities.documentFormattingProvider = true
	end
	k.map_lsp_keys(bufnr)
end

local opts = { noremap = true, silent = true }
u.create_map("n", "<leader>qf", quickfix, opts)

-- Lspconfig capabilities
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)

-- Eslint
lspconfig.eslint.setup({
	on_attach = on_attach,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
	capabilities = capabilities,
	settings = {
		experimental = {
			useFlatConfig = false,
		},
		nodePath = os.getenv("ESLINT_PATH"),
		options = {
			overrideConfigFile = os.getenv("ESLINT_CHARTER_CONFIG"),
		},
	},
})

-- Typescript
lspconfig.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact" },
	capabilities = capabilities,
})

-- Tailwindcss
lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- Vue
lspconfig.volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "javascript", "vue" },
})

-- Markdown
lspconfig.marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- -- Java
lspconfig.jdtls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- HTML
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "vue" },
})

-- CSS
lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "javascript", "css", "scss", "less", "sass" },
})

-- CSS Modules
lspconfig.cssmodules_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "css", "scss", "less", "sass", "vue" },
})

-- Emmet
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

--  Lua
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "require" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
			hint = {
				enable = true,
			},
		},
	},
})

-- Diagnostics
local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignInfo", text = "󰋼" },
	{ name = "DiagnosticSignHint", text = "󱗞" },
}

for _, sign in ipairs(signs) do
	fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})
