local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
  enable_check_bracket_line = false, --if next character is a close pair and it doesn't have an open pair in same line, then it will not add a close pair
  ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  fast_wrap = {},
})
