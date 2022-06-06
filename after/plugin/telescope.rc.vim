if !exists('g:loaded_telescope') | finish | endif

nnoremap  <silent> ;f <cmd>lua require('telescope.builtin').find_files({layout_strategy='bottom_pane',layout_config={height=0.35}})<cr>
nnoremap  <silent> ;r <cmd>lua require('telescope.builtin').live_grep({layout_strategy='bottom_pane',layout_config={height=0.35}})<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

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
      },
    },
    layout_config = {
      bottom_pane = { height = 0.5}
      -- other layout configuration here
    },
  }
})
EOF
