local lualine_status, lualine = pcall(require, "lualine")
local gps_status, gps = pcall(require, "nvim-gps")
if (not lualine_status) then return end
if (not gps_status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    -- section_separators = {left = '', right = ''},
    -- component_separators = {left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {},
    -- lualine_c = {{
    --   'filename',
    --   file_status = true, -- displays file status (readonly status, modified status)
    --   path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
    -- }},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    -- lualine_c = {{
    --   'filename',
    --   file_status = true, -- displays file status (readonly status, modified status)
    --   path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    -- }},
    lualine_c = {
        { gps.get_location, cond = gps.is_available },
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      lualine_a = {},
      lualine_b = {{
          'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }},
      lualine_c = {
          { gps.get_location, cond = gps.is_available },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
  },
  extensions = {'fugitive', 'toggleterm', 'nvim-tree'}
}
