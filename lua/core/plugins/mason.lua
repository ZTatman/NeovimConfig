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
        "tsserver",
        "jdtls",
        "tailwindcss",
        "cssls",
        "cssmodules_ls",
        "marksman",
    },
})
