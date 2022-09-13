" Keymaps

" Map undo \"u" to CTRL+Z
nnoremap <C-z> u
nnoremap <S-z> <C-R>
inoremap <C-z> <C-O>u
inoremap <S-z> <C-O><C-R>

" Exit insert mode
inoremap <C-Space> <Esc>

" Write to buffer
inoremap <C-s> <C-O>:update<CR>

" FZF fuzzy search
nnoremap <silent> <C-_> :Files<CR>
nnoremap <silent> <C-r> :Rg<CR>

" Toggle Nvim Tree
map <C-b> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFindFile<CR>

" Open DiffView
map <leader>do <nowait> <Cmd>DiffviewOpen<CR> 
map <leader>dc <nowait> <Cmd>DiffviewClose<CR>
map <leader>dr <nowait> <Cmd>DiffviewRefresh<CR>
map <leader>dt <nowait> <Cmd>DiffviewToggleFiles<CR>

" Exit Terminal Mode
tnoremap <Esc> <C-\><C-n>

" Increase window height by a factor of 1.5 and decrease the window size by 0.67
" nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> <Leader>- :exe \"resize " . (winheight(0) * 2/3)<CR>

" increase the window size by a factor of 1.5 and decrease the window size by 0.67
nnoremap <Leader>+ :exe "resize " . (winwidth(0) * 3/2)<CR>
nnoremap <Leader>- :exe "resize " . (winwidth(0) * 2/3)<CR>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiffsplit!<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
