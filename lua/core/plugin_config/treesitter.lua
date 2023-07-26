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
        "markdown",
        "markdown_inline"
    },
    autotag = {
        enable = true,
    }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
