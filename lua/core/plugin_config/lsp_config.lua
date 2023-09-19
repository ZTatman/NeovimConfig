-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "emmet_ls", "eslint", "tsserver", "jdtls", "tailwindcss", "cssls" }
})

-- Lspsaga
require("lspsaga").setup({
    symbol_in_winbar = {
        folder_level = 0,
    },
    diagnostic = {
        max_height = 0.8,
        extend_relatedInformation = true,
        keys = {
            quit = { 'q', '<ESC>' }
        }
    },
})

-- Required modules
-- local navic = require("nvim-navic")
-- local null_ls = require("null-ls")
local lspconfig = require("lspconfig")

--  Eslint configs
-- local eslint_node_path = os.getenv("ESLINT_PATH")
-- local eslint_config_path = os.getenv("ESLINT_CHARTER_CONFIG")

-- Null-ls
-- local code_actions = null_ls.builtins.code_actions
-- local diagnostics = null_ls.builtins.diagnostics
-- local formatting = null_ls.builtins.formatting
-- local hover = null_ls.builtins.hover
-- local eslint_d_args = {
--     "--config", eslint_config_path,
-- }

-- local get_eslintd_args = function()
--     local filetypes = { "javascript", "javascriptreact", "javascript.jsx" }
--     local current_filetype = vim.bo.filetype
--     for _, ft in ipairs(filetypes) do
--         if current_filetype == ft then
--             print(eslint_d_args)
--             return eslint_d_args
--         end
--     end
--     return {}
-- end

-- null_ls.setup({
--     debug = true,
--     sources = {
--         -- Eslint_d
--         diagnostics.eslint_d.with({
--           extra_args = eslint_d_args,
--           filetypes = { "javascript", "javascriptreact", "javascript.jsx"},
--         }),
--         formatting.eslint_d.with({
--           extra_args = eslint_d_args,
--           filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
--         }),
--         code_actions.eslint_d.with({
--           extra_args = eslint_d_args,
--           filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
--         }),
--         -- Prettier
--         formatting.prettier.with({
--             filetypes = { "typescript", "typescript.tsx", "typescriptreact", "css" },
--         }),
--     }
-- })

-- Quickfix code_action
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a)
            return a.isPreferred
        end,
        apply = true
    })
end

-- Keymaps (Lspsaga)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>qf", quickfix, opts)

local function lsp_keymaps()
    map('n', "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    map("n", "gi", "<cmd>Lspsaga finder imp<CR>", opts)
    map("n", "gr", "<cmd>Lspsaga finder ref<CR>", opts)
    map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
    map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
    map("n", "<space>f", "<cmd>Lspsaga finder<CR>", opts)

    map("n", "H", "<cmd>Lspsaga hover_doc<CR>", opts)
    map("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    map("n", "rn", "<cmd>Lspsaga rename<CR>", opts)
    map("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
    -- map(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    map("n", "<space>d", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
    map("n", "<space>D", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
    vim.cmd [[ command! Format execute "lua vim.lsp.buf.format({ async = true })" ]]
end

-- On attach function
local on_attach = function(client, bufnr)
    if client.name == "tailwindcss" or client.name == "emmet_ls" then
        client.server_capabilities.documentFormattingProvider = false
    else
        client.server_capabilities.documentFormattingProvider = true
    end
    lsp_keymaps(bufnr)
end

-- Lspconfig capabilities
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)

-- Eslint
lspconfig.eslint.setup {
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
    capabilities = capabilities,
    settings = {
        nodePath = "/Users/P3062728/Projects/Charter/mui/charter-mui-platform/node_modules",
        options = {
            overrideConfigFile = "/Users/P3062728/Projects/Charter/mui/charter-mui-platform/eslint/config.json",
        },
    }
}

-- Typescript
lspconfig.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "javascript", "typescript", "typescript.tsx", "typescriptreact" },
    capabilities = capabilities
}

-- Tailwindcss
lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Java
lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Emmet
lspconfig.emmet_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

--  Lua
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Diagnostics
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
    { name = "DiagnosticSignHint",  text = "⚡️" },
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
