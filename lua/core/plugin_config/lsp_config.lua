-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "eslint", "tsserver", "html", "cssmodules_ls", "jdtls" }
})

-- Navic
local navic = require("nvim-navic")

-- Lspconfig capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Highlight under cursor
local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- Quickfix code_action
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

-- Keymaps
local opts = { noremap=true, silent=true }
vim.keymap.set("n", "<leader>qf", quickfix, opts)
local function lsp_keymaps(bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>do', "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "H", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float()<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>d", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

-- On attach function
local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

-- LSP server setups
require("lspconfig").eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function() return vim.loop.cwd() end,
  settings = {
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
    nodePath = "~/Users/P3062728/Projects/Charter/mui/charter-mui-platform",
    options = {
      overrideConfigFile = "~/Users/P3062728/Projects/Charter/mui/charter-mui-platform/eslint/config.json"
    },
  }
}
require("lspconfig").tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require("lspconfig").html.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require("lspconfig").cssmodules_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require("lspconfig").jdtls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require("lspconfig").lua_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- Diagnostics
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
  { name = "DiagnosticSignHint", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  -- disable virtual text
  virtual_text = true,
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
