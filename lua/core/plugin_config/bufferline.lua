local bufferline_status, bufferline = pcall(require, "bufferline")
if (not bufferline_status) then return end


bufferline.setup {
    options = {
        mode = "tabs",
        numbers = "none",
        number_style = "",
        mappings = true,
        -- indicator = {
        --     -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
        --     style = 'none',
        -- },
        buffer_close_icon = "x",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 12,
        max_prefix_length = 10,
        tab_size = 20,
        padding = { left = 4, right = 4 },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return "  " .. icon .. "" .. count
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                padding = 1
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
        },
    },
}
