local status, vscode = pcall(require, "vscode")
if(not status) then return end


local c = require('vscode.colors').get_colors()

vscode.setup({
    style = "dark",
    transparent = true,
})
