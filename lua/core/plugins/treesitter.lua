require 'nvim-treesitter.configs'.setup {
    textobjects = {
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = {}
    },
    auto_install = true,
    ensure_installed = {
        "tsx",
        "lua",
        "vimdoc",
        "java",
        "json",
        "yaml",
        "html",
        "scss",
        "javascript",
        "typescript",
        "vue",
        "markdown",
        "markdown_inline",
        "norg"
    },
    autotag = {
        enable = true,
    },
    -- incremental_selection = {
    --     enable = true,
    --     keymaps = {
    --         init_selection = "<C-space>",
    --         node_incremental = "<S-space>",
    --         scope_incremental = false,
    --         node_decrimental = "<BS>"
    --     }
    -- }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
