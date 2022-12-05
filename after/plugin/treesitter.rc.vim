if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
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
    "java",
    "json",
    "yaml",
    "html",
    "scss",
    "javascript",
    "typescript"
  },
  autotag = {
    enable = true,
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
EOF
