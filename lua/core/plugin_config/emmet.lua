local cmd = vim.cmd

vim.g.user_emmet_install_global = 0
vim.g.user_emmet_leader_key = ","

cmd [[ autocmd FileType html,css,javascript,javascriptreact,*.tsx,*.jsx EmmetInstall ]]
