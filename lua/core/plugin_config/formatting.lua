local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        javascript = { { "eslint", "eslint_d", "prettier" } },
        typescript = { "prettier" },
        javascriptreact = { { "eslint", "eslint_d", "prettier" } },
        typescriptreact = { { "eslint", "eslint_d", "prettier" } },
        vue = { { "eslint", "prettier" } },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
    },
})

local eslint_path = os.getenv("ESLINT_PATH") .. "/.bin/eslint";
-- print("eslint_path: " .. eslint_path)

require("conform").formatters.eslint = {
    prepend_args = { "--fix", "--ext", "--config", os.getenv("ESLINT_CHARTER_CONFIG") },
    command = require("conform.util").find_executable({
        eslint_path,
    }, "eslint"),
    -- The base args are { "-filename", "$FILENAME" } so the final args will be
    -- { "-i", "2", "-filename", "$FILENAME" }
}

vim.keymap.set({ "n", "v" }, "<leader><leader>", function()
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (in visual mode)" })
