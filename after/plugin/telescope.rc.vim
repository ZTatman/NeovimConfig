if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> ;f <cmd>lua require('telescope.builtin').find_files({layout_strategy='bottom_pane',layout_config={width=0.45}})<cr>
nnoremap <silent> ;r <cmd>lua require('telescope.builtin').live_grep({layout_strategy='bottom_pane',layout_config={width=0.45}})<cr>
nnoremap <silent> ;pf <cmd>lua require('telescope.builtin').oldfiles({layout_strategy='bottom_pane',layout_config={height=0.45}})<cr>
nnoremap <silent> ;ps <cmd>lua require('telescope.builtin').search_history({layout_strategy='bottom_pane',layout_config={height=0.25}})<cr>
nnoremap <silent> ;k <cmd>lua require('telescope.builtin').keymaps({layout_strategy='bottom_pane',layout_config={height=0.25}})<cr>
nnoremap <silent> ;s <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({layout_strategy='bottom_pane',layout_config={height=0.25}})<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
noremap <silent> ;; <cmd>Telescope help_tags<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end


local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<C-s>"] = actions.select_vertical,
      },
      i = {
        ["q"] = actions.close,
        ["<C-s>"] = actions.select_vertical
      },
    },
    layout_config = {
      -- other layout configuration here
    },
  }
})
EOF
