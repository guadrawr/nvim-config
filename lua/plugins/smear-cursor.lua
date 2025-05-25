return {
    {
        "sphamba/smear-cursor.nvim",
        lazy = false,
        config = function()
            require("smear_cursor").setup {
                smear_between_buffers = true,
                smear_between_neighbor_lines = true,
                scroll_buffer_space = true,
                legacy_computing_symbols_support = true,
                smear_insert_mode = true,
                cursor_color = "#FFFFFF",
                stiffness = 0.8,
                trailing_stiffness = 0.5,
                stiffness_insert_mode = 0.6,
                trailing_stiffness_insert_mode = 0.6,
                distance_stop_animating = 0.5,
                cterm_cursor_colors = { 240, 245, 250, 255 },
                cterm_bg = 235,
            }
            vim.defer_fn(function()
                require("smear_cursor").toggle "on"
                vim.defer_fn(function()
                    require("smear_cursor").toggle "on"
                end, 50)
            end, 250)
        end,
    },
}
