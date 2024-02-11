local u = require("core.util.utils")
require("core.keymaps")
local lspconfig = require("lspconfig")

-- Quickfix code_action
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a)
            return a.isPreferred
        end,
        apply = true,
    })
end
local opts = { noremap = true, silent = true }
u.create_map("n", "<leader>qf", quickfix, opts)

-- On attach function
local on_attach = function(client, bufnr)
    if client.name == "tailwindcss" then
        client.server_capabilities.documentFormattingProvider = false
    else
        client.server_capabilities.documentFormattingProvider = true
    end
    map_lsp_keys(bufnr)
end

-- Lspconfig capabilities
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities(client_capabilities)

-- Eslint
lspconfig.eslint.setup({
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
    capabilities = capabilities,
    settings = {
        nodePath = os.getenv("ESLINT_PATH"),
        options = {
            overrideConfigFile = os.getenv("ESLINT_CHARTER_CONFIG"),
        },
    },
})

-- Typescript
lspconfig.tsserver.setup({
    on_attach = on_attach,
    filetypes = { "javascript", "typescript", "typescript.tsx", "typescriptreact" },
    capabilities = capabilities,
})

-- Tailwindcss
lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.marksman.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- -- Java
-- lspconfig.jdtls.setup {
--   on_attach = function() end,
--   capabilities = capabilities
-- }

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
    { name = "DiagnosticSignHint", text = "⚡️" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
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
        source = "always",
        header = "",
        prefix = "",
    },
})
