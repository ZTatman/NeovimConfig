local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

local DEFAULT_WIDTH = 20;

nvimtree.setup({
  auto_reload_on_write = true,
  update_focused_file = {
    enable = true
  },
  sort_by = "name",
  filters = {
    custom = {
      ".git"
    }
  },
  renderer = {
    highlight_opened_files = "name",
  },
    view = {
        side = "left",
        adaptive_size = true,
        centralize_selection = true,
        width = DEFAULT_WIDTH
    }
})
