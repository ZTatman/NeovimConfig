" Keymaps

" Maps undo to CTRL+Z
nnoremap <C-z> u
nnoremap <S-z> <C-R>
inoremap <C-z> <C-O>u
inoremap <S-z> <C-O><C-R>

" Toggle Nerd Tree
map <C-b> :NERDTreeToggle<CR>


" Exit insert mode
inoremap <C-Space> <Esc>

" Write to buffer
inoremap <C-s> <C-O>:update<CR>

" comment out line based on file type
" autocmd Filetype vim nnoremap <buffer> <C-C> ^i"<Space><Esc>$
" autocmd FileType vim inoremap <buffer> <C-C> <Esc>^i"<space><Esc>$a
" autocmd FileType typescript inoremap <buffer> <C-C> <Esc>^i//<space><Esc>$a 
" autocmd FileType javascript inoremap <buffer> <C-C> <Esc>^i//<space><Esc>$a
" inoremap <buffer> <C-_> <Esc>^dw$
" nnoremap <buffer> <C-_> ^dw$

" FZF fuzzy search
nnoremap <silent> <C-_> :Files<CR>
nnoremap <silent> <C-c> :Rg<CR>

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Toggle Nerd Tree
map <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Open DiffView
map <leader>do <buffer><nowait> :DiffviewOpen><CR> 
map <leader>dc <buffer><nowait> :DiffviewClose><CR>
map <leader>dr <buffer><nowait> :DiffviewRefresh><CR>
map <leader>dt <buffer><nowait> :DiffviewToggleFiles<CR>
" Exit Terminal Mode
tnoremap <Esc> <C-\><C-n>
