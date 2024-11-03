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
        "lua_ls",
        "emmet_ls",
        "html",
        "eslint",
        "ts_ls",
        "jdtls",
        "tailwindcss",
        "cssls",
        "cssmodules_ls",
        "marksman",
        "gopls"
    },
})
