local options = {
    tabstop = 4,
    backspace = { "start", "eol", "indent" },
    fileencodings = { "utf-8", "sjis", "euc-jp", "latin" },
    backupskip = { "/tmp/*", "/private/tmp/*" },
    shiftwidth = 4,
    cmdheight = 2,
    laststatus = 2,
    numberwidth = 4,
    scrolloff = 10,
    sidescrolloff = 10,
    hlsearch = true,
    lazyredraw = true,
    ignorecase = true,
    number = true,
    cursorline = true,
    expandtab = true,
    shiftround = true,
    splitbelow = true,
    splitright = true,
    autoindent = true,
    smartindent = true,
    -- noru = true,
    -- nosm = true,
    undofile = true,
    undodir = "/tmp/.vim-undo-diret",
    background = "dark",
    wrap = false,
    title = true,
    showcmd = true,
    updatetime = 300,
    signcolumn = "yes",
    mouse = "a",
    encoding = "utf8",
    shell = "zsh",
    sessionoptions = "buffers,curdir,folds,help,winsize,winpos,tabpages,terminal",
    pumblend = 15
}


-- Make this dynamic clipboard paste in the future
vim.opt.clipboard:append { "unnamedplus" }
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

--  More options
vim.opt.formatoptions = "r"
vim.opt.path:append { "**" }
vim.opt.wildignore:append { "*/node_modules/*" }
vim.opt.fillchars:append { diff = "╱" }
vim.cmd [[ set nosc noru nosm ]]

-- Set the options in the table above
for k, v in pairs(options) do
    vim.opt[k] = v
end
