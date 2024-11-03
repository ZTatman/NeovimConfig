require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "cssls",
        "cssmodules_ls",
        "emmet_ls",
        "eslint",
        "gopls"
        "html",
        "jdtls",
        "lua_ls",
        "marksman",
        "tailwindcss",
        "ts_ls",
        "typos-lsp"
    },
})
