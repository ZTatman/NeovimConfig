" General Settings {{{
" =======================================================================
" init autocmd
autocmd!

" set script encoding
scriptencoding utf-8

" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
syntax enable
set mouse=a
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab


"let loaded_matchparen = 1

" Shell Setup
" let shell = has('mac') ? '/binzsh' : 'pwsh'
set shell=zsh
" let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
" let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
" let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
" set shellquote= shellxquote=
set backupskip=/tmp/*,/private/tmp/*

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=
set nosc noru nosm

" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch

" How many tenths of a second to blink when matching brackets
"set mat=2

" Ignore case when searching
set ignorecase

" Be smart when using tabs ;)
set smarttab

" indents
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines:
set backspace=start,eol,indent

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Give more space for displaying messages.
set cmdheight=2

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

" Use persistent history.
if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile

" }}}
" COC {{{
" =======================================================================
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
"diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
" else
  set signcolumn=yes
" endif

" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" select the first completion item, confirm the completion when no item has been selected, and format the selection
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
" Use <S-tab> to navigate backwards
inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Use <c-c> to open completion floating window.
if has('nvim')
  inoremap <silent><expr> <c-c> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Install coc-prettier or coc-eslint based on which one is found in
" node_modules
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions = ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions = ['coc-eslint']
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" function! ShowDocIfNoDiagnostic(timer_id)
"   if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
"     silent call CocActionAsync('doHover')
"   endif
" endfunction

" function! s:show_hover_doc()
"   call timer_start(500, 'ShowDocIfNoDiagnostic')
" endfunction

" autocmd CursorHoldI * :call <SID>show_hover_doc()
" autocmd CursorHold * :call <SID>show_hover_doc()

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap keys for apply code actions at the cursor position.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer.
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" List of code action fixes for diagnostic
nmap <leader>do <Plug>(coc-codeaction)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for apply refactor code actions.
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Formatting entire document
xmap <leader>fd <plug>(coc-format-document)
nmap <leader>fd <plug>(coc-format-document)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Show CocList Marketplace extensions
nnoremap <silent><nowait> <space>m :<C-u>CocList marketplace<CR>
" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" }}}
" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif
if has('win32')
  	" let &shell = 'pwsh'
    runtime ./windows.vim
endif
runtime ./maps.vim
"}}}
" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
let g:javascript_plugin_jsdoc = 1
augroup filetypes
    autocmd!
    au BufEnter,BufRead *.{js,jsx,ts,tsx} :syntax sync fromstart
    au BufLeave,BufRead *.{js,jsx,ts,tsx} :syntax sync clear
    " Abbreviations for js development
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> if if(z)<Esc>?z<CR>xi
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> consl console.log(z);<Esc>?z<CR>xi
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> conse console.error(z);<Esc>?z<CR>xi
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> constb console.table(z);<Esc>?z<CR>xi
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> ** /**z */<Esc>?z<CR>xi
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> arrw ()<Space>=><Space>{z}<Esc>?z<CR>xi
    au FileType javascript,javascriptreact,typescriptreact iabbrev <buffer> hook ()<Space>=><Space>{z},<Space>[]<Esc>?z<CR>xi

    " JavasScript
    au BufNewFile,BufRead *es6,*.js,*.mjs setf javascript
    " Javascript React
    au BufNewFile,BufRead *.js setf javascript
    " TypeScript
    au BufNewFile,BufRead *.tsx setf typescriptreact
    " Markdown
    au BufNewFile,BufRead *.md set filetype=markdown
    au BufNewFile,BufRead *.mdx set filetype=markdown
    " Flow
    au BufNewFile,BufRead *.flow set filetype=javascript
    " Fish
    au BufNewFile,BufRead *.fish set filetype=fish

    set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

    au FileType coffee setlocal shiftwidth=2 tabstop=2
    au FileType ruby setlocal shiftwidth=2 tabstop=2
    au FileType yaml setlocal shiftwidth=2 tabstop=2
augroup END
"}}}
" Emmet "{{{
" ---------------------------------------------------------------------
    " Enable just for react, typescriptreact, html, css
    let g:user_emmet_install_global = 0
    autocmd FileType html,css,javascript,javascriptreact,*.tsx,*.jsx EmmetInstall
    " Map leader key to ",,"
    let g:user_emmet_leader_key=','
"}}}
" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
hi Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
hi LineNr cterm=NONE ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  au WinEnter * set cul
  au WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif
"}}}
" Syntax theme "{{{
" ---------------------------------------------------------------------
" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=10
  set wildoptions=pum
  set pumblend=25
  set background=dark
  " augroup scheme
  "       au!
  "       au colorScheme * hi CursorLineNr guifg=#DCA42E
  "       au colorScheme * hi NvimTreeFolderName guifg=#7dcfff
  "       au colorScheme * hi NvimTreeOpenedFolderName guifg=#bb9af7
  "       au colorScheme * hi CocFloating guibg=#191b20 guifg=white
  "       au colorScheme * hi Pmenu guibg=gray guifg=white
  "       " au colorScheme * hi PmenuSel guibg=#22252c guif
  " augroup END
  hi TabLine ctermfg=gray ctermbg=black guifg=#808080 guibg=#282c34
  hi TabLineSel guibg=#DCA42E
  colorscheme onedark
endif

"}}}
" Debugging "{{{
" ---------------------------------------------------------------------
  " vim.lsp.set_log_level("debug")
"}}}
" Extras "{{{
" ---------------------------------------------------------------------
" Source vim.init after vim is done setting up and on VimEnter
" augroup ON_STARTUP
"     au!
"     au VimEnter * source $MYVIMRC
" augroup END
set exrc
"}}}
" vim: set foldmethod=marker foldlevel=1:
