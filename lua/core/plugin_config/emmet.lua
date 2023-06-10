local cmd = vim.cmd
local g = vim.g
g.user_emmet_install_global = 0
g.user_emmet_leader_key = ","

cmd [[ autocmd FileType html,css,javascript,javascriptreact,*.tsx,*.jsx EmmetInstall ]]
