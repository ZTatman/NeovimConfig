-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "emmet_ls", "eslint", "tsserver", "jdtls", "tailwindcss" }
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

-- Required modules
local navic = require("nvim-navic")
local null_ls = require("null-ls")
local lspconfig = require("lspconfig")

--  Eslint configs
local eslint_node_path = os.getenv("ESLINT_PATH")
local eslint_config_path = os.getenv("ESLINT_CHARTER_CONFIG")

-- hover sources
-- local hover = null_ls.builtins.hover

-- Null-ls
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local eslint_d_args = {
  "--config", "./.eslintrc.json",
  "--eslint-path", vim.fn.expand(eslint_node_path)
}

local custom_conditions = {
  get_eslintd_args = function()
    local filetypes = { "javascript", "javascriptreact", "javascript.jsx"}
    local current_filetype = vim.bo.filetype
    for _, ft in ipairs(filetypes) do
      if current_filetype == ft then
        return eslint_d_args
      end
    end
    return {}
  end
}

null_ls.setup({
  debug = true,
  sources = {
    -- Eslint_d
    diagnostics.eslint_d.with({
      extra_args = custom_conditions.get_eslintd_args,
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescript.tsx", "typescriptreact"},
    }),
    formatting.eslint_d.with({
      extra_args = eslint_d_args,
      filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
    }),
    code_actions.eslint_d.with({
      extra_args = eslint_d_args,
      filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
    }),
    --  tsserver
    -- Prettier
    formatting.prettier.with({
      filetypes = { "typescript", "typescript.tsx", "typescriptreact" },
    }),
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

-- Keymaps (Lspsaga)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

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
-- lspconfig.eslint.setup {
--   on_attach = on_attach,
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
--   capabilities = capabilities,
--   -- root_dir = function() return vim.loop.cwd() end,
--   -- settings = {
--   --   nodePath = eslint_config_path,
--   --   options = {
--   --     overrideConfigFile = "/Users/P3062728/Projects/Charter/mui/charter-mui-platform/eslint/config.json"
--   --   },
--   -- }
-- }

-- Typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescript.tsx", "typescriptreact" },
  capabilities = capabilities
}

-- Tailwindcss
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescript.tsx", "typescriptreact" },
  capabilities = capabilities
}

-- Java
-- lspconfig.jdtls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }

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
