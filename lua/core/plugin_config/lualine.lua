local lualine_status, lualine = pcall(require, "lualine")
if (not lualine_status) then return end

function BRANCH_FORMATTER(branch_name)
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

local function get_project_name()
    local cwd = vim.fn.getcwd()
    local project_name = cwd:match("([^/]+)$")
    return project_name
end

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'kanagawa',
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        disabled_filetypes = { 'alpha', 'NvimTree', 'Outline' },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { get_project_name, separator = '' }, { 'branch', fmt = BRANCH_FORMATTER } },
        lualine_c = {},
        lualine_x = {
            {
                'diagnostics',
                sources = { "nvim_diagnostic" },
                symbols = { error = ' ', warn = ' ', info = '  ', hint = '⚡️ ' }
            },
            'encoding',
            'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'fugitive' },
}
