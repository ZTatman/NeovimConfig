local status, whichkey = pcall(require, "which-key")
if (not status) then return end

local setup =  {
    -- your configuration comes here
-- or leave it empty to use the default settings
-- wait>
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
-- the presets plugin, adds help for a bunch of default keybindings in Neovim
-- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
},
timeoutlen=0,
hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
show_help = true, -- show help message on the command line when the popup is visible
triggers = "auto", -- automatically setup triggers
}

local opts = {
mode = "n", -- NORMAL mode
prefix = "<leader>",
buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
silent = true, -- use `silent` when creating keymaps
noremap = true, -- use `noremap` when creating keymaps
nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
d = {
    name = "Diffview",
    o = {"<Cmd>DiffviewOpen<CR>"},
    c = {"<Cmd>DiffviewClose<CR>"},
    r = {"<Cmd>DiffviewRefresh<CR>"},
    t = {"<Cmd>DiffviewToggleFile><CR>"},

    },
    g = {
        name = "Git",
        g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        -- j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        -- k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        -- l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
        -- p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        -- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        -- R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        -- u = {
        --   "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        --   "Undo Stage Hunk",
        -- },
        -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        -- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        -- d = {
        --   "<cmd>Gitsigns diffthis HEAD<cr>",
        --   "Diff",
        -- },
    },
    t = {
    name = "Terminal",
        -- n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        -- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
        -- t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        -- p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },
}
whichkey.setup(setup)
whichkey.register(mappings, opts)
