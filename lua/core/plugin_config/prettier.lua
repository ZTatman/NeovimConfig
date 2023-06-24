local status, prettier = pcall(require, "prettier")
if (not status) then
    return
end

prettier.setup {
    bin = 'prettier',
    filetypes = {
        "typescript",
        "typescriptreact",
    },
    cli_options = {
        -- arrow_parens = "always",
        -- bracket_spacing = true,
        -- bracket_same_line = false,
        -- embedded_language_formatting = "auto",
        -- end_of_line = "lf",
        -- html_whitespace_sensitivity = "css",
        -- -- jsx_bracket_same_line = false,
        -- jsx_single_quote = false,
        -- print_width = 100,
        -- prose_wrap = "preserve",
        -- quote_props = "as-needed",
        -- semi = true,
        -- single_attribute_per_line = false,
        -- single_quote = false,
        tab_width = 4,
        -- trailing_comma = "es5",
        use_tabs = false,
        -- vue_indent_script_and_style = false,
    },
}
