local opt = vim.opt

local options = {
    autoindent = true,
    background = "dark",
    backspace = { "start", "eol", "indent" },
    backupskip = { "/tmp/*", "/private/tmp/*" },
    cmdheight = 0,
    cursorline = true,
    encoding = "utf8",
    expandtab = true,
    fileencodings = { "utf-8", "sjis", "euc-jp", "latin" },
    hlsearch = true,
    ignorecase = true,
    laststatus = 2,
    lazyredraw = true,
    mouse = "a",
    number = true,
    numberwidth = 4,
    pumblend = 15,
    relativenumber = true,
    scrolloff = 10,
    sessionoptions = "buffers,curdir,folds,help,winsize,winpos,tabpages,terminal",
    shell = "zsh",
    shiftround = true,
    shiftwidth = 4,
    showcmd = true,
    sidescrolloff = 10,
    signcolumn = "yes",
    smartindent = true,
    splitbelow = true,
    splitright = true,
    tabstop = 4,
    title = true,
    undodir = "/tmp/.vim-undo-diret",
    undofile = true,
    updatetime = 300,
    wrap = false,
}


-- Make this dynamic clipboard paste in the future
opt.clipboard:append { "unnamedplus" }
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

--  More options
opt.fillchars:append { diff = "╱" }
opt.formatoptions = "r"
opt.path:append { "**" }
opt.shortmess:append("F")
opt.wildignore:append { "*/node_modules/*" }
vim.cmd [[ set nosc noru nosm ]]

-- Set the options in the table above
for k, v in pairs(options) do
    opt[k] = v
end
