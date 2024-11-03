local status, lint = pcall(require, "lint")

if not status then
    return
end

lint.linters_by_ft = {
    go = { "golangcilint" },
    -- javascript = { "eslint_d" },
    -- typescript = { "eslint_d" },
    -- vue = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
end, { desc = "Trigger linting for current file" })
