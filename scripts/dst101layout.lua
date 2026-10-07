local SOURCE_WIDTH = 1533
local SOURCE_HEIGHT = 865
local DISPLAY_WIDTH = 1020

return {
    source = {
        width = SOURCE_WIDTH,
        height = SOURCE_HEIGHT,
    },

    display = {
        width = DISPLAY_WIDTH,
        scale = DISPLAY_WIDTH / SOURCE_WIDTH,
    },

    colours = {
        hover = { 0.95, 0.78, 0.30, 1 },
        selected = { 0.90, 0.68, 0.22, 1 },
        disabled = { 0.45, 0.45, 0.45, 0.55 },

        row_hover = { 0.95, 0.78, 0.30, 0.22 },
        row_selected = { 0.95, 0.72, 0.20, 0.70 },
        toc_page_selected = { 0.72, 0.55, 0.18, 1 },

        sidebar_text = { 0.84, 0.81, 0.70, 1 },
        sidebar_selected_text = { 0.12, 0.10, 0.06, 1 },

        headline_text = { 0.10, 0.08, 0.05, 1 },
        body_text = { 0.12, 0.10, 0.07, 1 },
        subtle_text = { 0.34, 0.29, 0.22, 0.82 },
    },

    sidebar = {
        content_left = 50,
        content_right = 329,

        topic_icon = {
            center_x = 72,
            size = 44,
        },

        topic_text = {
            left = 96,
            right = 323,
            font_size = 29,
        },

        header = {
            left = 52,
            right = 353,
            top = 64,
            bottom = 108,
            font_size = 38,
        },

        search = {
            left = 50,
            right = 329,
            top = 111,
            bottom = 147,
        },

        scrollbar = {
            left = 338,
            right = 353,
            top = 143,
            bottom = 755,
            top_arrow_top = 111,
            bottom_arrow_bottom = 789,
        },

        topic_rows = {
            { top = 150, bottom = 184 },
            { top = 188, bottom = 223 },
            { top = 227, bottom = 262 },
            { top = 266, bottom = 302 },
            { top = 306, bottom = 343 },
            { top = 346, bottom = 382 },
            { top = 385, bottom = 420 },
            { top = 424, bottom = 459 },
            { top = 464, bottom = 500 },
            { top = 505, bottom = 541 },
            { top = 545, bottom = 581 },
            { top = 586, bottom = 622 },
            { top = 626, bottom = 662 },
            { top = 667, bottom = 703 },
            { top = 708, bottom = 744 },
            { top = 749, bottom = 785 },
        },
    },

    contents = {
        title = {
            left = 420,
            right = 1435,
            top = 96,
            bottom = 154,
            font_size = 52,
        },

        list = {
            left = 420,
            right = 1435,
            top = 174,
            bottom = 790,

            minimum_block_width = 275,
            column_gap = 34,
            row_gap = 30,
            page_rows = 3,

            row_top_padding = 24,
            row_bottom_padding = 24,
            cell_left_padding = 12,
            cell_right_inset = 24,

            grid_horizontal_height = 36,
            grid_vertical_width = 28,
            grid_vertical_offset_x = -20,
            grid_right_inset = 48,
            grid_alpha = 0.28,

            topic_line_height = 32,
            page_line_height = 26,
            page_indent = 28,
            topic_font_size = 30,
            page_font_size = 24,
        },

        page_selector = {
            center_x = 1431,
            top = 305,

            width = 32,
            item_height = 34,
            gap = 6,
            font_size = 28,

            track_width = 2,
            track_alpha = 0.16,
        },
    },

    regions = {
        main = {
            left = 383,
            right = 1463,
            top = 76,
            bottom = 821,
        },

        top_left = {
            left = 409,
            right = 883,
            top = 99,
            bottom = 236,
            headline_max_height = 92,
            headline_line_gap = -2,
            mode = "flow",
        },

        illustration = {
            left = 426,
            right = 998,
            top = 246,
            bottom = 566,
        },

        illustration_caption = {
            left = 469,
            right = 952,
            top = 580,
            bottom = 600,
            mode = "box",
        },

        bottom_left = {
            left = 410,
            right = 966,
            top = 623,
            bottom = 774,
            mode = "flow",
        },

        right = {
            left = 1052,
            right = 1444,
            top = 119,
            bottom = 680,
            mode = "flow",
        },

        note = {
            left = 1014,
            right = 1337,
            top = 740,
            bottom = 783,
            mode = "box",
        },

        bottom_footer = {
            left = 419,
            right = 951,
            top = 790,
            bottom = 817,
        },
    },
}










