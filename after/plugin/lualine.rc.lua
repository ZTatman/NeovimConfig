local lualine_status, lualine = pcall(require, "lualine")
local gps_status, gps = pcall(require, "nvim-gps")
if (not lualine_status) then return end
if (not gps_status) then return end

function branch_formatter(branch_name)
    local prefix = string.match(branch_name, "^(.-)/AGTPORTL13")
    if not prefix then
        return branch_name
    end
    local suffix = string.match(branch_name, "^.-/AGTPORTL13%-(%d%d%d%d)")
    if not suffix then
        return prefix
    end
    return prefix .. "/AGTPORTL13-" .. suffix
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '|', right = '|' },
    -- section_separators = {left = '', right = ''},
    -- component_separators = {left = '', right = ''},
    disabled_filetypes = {'alpha', 'dashboard', 'NvimTree', 'Outline'},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{'branch', fmt = branch_formatter}},
    lualine_c = {{
        gps.get_location,
        cond = gps.is_available 
    }},
    lualine_x = {
      { 
          'diagnostics',
          sources = {"nvim_diagnostic"},
          symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
      },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {{
          'tabs',
          max_length = math.floor(vim.o.columns * 0.33),
          mode = 2,
          tabs_color = {
            active = 'TabLineSel',
            inactive = 'TabLine',
          },
          fmt = function(tabname)
            local bufnr = vim.fn.tabpagenr()
            local mod = vim.api.nvim_buf_get_option(bufnr, 'modified')
            local symbol = mod == 1 and '+' or ''
            return tabname .. symbol
          end
        }},
      -- lualine_x = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
  },
  extensions = {'fugitive', 'toggleterm', 'nvim-tree'},
}
