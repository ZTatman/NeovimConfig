local bufferline_status, bufferline = pcall(require, "bufferline")
if (not bufferline_status) then return end


bufferline.setup {
    options = {
        mode = "tabs",
        numbers = "none",
        number_style = "",
        themable = true,
        mappings = true,
        indicator = {
            -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'none',
        },
        buffer_close_icon = "x",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 12,
        max_prefix_length = 10,
        tab_size = 20,
        -- padding = {left = 4, right = 4},
        diagnostics = "coc",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return "  " .. icon .. "" .. count
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center"
            }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thick",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = "id",
        custom_areas = {
            left = function()
                local result = {}
                local num_tabs = vim.fn.tabpagenr('$')
                if num_tabs ~= 0 then
                    table.insert(result, { text = "  " .. "  " .. num_tabs .. "  " })
                end
                return result
            end,
            -- right = function()
            --   local result = {}
            --   local error = vim.fn.Coc_diagnostic_get_count('Error')
            --   local warning = vim.fn.Coc_diagnostic_get_count('Warning')
            --   local information = vim.fn.Coc_diagnostic_get_count('Information')
            --   local hint = vim.fn.Coc_diagnostic_get_count('Hint')

            --   -- local error = vim.lsp.diagnostic.get_count(0, "Error")
            --   -- local warning = vim.lsp.diagnostic.get_count(0, "Warning")
            --   -- local info = vim.lsp.diagnostic.get_count(0, "Information")
            --   -- local hint = vim.lsp.diagnostic.get_count(0, "Hint")

            --   if error ~= 0 then
            --     table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
            --   end

            --   if warning ~= 0 then
            --     table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
            --   end

            --   if hint ~= 0 then
            --     table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
            --   end

            --   if info ~= 0 then
            --     table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
            --   end
            --   return result
            -- end
        },
    },
    -- highlights = {
    -- fill = {
    --     fg = { attribute = "fg", highlight = "Normal" },
    --     bg = { attribute = "bg", highlight = "StatusLine" },
    -- },
    -- background = {
    --     fg = { attribute = "fg", highlight = "Normal" },
    --     bg = { attribute = "bg", highlight = "StatusLine" },
    -- },
    -- tab = {
    --     fg = { attribute = "fg", highlight = "Label" },
    --     bg = { attribute = "bg", highlight = "Normal" },
    -- },
    -- tab_selected = {
    --     fg = { attribute = "fg", highlight = "Special" },
    --     bg = { attribute = "bg", highlight = "Normal" },
    -- },
    -- separator = {
    --     fg = { attribute = "bg", highlight = "Normal" },
    --     bg = { attribute = "bg", highlight = "StatusLine" },
    -- },
    -- separator_selected = {
    --     fg = { attribute = "fg", highlight = "Special" },
    --     bg = { attribute = "bg", highlight = "Normal" },
    -- },
    -- separator_visible = {
    --     fg = { attribute = "fg", highlight = "Normal" },
    --     bg = { attribute = "bg", highlight = "StatusLineNC" },
    -- },
    -- }
}
