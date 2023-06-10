-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "eslint", "tsserver", "jdtls", "tailwindcss" }
})
require("lspsaga").setup({
  code_action = {
    num_shortcut = true,
    show_server_name = true,
    extend_gitsigns = true,
    keys = {
      -- string | table type
      quit = "q",
      exec = "<CR>",
    },
  },
})

-- External Modules
local navic = require("nvim-navic")
local null_ls = require("null-ls")

--  Eslint config path
local eslint_config_path = os.getenv("ESLINT_CHARTER_CONFIG")

-- hover sources
-- local hover = null_ls.builtins.hover

-- local function eslint_d_diagnostics()
--   if (eslint_config_path) then
--     return diagnostics.eslint_d.with({
--       extra_args =  {"--config", eslint_config_path}
--     })
--   else
--     return diagnostics.eslint_d
--   end
-- end

-- Null-ls
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
null_ls.setup({
  debug = true,
  sources = {
    diagnostics.eslint_d.with({
      extra_args = { "--config", ".eslintrc.json" }
    }),
    formatting.eslint_d.with({
      extra_args = { "--config", ".eslintrc.json" }
    }),
    formatting.prettier,
    code_actions.eslint_d,
  }
})

-- Lspconfig capabilities
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)

-- Quickfix code_action
local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a)
      print(a.isPreferred)
      return a.isPreferred
    end,
    apply = true
  })
end
local opts = { noremap = true, silent = true }

-- Keymaps (Lspsaga)
local map = vim.keymap.set
vim.keymap.set("n", "<leader>qf", quickfix, opts)
local function lsp_keymaps()
  map('n', "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
  map("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
  map("n", "<space>f", "<cmd>Lspsaga lsp_finder<CR>", opts)

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
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- client.server_capabilities.documentFormattingProvider = true
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  lsp_keymaps(bufnr)
end

-- Eslint
require("lspconfig").eslint.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
  capabilities = capabilities,
  root_dir = function() return vim.loop.cwd() end,
  settings = {
    nodePath = eslint_config_path,
    options = {
      overrideConfigFile = "/Users/P3062728/Projects/Charter/mui/charter-mui-platform/eslint/config.json"
    },
  }
}

-- Typescript
require("lspconfig").tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescript.tsx", "typescriptreact" },
  capabilities = capabilities
}

-- Tailwindcss
require("lspconfig").tailwindcss.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescript.tsx", "typescriptreact" },
  capabilities = capabilities
}

-- Java
-- require("lspconfig").jdtls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }

--  Lua
require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Diagnostics
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn",  text = "" },
  { name = "DiagnosticSignInfo",  text = "" },
  { name = "DiagnosticSignHint",  text = "" },
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
