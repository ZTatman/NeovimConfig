local status, dap = pcall(require, "dap")
if not status then return end

local u = require("core.util.utils")

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb", -- adjust as needed
    name = "lldb",
}

local lldb = {
    name = "Launch lldb",
    type = "lldb",      -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    program = function()
        return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
        )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
}

dap.configurations.javascript = {
    lldb -- different debuggers or more configurations can be used here
}

u.create_map("n", '<leader>dk', function() require("dap").continue() end)
u.create_map("n", '<leader>dl', function() require("dap").run_last() end)
u.create_map("n", "<leader>b", function() require("dap").toggle_breakpoint() end)
