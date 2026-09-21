local Image = require("widgets/image")
local ImageButton = require("widgets/dst101quietimagebutton")
local Text = require("widgets/text")
local TextEdit = require("widgets/textedit")
local Widget = require("widgets/widget")

local LAYOUT = require("dst101layout")
local ILLUSTRATIONS = require("dst101illustrations")

local BACKDROP_ATLAS = "images/ui/base_template.xml"
local BACKDROP_TEXTURE = "base_template.tex"

local TOPIC_ATLAS = "images/topics/dst101_topics_color.xml"
local TOPIC_GRAY_ATLAS = "images/topics/dst101_topics_gray.xml"
local UI_ATLAS = "images/ui/dst101_ui.xml"

local NOTE_ANIMAL_ORDER = {
    "crow",
    "catcoon",
    "splumonkey",
}

local NOTE_STRIP = {
    width = 462,
    height = 98,
    center_x = 1220,
    center_y = 762,
}

local NOTE_ANIMALS = {
    crow = {
        texture = "note_animal_crow.tex",
        width = 100,
        height = 114,
        right_inset = 8,
        bottom_offset = 0,
        text_gap = 18,
    },

    catcoon = {
        texture = "note_animal_catcoon.tex",
        width = 118,
        height = 96,
        right_inset = 5,
        bottom_offset = 0,
        text_gap = 18,
    },

    splumonkey = {
        texture = "note_animal_splumonkey.tex",
        width = 96,
        height = 109,
        right_inset = 7,
        bottom_offset = 0,
        text_gap = 20,
    },
}

local BODY_FONT = "dst101_alegreya_regular"
local ITALIC_FONT = "dst101_alegreya_italic"

-- Plain prose opening the top-left region benefits from a little breathing
-- room. Headlines and section headings remain aligned to the authored top.
local TOP_LEFT_TEXT_START_OFFSET = 24
local TOP_LEFT_TEXT_START_INSET = 20

local BLOCK_STYLES = {
    headline = {
        font = HEADERFONT,
        colour = LAYOUT.colours.headline_text,
        size = 64,
        spacing = 7,
        wrapped_spacing = 2,
    },

    subtitle = {
        font = ITALIC_FONT,
        colour = LAYOUT.colours.headline_text,
        size = 31,
        spacing = 5,
    },

    heading = {
        font = HEADERFONT,
        colour = LAYOUT.colours.headline_text,
        size = 36,
        line_height = 36,
        spacing = 5,
    },

    page_heading = {
        font = HEADERFONT,
        colour = LAYOUT.colours.headline_text,
        size = 30,
        line_height = 30,
        spacing = 4,
    },

    text = {
        font = BODY_FONT,
        colour = LAYOUT.colours.body_text,
        size = 24,
        spacing = 32,
    },

    bullets = {
        font = BODY_FONT,
        colour = LAYOUT.colours.body_text,
        size = 24,
        spacing = 32,
    },

    caption = {
        font = ITALIC_FONT,
        colour = LAYOUT.colours.headline_text,
        size = 25,
        spacing = 0,
        align = ANCHOR_MIDDLE,
    },

    note = {
        font = ITALIC_FONT,
        colour = LAYOUT.colours.headline_text,
        size = 26,
        spacing = 0,
        align = ANCHOR_MIDDLE,
    },
}

local REGION_ORDER = {
    "top_left",
    "illustration_caption",
    "bottom_left",
    "right",
    "note",
}


-- =============================================================================
-- source-coordinate helpers
-- =============================================================================

local function source_x(x)
    return x - LAYOUT.source.width / 2
end

local function source_y(y)
    return LAYOUT.source.height / 2 - y
end

local function region_width(region)
    return region.right - region.left + 1
end

local function region_height(region)
    return region.bottom - region.top + 1
end

local function region_center_x(region)
    return source_x(
        (region.left + region.right) / 2
    )
end

local function region_center_y(region)
    return source_y(
        (region.top + region.bottom) / 2
    )
end


local function apply_tint(image, colour)
    image:SetTint(
        colour[1],
        colour[2],
        colour[3],
        colour[4]
    )
end


-- =============================================================================
-- topic/content helpers
-- =============================================================================

local function find_topic(data, topic_id)
    for _, topic in ipairs(data.topics or {}) do
        if topic.id == topic_id then
            return topic
        end
    end

    return nil
end

local function get_block_text(block, topic)
    if block.type == "headline" then
        return block.text or topic.title or ""
    end

    return block.text or ""
end


-- =============================================================================
-- generic page-content rendering
-- =============================================================================

local function get_stable_variant_index(key, variant_count)
    local hash = 0

    for index = 1, #key do
        hash = (
            hash * 31 +
            string.byte(key, index)
        ) % 2147483647
    end

    return hash % variant_count + 1
end


local function get_divider_index(key)
    return get_stable_variant_index(key, 6)
end


local function get_note_page_ordinal(
    data,
    current_topic_id,
    current_page
)
    local ordinal = 0

    for _, topic in ipairs(data.topics or {}) do
        for page_index, page in ipairs(
            topic.pages or {}
        ) do
            local note_blocks =
                page.regions
                and page.regions.note
                or nil

            if note_blocks ~= nil
                and #note_blocks > 0
            then
                ordinal = ordinal + 1

                if topic.id == current_topic_id
                    and page_index == current_page
                then
                    return ordinal
                end
            end
        end
    end

    return 1
end


local function add_divider(
    parent,
    region,
    source_cursor_y,
    divider_key
)
    local divider_index =
        get_divider_index(divider_key)

    local divider_texture = string.format(
        "divider_%02d.tex",
        divider_index
    )

    local divider_width = math.min(
        region_width(region),
        496
    )

    local divider_height =
        divider_width * 25 / 496

    local divider = parent:AddChild(
        Image(
            UI_ATLAS,
            divider_texture
        )
    )

    divider:ScaleToSize(
        divider_width,
        divider_height
    )

    divider:SetTint(
        LAYOUT.colours.body_text[1],
        LAYOUT.colours.body_text[2],
        LAYOUT.colours.body_text[3],
        0.55
    )

    divider:SetPosition(
        source_x(
            region.left +
            divider_width / 2
        ),
        source_y(
            source_cursor_y -
            8 +
            divider_height / 2
        )
    )

    return source_cursor_y +
        divider_height -
        6
end

local function get_related_topic_tile_texture(topic)
    local tile_index =
        get_stable_variant_index(
            topic.id .. ":related_topics",
            6
        )

    return string.format(
        "related_topic_tile_%02d.tex",
        tile_index
    )
end


local function render_related_topics(
    handbook,
    parent,
    topic,
    region,
    source_cursor_y,
    block
)
    local related_topics = {}

    for _, topic_id in ipairs(block.topics or {}) do
        local related_topic = find_topic(
            handbook.data,
            topic_id
        )

        if related_topic ~= nil
            and related_topic.id ~= topic.id
        then
            table.insert(
                related_topics,
                related_topic
            )
        end
    end

    if #related_topics == 0 then
        return source_cursor_y
    end

    local tile_size = 70
    local icon_size = 46
    local label_height = 20
    local label_gap = -3
    local column_gap = 26
    local row_gap = 12
    local maximum_columns = 4
    local left_inset = 16

    local available_width =
        region_width(region) -
        left_inset

    local fitting_columns = math.max(
        1,
        math.floor(
            (available_width + column_gap) /
            (tile_size + column_gap)
        )
    )

    local columns = math.min(
        maximum_columns,
        fitting_columns,
        #related_topics
    )

    local row_height =
        tile_size +
        label_gap +
        label_height +
        row_gap

    local tile_texture =
        get_related_topic_tile_texture(topic)

    local hover_colour = {
        1,
        0.88,
        0.62,
        1,
    }

    for index, related_topic in ipairs(related_topics) do
        local row = math.floor(
            (index - 1) / columns
        )

        local column =
            (index - 1) % columns

        local row_start_index =
            row * columns + 1

        local row_item_count = math.min(
            columns,
            #related_topics - row_start_index + 1
        )

        local row_width =
            row_item_count * tile_size +
            (row_item_count - 1) * column_gap

        local row_left =
            region.left +
            left_inset

        local tile_center_x =
            row_left +
            column * (
                tile_size +
                column_gap
            ) +
            tile_size / 2

        local row_top =
            source_cursor_y -
            8 +
            row * row_height

        local button = parent:AddChild(
            ImageButton(
                UI_ATLAS,
                tile_texture
            )
        )

        button.scale_on_focus = false
        button.move_on_click = false

        button:ForceImageSize(
            tile_size,
            tile_size
        )

        button:SetImageNormalColour(
            1,
            1,
            1,
            1
        )

        button:SetImageFocusColour(
            hover_colour[1],
            hover_colour[2],
            hover_colour[3],
            hover_colour[4]
        )

        button:SetPosition(
            source_x(tile_center_x),
            source_y(
                row_top +
                tile_size / 2
            )
        )

        button:SetOnClick(function()
            handbook:SetCurrentTopic(
                related_topic.id
            )
        end)

        local icon = button:AddChild(
            Image(
                TOPIC_GRAY_ATLAS,
                related_topic.icon .. ".tex"
            )
        )

        icon:ScaleToSize(
            icon_size,
            icon_size
        )

        icon:SetTint(
            0.88,
            0.84,
            0.76,
            1
        )

        icon:SetClickable(false)
        icon:SetPosition(0, 1)

        local label = parent:AddChild(
            Text(
                BODY_FONT,
                20,
                "",
                LAYOUT.colours.body_text
            )
        )

        label:SetTruncatedString(
            related_topic.title or "",
            tile_size + 24,
            nil,
            false
        )

        label:SetRegionSize(
            tile_size + 24,
            label_height
        )

        label:SetHAlign(ANCHOR_MIDDLE)
        label:SetVAlign(ANCHOR_MIDDLE)
        label:SetClickable(false)

        label:SetPosition(
            source_x(tile_center_x),
            source_y(
                row_top +
                tile_size +
                label_gap +
                label_height / 2
            )
        )
    end

    local row_count = math.ceil(
        #related_topics / columns
    )

    return source_cursor_y +
        row_count * row_height -
        row_gap +
        8
end

local function render_bullets(
    parent,
    region,
    source_cursor_y,
    block,
    horizontal_inset
)
    local style = BLOCK_STYLES.text
    local body_size = block.size or style.size
    local marker_size = body_size * 0.84

    local left_inset = horizontal_inset or 0
    local available_width =
        block.width
        or (
            region_width(region) -
            left_inset
        )

    local marker_width = 16
    local marker_gap = 7
    local item_indent =
        marker_width +
        marker_gap

    local item_width = math.max(
        1,
        available_width -
        item_indent
    )

    local item_gap = block.item_gap or 3

    for _, item in ipairs(block.items or {}) do
        local item_text = parent:AddChild(
            Text(
                style.font,
                body_size,
                "",
                style.colour or UICOLOURS.BROWN_DARK
            )
        )

        item_text:SetHAlign(ANCHOR_LEFT)
        item_text:SetVAlign(ANCHOR_TOP)
        item_text:SetClickable(false)

        item_text:SetMultilineTruncatedString(
            tostring(item),
            100,
            item_width
        )

        local _, item_height =
            item_text:GetRegionSize()

        item_text:SetRegionSize(
            item_width,
            item_height
        )

        item_text:SetPosition(
            source_x(
                region.left +
                left_inset +
                item_indent +
                item_width / 2
            ),
            source_y(
                source_cursor_y +
                item_height / 2
            )
        )

        local marker = parent:AddChild(
            Text(
                style.font,
                marker_size,
                "◆",
                style.colour or UICOLOURS.BROWN_DARK
            )
        )

        marker:SetHAlign(ANCHOR_MIDDLE)
        marker:SetVAlign(ANCHOR_TOP)
        marker:SetClickable(false)

        local _, marker_height =
            marker:GetRegionSize()

        marker:SetRegionSize(
            marker_width,
            marker_height
        )

        marker:SetPosition(
            source_x(
                region.left +
                left_inset +
                marker_width / 2
            ),
            source_y(
                source_cursor_y +
                2 +
                marker_height / 2
            )
        )

        local row_height = math.max(
            item_height,
            marker_height + 2,
            style.line_height or 0
        )

        source_cursor_y =
            source_cursor_y +
            row_height +
            item_gap
    end

    return source_cursor_y
        + (block.spacing or style.spacing or 0)
end


local function render_flow_block(
    handbook,
    parent,
    topic,
    region,
    source_cursor_y,
    block,
    divider_key,
    horizontal_inset
)
    if block.type == "spacer" then
        return source_cursor_y + (block.height or 10)
    end

    if block.type == "related_topics" then
        return render_related_topics(
            handbook,
            parent,
            topic,
            region,
            source_cursor_y,
            block
        )
    end

    if block.type == "divider" then
        return add_divider(
            parent,
            region,
            source_cursor_y,
            divider_key
        )
    end

    if block.type == "bullets" then
        return render_bullets(
            parent,
            region,
            source_cursor_y,
            block,
            horizontal_inset
        )
    end

    local style = BLOCK_STYLES[block.type]

    if style == nil then
        return source_cursor_y
    end

    local text = parent:AddChild(
        Text(
            style.font,
            block.size or style.size,
            "",
            style.colour or UICOLOURS.BROWN_DARK
        )
    )

    local value = get_block_text(block, topic)
    local left_inset = horizontal_inset or 0
    local width = block.width or region_width(region)
    local text_position_x = region_center_x(region)

    if left_inset > 0 then
        if block.width == nil then
            width = math.max(
                1,
                region_width(region) - left_inset
            )
        end

        text_position_x = source_x(
            region.left +
            left_inset +
            width / 2
        )
    end

    text:SetHAlign(ANCHOR_LEFT)
    text:SetVAlign(ANCHOR_TOP)
    text:SetClickable(false)

    if block.type == "headline" then
        local one_line_size =
            block.size or style.size

        local two_line_size =
            block.wrapped_size or 48

        local maximum_headline_height =
            block.max_height
            or region.headline_max_height

        local line_gap =
            block.line_gap
            or region.headline_line_gap
            or 0

        local words = {}

        for word in tostring(value):gmatch("%S+") do
            words[#words + 1] = word
        end

        local full_line =
            table.concat(words, " ")

        local headline_size = nil
        local headline_lines = nil
        local headline_heights = nil

        local function measure_line(line)
            text:SetString(line)

            local line_width, line_height =
                text:GetRegionSize()

            return line_width, line_height
        end

        local function fits_height(height)
            return maximum_headline_height == nil
                or height <= maximum_headline_height
        end

        local function choose_balanced_two_lines()
            local best = nil

            for split_index = 1, #words - 1 do
                local first_line =
                    table.concat(
                        words,
                        " ",
                        1,
                        split_index
                    )

                local second_line =
                    table.concat(
                        words,
                        " ",
                        split_index + 1,
                        #words
                    )

                local first_width, first_height =
                    measure_line(first_line)

                local second_width, second_height =
                    measure_line(second_line)

                if first_width <= width
                    and second_width <= width
                then
                    local width_difference =
                        math.abs(
                            first_width -
                            second_width
                        )

                    local widest_line =
                        math.max(
                            first_width,
                            second_width
                        )

                    if best == nil
                        or width_difference
                            < best.width_difference
                        or (
                            width_difference
                                == best.width_difference
                            and widest_line
                                < best.widest_line
                        )
                    then
                        best = {
                            lines = {
                                first_line,
                                second_line,
                            },

                            heights = {
                                first_height,
                                second_height,
                            },

                            height =
                                first_height +
                                line_gap +
                                second_height,

                            width_difference =
                                width_difference,

                            widest_line =
                                widest_line,
                        }
                    end
                end
            end

            return best
        end

        -- Keep one-line headlines at their authored display size.
        text:SetSize(one_line_size)

        local line_width, line_height =
            measure_line(full_line)

        if line_width <= width
            and fits_height(line_height)
        then
            headline_size =
                one_line_size

            headline_lines = {
                full_line,
            }

            headline_heights = {
                line_height,
            }
        end

        -- Wrapped headlines use one fixed size.
        if headline_lines == nil then
            text:SetSize(two_line_size)

            local candidate =
                choose_balanced_two_lines()

            if candidate ~= nil
                and fits_height(
                    candidate.height
                )
            then
                headline_size =
                    two_line_size

                headline_lines =
                    candidate.lines

                headline_heights =
                    candidate.heights
            end
        end

        if headline_lines == nil then
            -- Headlines beyond this treatment should normally be rewritten.
            headline_size =
                two_line_size

            text:SetSize(headline_size)

            text:SetMultilineTruncatedString(
                value,
                2,
                width
            )

            local wrapped_value =
                text:GetString()

            headline_lines = {}
            headline_heights = {}

            for line in wrapped_value:gmatch("[^\n]+") do
                headline_lines[
                    #headline_lines + 1
                ] = line

                local _, line_height =
                    measure_line(line)

                headline_heights[
                    #headline_heights + 1
                ] = line_height
            end
        end


        local headline_cursor_y =
            source_cursor_y

        for line_index, line in ipairs(
            headline_lines
        ) do
            local line_text

            if line_index == 1 then
                line_text = text
            else
                line_text = parent:AddChild(
                    Text(
                        style.font,
                        headline_size,
                        "",
                        style.colour
                            or UICOLOURS.BROWN_DARK
                    )
                )

                line_text:SetHAlign(ANCHOR_LEFT)
                line_text:SetVAlign(ANCHOR_TOP)
                line_text:SetClickable(false)
            end

            line_text:SetSize(headline_size)
            line_text:SetString(line)

            local line_height =
                headline_heights[line_index]

            line_text:SetRegionSize(
                width,
                line_height
            )

            line_text:SetPosition(
                text_position_x,
                source_y(
                    headline_cursor_y +
                    line_height / 2
                )
            )

            headline_cursor_y =
                headline_cursor_y +
                line_height

            if line_index < #headline_lines then
                headline_cursor_y =
                    headline_cursor_y +
                    line_gap
            end
        end

        local headline_spacing

        if #headline_lines > 1 then
            headline_spacing =
                block.wrapped_spacing
                or style.wrapped_spacing
                or block.spacing
                or style.spacing
                or 0
        else
            headline_spacing =
                block.spacing
                or style.spacing
                or 0
        end

        return headline_cursor_y
            + headline_spacing
    end
    local rendered_value = value

    -- Keep headings on one line whenever they fit. Only headings that would
    -- wrap are given a deliberate, balanced two-line split.
    if block.type == "heading" or block.type == "page_heading" then
        text:SetString(value)

        local one_line_width =
            select(
                1,
                text:GetRegionSize()
            )

        if one_line_width > width then
            local words = {}

            for word in value:gmatch("%S+") do
                words[#words + 1] = word
            end

            local best_split = nil

            for split_index = 1, #words - 1 do
                local first_line =
                    table.concat(
                        words,
                        " ",
                        1,
                        split_index
                    )

                local second_line =
                    table.concat(
                        words,
                        " ",
                        split_index + 1,
                        #words
                    )

                text:SetString(first_line)

                local first_width =
                    select(
                        1,
                        text:GetRegionSize()
                    )

                text:SetString(second_line)

                local second_width =
                    select(
                        1,
                        text:GetRegionSize()
                    )

                if first_width <= width
                    and second_width <= width
                then
                    local width_difference =
                        math.abs(
                            first_width
                            - second_width
                        )

                    local widest_line =
                        math.max(
                            first_width,
                            second_width
                        )

                    if best_split == nil
                        or width_difference
                            < best_split.width_difference
                        or (
                            width_difference
                                == best_split.width_difference
                            and widest_line
                                < best_split.widest_line
                        )
                    then
                        best_split = {
                            first_line = first_line,
                            second_line = second_line,
                            width_difference =
                                width_difference,
                            widest_line =
                                widest_line,
                        }
                    end
                end
            end

            if best_split ~= nil then
                rendered_value =
                    best_split.first_line
                    .. "\n"
                    .. best_split.second_line
            end
        end
    end

    -- Page length intentionally stays under manual author control.
    text:SetMultilineTruncatedString(
        rendered_value,
        100,
        width
    )

    local _, measured_height =
        text:GetRegionSize()


    local layout_height = math.max(
        measured_height,
        block.line_height
            or style.line_height
            or 0
    )

    -- Keep the full authored region width so left alignment is meaningful.
    text:SetRegionSize(
        width,
        measured_height
    )

    text:SetPosition(
        text_position_x,
        source_y(
            source_cursor_y +
            measured_height / 2
        )
    )

    source_cursor_y =
        source_cursor_y + layout_height

    -- A normal section heading and its divider are one visual unit.
    -- Large topic titles deliberately do not use dividers.
    if block.type == "heading" then
        source_cursor_y = add_divider(
            parent,
            region,
            source_cursor_y + 2,
            divider_key
        )
    end

    return source_cursor_y
        + (block.spacing or style.spacing or 0)
end

local function render_box_region(
    parent,
    topic,
    region,
    blocks,
    note_animal_index
)
    local block = blocks[1]

    if block == nil then
        return
    end

    local style = BLOCK_STYLES[block.type]

    if style == nil then
        return
    end

    local note_text_right = nil

    if block.type == "note" then
        local strip_width =
            NOTE_STRIP.width

        local strip_height =
            NOTE_STRIP.height

        local strip_center_x =
            NOTE_STRIP.center_x

        local strip_center_y =
            NOTE_STRIP.center_y

        local strip = parent:AddChild(
            Image(
                UI_ATLAS,
                "note_strip.tex"
            )
        )

        strip:ScaleToSize(
            strip_width,
            strip_height
        )

        strip:SetPosition(
            source_x(strip_center_x),
            source_y(strip_center_y)
        )

        strip:SetClickable(false)

        strip:SetTint(
            LAYOUT.colours.body_text[1],
            LAYOUT.colours.body_text[2],
            LAYOUT.colours.body_text[3],
            0.58
        )

        local animal_name =
            NOTE_ANIMAL_ORDER[note_animal_index]

        local animal =
            NOTE_ANIMALS[animal_name]

        if animal ~= nil then
            local animal_image =
                parent:AddChild(
                    Image(
                        UI_ATLAS,
                        animal.texture
                    )
                )

            animal_image:ScaleToSize(
                animal.width,
                animal.height
            )

            -- Anchor every animal to the note strip rather than the text region.
            -- Per-animal dimensions and offsets account for different silhouettes.
            local strip_right =
                strip_center_x + strip_width / 2

            local strip_bottom =
                strip_center_y + strip_height / 2

            local animal_right =
                strip_right - animal.right_inset

            local animal_bottom =
                strip_bottom + animal.bottom_offset

            local animal_center_x =
                animal_right - animal.width / 2

            local animal_center_y =
                animal_bottom - animal.height / 2

            local animal_left =
                animal_center_x - animal.width / 2

            -- Keep note prose clear of the selected animal. Splumonkey gets
            -- slightly more room because its silhouette reaches farther left.
            note_text_right =
                animal_left - animal.text_gap

            animal_image:SetPosition(
                source_x(animal_center_x),
                source_y(animal_center_y)
            )

            animal_image:SetClickable(false)

            -- Note animals are full-colour authored assets. Do not tint them.
            animal_image:SetTint(
                1,
                1,
                1,
                1
            )
        end
    end

    local text = parent:AddChild(
        Text(
            style.font,
            block.size or style.size,
            "",
            style.colour or UICOLOURS.BROWN_DARK
        )
    )

    text:SetHAlign(ANCHOR_MIDDLE)
    text:SetVAlign(ANCHOR_MIDDLE)
    text:SetClickable(false)

    local value = get_block_text(block, topic)
    local width = block.width or region_width(region)
    local text_position_x =
        region_center_x(region)

    if block.type == "note"
        and note_text_right ~= nil
    then
        local text_left =
            region.left

        local text_right =
            math.min(
                region.right,
                note_text_right
            )

        width =
            math.max(
                1,
                text_right - text_left
            )

        text_position_x =
            source_x(
                (text_left + text_right) / 2
            )
    end

    if block.type == "caption" then
        text:SetTruncatedString(
            value,
            width,
            nil,
            false
        )
    elseif block.type == "note" then
        text:SetMultilineTruncatedString(
            value,
            2,
            width
        )
    else
        text:SetMultilineTruncatedString(
            value,
            100,
            width
        )
    end

    text:SetPosition(
        text_position_x,
        region_center_y(region)
    )
end


-- =============================================================================
-- widget
-- =============================================================================

local DST101Widget = Class(Widget, function(self, owner)
    Widget._ctor(self, "DST101Widget")

    self.owner = owner
    self.current_topic_id = "setting_out"
    self.current_page = 1
    self.topic_scroll_index = 1

    self.root = self:AddChild(Widget("root"))

    -- All handbook geometry uses the 1533x865 source-art coordinate system.
    self.design_root = self.root:AddChild(
        Widget("design_root")
    )
    self.design_root:SetScale(
        LAYOUT.display.scale,
        LAYOUT.display.scale,
        1
    )

    -- Illustrations sit behind the handbook template so the authored frame
    -- and its corner details remain above the page artwork.
    self.illustration_root = self.design_root:AddChild(
        Widget("illustration_root")
    )

    self.backdrop = self.design_root:AddChild(
        Image(BACKDROP_ATLAS, BACKDROP_TEXTURE)
    )
    self.backdrop:ScaleToSize(
        LAYOUT.source.width,
        LAYOUT.source.height
    )

    local search_defocus_button =
        self.design_root:AddChild(
            ImageButton(
                "images/global.xml",
                "square.tex"
            )
        )

    search_defocus_button.scale_on_focus = false
    search_defocus_button.move_on_click = false

    search_defocus_button:ForceImageSize(
        LAYOUT.source.width,
        LAYOUT.source.height
    )

    search_defocus_button:SetImageNormalColour(
        1,
        1,
        1,
        0
    )

    search_defocus_button:SetImageFocusColour(
        1,
        1,
        1,
        0
    )

    search_defocus_button:SetImageSelectedColour(
        1,
        1,
        1,
        0
    )

    search_defocus_button:SetOnClick(function()
        self:StopSearchEditing()
    end)

    self:ReloadData()
end)


-- =============================================================================
-- sidebar
-- =============================================================================

local function normalize_search_text(value)
    local text = string.lower(value or "")

    -- Lua's normal string.lower() is ASCII-oriented.
    -- Cover the Norwegian letters used by the handbook translation.
    text = text:gsub("Å", "å")
    text = text:gsub("Æ", "æ")
    text = text:gsub("Ø", "ø")

    text = text:gsub("^%s+", "")
    text = text:gsub("%s+$", "")
    text = text:gsub("%s+", " ")

    return text
end


local function search_text_matches(value, query)
    if value == nil or value == "" then
        return false
    end

    local text = normalize_search_text(
        tostring(value)
    )

    return string.find(
        text,
        query,
        1,
        true
    ) ~= nil
end


local function block_matches_search(block, query)
    if search_text_matches(
        block.text,
        query
    ) then
        return true
    end

    if block.type == "bullets" then
        for _, item in ipairs(block.items or {}) do
            if search_text_matches(
                item,
                query
            ) then
                return true
            end
        end
    end

    return false
end


local function page_matches_search(page, query)
    for _, blocks in pairs(
        page.regions or {}
    ) do
        for _, block in ipairs(blocks or {}) do
            if block_matches_search(
                block,
                query
            ) then
                return true
            end
        end
    end

    return false
end


local function topic_match_page(topic, query)
    -- Topic-level matches deliberately open page 1.
    if search_text_matches(
        topic.title,
        query
    ) then
        return 1
    end

    for _, tag in ipairs(topic.tags or {}) do
        if search_text_matches(
            tag,
            query
        ) then
            return 1
        end
    end

    -- Page-content matches jump to the first matching page.
    for page_index, page in ipairs(
        topic.pages or {}
    ) do
        if page_matches_search(
            page,
            query
        ) then
            return page_index
        end
    end

    return nil
end


function DST101Widget:GetSidebarTopics()
    local topics = self.data.topics or {}
    local query = self.search_query or ""

    if query == "" then
        self.search_match_pages = {}
        return topics
    end

    local filtered_topics = {}
    local match_pages = {}

    for _, topic in ipairs(topics) do
        local page_index = topic_match_page(
            topic,
            query
        )

        if page_index ~= nil then
            table.insert(
                filtered_topics,
                topic
            )

            match_pages[topic.id] =
                page_index
        end
    end

    self.search_match_pages = match_pages

    return filtered_topics
end


function DST101Widget:SetSearchQuery(value)
    local previous_query =
        self.search_query or ""

    local query = normalize_search_text(
        value
    )

    if query == previous_query then
        return
    end

    local query_expanded =
        #query > #previous_query

    self.search_query = query
    self.topic_scroll_index = 1

    self:RefreshSidebar()

    if not query_expanded
        or query == ""
    then
        return
    end

    local page_number =
        self.search_match_pages
        and self.search_match_pages[
            self.current_topic_id
        ]

    if page_number ~= nil
        and page_number ~= self.current_page
    then
        self.current_page = page_number
        self:RefreshPage()
    end
end


local function get_deleted_text(before, after)
    if before == after or #after >= #before then
        return nil, nil
    end

    local prefix_length = 0
    local maximum_prefix =
        math.min(#before, #after)

    while prefix_length < maximum_prefix
        and before:byte(prefix_length + 1)
            == after:byte(prefix_length + 1)
    do
        prefix_length = prefix_length + 1
    end

    local suffix_length = 0
    local maximum_suffix =
        #after - prefix_length

    while suffix_length < maximum_suffix
        and before:byte(#before - suffix_length)
            == after:byte(#after - suffix_length)
    do
        suffix_length = suffix_length + 1
    end

    return before:sub(
        prefix_length + 1,
        #before - suffix_length
    ), suffix_length
end


local function delete_previous_search_word(edit)
    local removed_word_character = false
    local removing_boundary_whitespace = false
    local preserve_boundary_whitespace = nil

    -- Search input is capped at 80 characters, so this also prevents an
    -- unexpected native edit state from looping indefinitely.
    for deletion_index = 1, 80 do
        local before =
            edit:GetLineEditString()

        edit.inst.TextEditWidget:OnKeyDown(
            KEY_BACKSPACE
        )

        local after =
            edit:GetLineEditString()

        if before == after then
            break
        end

        local deleted, suffix_length =
            get_deleted_text(before, after)

        if deleted == nil or deleted == "" then
            break
        end

        -- Let native selection deletion stand on its own.
        if deleted:utf8len() > 1 then
            break
        end

        local deleted_whitespace =
            deleted:match("^%s+$") ~= nil

        if preserve_boundary_whitespace == nil then
            -- If the caret began inside a word, keep the separator before
            -- that word so "food coo|king" becomes "food |king".
            preserve_boundary_whitespace =
                not deleted_whitespace
                and suffix_length ~= nil
                and suffix_length > 0
        end

        if removing_boundary_whitespace then
            if not deleted_whitespace then
                -- We reached the preceding word. Restore its first character.
                edit:OnTextInput(deleted)
                break
            end
        elseif removed_word_character then
            if deleted_whitespace then
                if preserve_boundary_whitespace then
                    edit:OnTextInput(deleted)
                    break
                end

                removing_boundary_whitespace = true
            end
        elseif not deleted_whitespace then
            removed_word_character = true
        end
    end
end

function DST101Widget:BuildSearchRow()
    if self.search_root ~= nil then
        return
    end

    self.search_query =
        self.search_query or ""

    self.search_match_pages =
        self.search_match_pages or {}

    local sidebar = LAYOUT.sidebar
    local search = sidebar.search

    self.search_root = self.design_root:AddChild(
        Widget("search_root")
    )

    local center_y = source_y(
        (
            search.top +
            search.bottom
        ) / 2
    )

    local row_button = self.search_root:AddChild(
        ImageButton(
            "images/global.xml",
            "square.tex"
        )
    )

    row_button.scale_on_focus = false
    row_button.move_on_click = false

    row_button:ForceImageSize(
        search.right - search.left + 1,
        search.bottom - search.top + 1
    )

    row_button:SetPosition(
        source_x(
            (
                search.left +
                search.right
            ) / 2
        ),
        center_y
    )

    row_button:SetImageNormalColour(1, 1, 1, 0)
    row_button:SetImageFocusColour(1, 1, 1, 0)
    row_button:SetImageSelectedColour(1, 1, 1, 0)

    local icon = self.search_root:AddChild(
        Image(
            TOPIC_ATLAS,
            "search.tex"
        )
    )

    icon:ScaleToSize(
        sidebar.topic_icon.size,
        sidebar.topic_icon.size
    )

    icon:SetPosition(
        source_x(
            sidebar.topic_icon.center_x
        ),
        center_y
    )

    icon:SetClickable(false)

    local text_left =
        sidebar.topic_text.left

    local text_right =
        sidebar.topic_text.right

    local text_width =
        text_right -
        text_left +
        1

    self.search_edit =
        self.search_root:AddChild(
            TextEdit(
                HEADERFONT,
                26,
                "",
                LAYOUT.colours.sidebar_text
            )
        )

    self.search_edit:SetRegionSize(
        text_width,
        search.bottom - search.top + 1
    )

    self.search_edit:SetHAlign(
        ANCHOR_LEFT
    )

    self.search_edit:SetVAlign(
        ANCHOR_MIDDLE
    )

    self.search_edit:SetPosition(
        source_x(
            (
                text_left +
                text_right
            ) / 2
        ),
        center_y
    )

    self.search_edit:SetIdleTextColour(
        unpack(
            LAYOUT.colours.sidebar_text
        )
    )

    self.search_edit:SetEditTextColour(
        unpack(
            LAYOUT.colours.sidebar_text
        )
    )

    self.search_edit:SetEditCursorColour(
        unpack(
            LAYOUT.colours.sidebar_text
        )
    )

    self.search_edit:SetTextLengthLimit(80)
    self.search_edit:EnableScrollEditWindow(true)

    self.search_edit:SetTextPrompt(
        self.data.strings.search_placeholder
            or "Search...",
        {
            LAYOUT.colours.sidebar_text[1],
            LAYOUT.colours.sidebar_text[2],
            LAYOUT.colours.sidebar_text[3],
            0.55,
        }
    )

    self.search_edit:SetString(
        self.search_query
    )

    local search_edit_on_control =
        self.search_edit.OnControl

    self.search_edit.OnControl =
        function(edit, control, down)
            if edit.editing
                and control == CONTROL_ACCEPT
            then
                return true
            end

            return search_edit_on_control(
                edit,
                control,
                down
            )
        end
    local search_edit_on_raw_key =
        self.search_edit.OnRawKey

    self.search_edit.OnRawKey =
        function(edit, key, down)
            if edit.editing
                and down
                and key == KEY_BACKSPACE
                and TheInput:IsKeyDown(KEY_CTRL)
            then
                delete_previous_search_word(edit)

                if edit.OnTextInputted ~= nil then
                    edit.OnTextInputted(true)
                end

                return true
            end

            return search_edit_on_raw_key(
                edit,
                key,
                down
            )
        end

    row_button:SetOnClick(function()
        self.search_edit:SetEditing(true)
    end)

    self.search_edit.OnTextInputted =
        function()
            self:SetSearchQuery(
                self.search_edit:GetString()
            )
        end

    self.search_edit.OnTextEntered =
        function(value)
            self:SetSearchQuery(value)
        end
end

function DST101Widget:StopSearchEditing()
    if self.search_edit ~= nil then
        self.search_edit:SetEditing(false)
    end
end

function DST101Widget:SetCurrentTopic(topic_id, page_number)
    self:StopSearchEditing()
    if find_topic(self.data, topic_id) == nil then
        return
    end

    self.current_topic_id = topic_id
    self.current_page = page_number or 1

    self:RefreshPage()
    self:RefreshSidebar()
end

function DST101Widget:GetAdjacentSidebarTopic(offset)
    local topics = self:GetSidebarTopics()

    if #topics == 0 then
        return nil, nil, topics
    end

    local current_index = nil

    for index, topic in ipairs(topics) do
        if topic.id == self.current_topic_id then
            current_index = index
            break
        end
    end

    -- If the active search hides the current topic, enter the
    -- visible result list from the appropriate end.
    if current_index == nil then
        local target_index =
            offset < 0 and #topics or 1

        return topics[target_index], target_index, topics
    end

    local target_index =
        current_index + offset

    if target_index < 1
        or target_index > #topics
    then
        return nil, nil, topics
    end

    return topics[target_index], target_index, topics
end

function DST101Widget:ChangeTopic(offset, page_mode)
    self:StopSearchEditing()

    local topic, target_index, topics =
        self:GetAdjacentSidebarTopic(offset)

    if topic == nil then
        return false
    end

    self.current_topic_id = topic.id

    if page_mode == "last" then
        self.current_page = math.max(
            1,
            #(topic.pages or {})
        )
    else
        self.current_page = 1
    end

    -- Keep keyboard-selected topics inside the visible sidebar window.
    local visible_count =
        #LAYOUT.sidebar.topic_rows

    if target_index < self.topic_scroll_index then
        self.topic_scroll_index = target_index
    elseif target_index
        > self.topic_scroll_index
        + visible_count
        - 1
    then
        self.topic_scroll_index =
            target_index - visible_count + 1
    end

    local maximum_start =
        self:GetMaximumTopicScrollStart(topics)

    self.topic_scroll_index = math.max(
        1,
        math.min(
            maximum_start,
            self.topic_scroll_index
        )
    )

    self:RefreshPage()
    self:RefreshSidebar()

    return true
end

function DST101Widget:GetMaximumTopicScrollStart(topics)
    local visible_count =
        #LAYOUT.sidebar.topic_rows

    return math.max(
        1,
        #topics - visible_count + 1
    )
end

function DST101Widget:GetScrollbarGeometry()
    local scrollbar = LAYOUT.sidebar.scrollbar

    local handle_source_width = 121
    local handle_source_height = 518

    local handle_width =
        scrollbar.right - scrollbar.left + 2

    local handle_height =
        handle_width
        * handle_source_height
        / handle_source_width

    local handle_center_x_source =
        (scrollbar.left + scrollbar.right) / 2
        + 0.5

    local handle_top_center_source =
        scrollbar.top + handle_height / 2 - 1

    local handle_bottom_center_source =
        scrollbar.bottom - handle_height / 2 + 2

    return {
        handle_width = handle_width,
        handle_height = handle_height,

        center_x = source_x(
            handle_center_x_source
        ),

        top_y = source_y(
            handle_top_center_source
        ),

        bottom_y = source_y(
            handle_bottom_center_source
        ),
    }
end

function DST101Widget:GetDesignMouseY()
    local position =
        self.design_root:GetWorldPosition()

    local _, scale_y, _ =
        self.design_root.inst.UITransform:GetScale()

    local parent = self.design_root:GetParent()

    while parent ~= nil do
        local _, parent_scale_y, _ =
            parent.inst.UITransform:GetScale()

        scale_y = scale_y * parent_scale_y
        parent = parent:GetParent()
    end

    return (
        TheFrontEnd.lasty - position.y
    ) / scale_y
end

function DST101Widget:StopScrollbarDragging()
    TheFrontEnd:LockFocus(false)

    self.scrollbar_dragging = false
    self.scrollbar_drag_offset_y = 0

    self:UpdateScrollbar(
        self:GetSidebarTopics()
    )
end

function DST101Widget:DragScrollbar()
    if self.scrollbar_handle == nil then
        return
    end

    local topics = self:GetSidebarTopics()
    local maximum_start =
        self:GetMaximumTopicScrollStart(topics)

    if maximum_start <= 1 then
        return
    end

    local geometry =
        self:GetScrollbarGeometry()

    local mouse_y =
        self:GetDesignMouseY()
        + (self.scrollbar_drag_offset_y or 0)

    local handle_y = math.clamp(
        mouse_y,
        geometry.bottom_y,
        geometry.top_y
    )

    self.scrollbar_handle:SetPosition(
        geometry.center_x,
        handle_y
    )

    local scroll_ratio =
        (geometry.top_y - handle_y)
        / (geometry.top_y - geometry.bottom_y)

    local new_index =
        1
        + math.floor(
            scroll_ratio
            * (maximum_start - 1)
            + 0.5
        )

    if new_index == self.topic_scroll_index then
        return
    end

    self.topic_scroll_index = new_index

    -- Rebuild rows without snapping the handle away from the mouse.
    self:RefreshSidebar(true)
end

function DST101Widget:BuildScrollbar()
    if self.scrollbar_root ~= nil then
        return
    end

    local scrollbar = LAYOUT.sidebar.scrollbar
    local geometry =
        self:GetScrollbarGeometry()

    self.scrollbar_root = self.design_root:AddChild(
        Widget("scrollbar_root")
    )

    local track_left = scrollbar.left - 4
    local track_right = scrollbar.right + 4

    self.scrollbar_track =
        self.scrollbar_root:AddChild(
            ImageButton(
                "images/global.xml",
                "square.tex"
            )
        )

    self.scrollbar_track.scale_on_focus = false
    self.scrollbar_track.move_on_click = false

    self.scrollbar_track:ForceImageSize(
        track_right - track_left + 1,
        scrollbar.bottom - scrollbar.top + 1
    )

    self.scrollbar_track:SetPosition(
        source_x(
            (track_left + track_right) / 2
        ),
        source_y(
            (scrollbar.top + scrollbar.bottom) / 2
        )
    )

    self.scrollbar_track:SetImageNormalColour(1, 1, 1, 0)
    self.scrollbar_track:SetImageFocusColour(1, 1, 1, 0)
    self.scrollbar_track:SetImageSelectedColour(1, 1, 1, 0)

    self.scrollbar_track:SetOnClick(function()
        self:StopSearchEditing()

        local topics = self:GetSidebarTopics()
        local maximum_start =
            self:GetMaximumTopicScrollStart(topics)

        if maximum_start <= 1 then
            return
        end

        local geometry =
            self:GetScrollbarGeometry()

        local click_y = math.clamp(
            self:GetDesignMouseY(),
            geometry.bottom_y,
            geometry.top_y
        )

        local scroll_ratio =
            (geometry.top_y - click_y)
            / (geometry.top_y - geometry.bottom_y)

        self.topic_scroll_index =
            1
            + math.floor(
                scroll_ratio
                * (maximum_start - 1)
                + 0.5
            )

        self:RefreshSidebar()
    end)

    self.scrollbar_handle =
        self.scrollbar_root:AddChild(
            ImageButton(
                UI_ATLAS,
                "slider_handle.tex"
            )
        )

    self.scrollbar_handle.scale_on_focus = false
    self.scrollbar_handle.move_on_click = false

    self.scrollbar_handle:ForceImageSize(
        geometry.handle_width,
        geometry.handle_height
    )

    self.scrollbar_handle:SetImageNormalColour(
        1, 1, 1, 1
    )

    self.scrollbar_handle:SetImageFocusColour(
        1, 1, 1, 1
    )

    self.scrollbar_handle:SetImageSelectedColour(
        1, 1, 1, 1
    )

    self.scrollbar_handle:SetOnDown(function()
        self:StopSearchEditing()

        self.scrollbar_dragging = true

        local handle_position =
            self.scrollbar_handle:GetPosition()

        self.scrollbar_drag_offset_y =
            handle_position.y
            - self:GetDesignMouseY()
    end)

    self.scrollbar_handle:SetWhileDown(function()
        if self.scrollbar_dragging then
            TheFrontEnd:LockFocus(true)
            self:DragScrollbar()
        end
    end)

    self.scrollbar_handle.OnLoseFocus = function()
        self:StopScrollbarDragging()
    end

    self.scrollbar_handle:SetOnClick(function()
        self:StopScrollbarDragging()
    end)

    -- Invisible hitboxes operate the arrows baked into the backdrop.
    local function add_scroll_arrow_button(
        top,
        bottom,
        offset
    )
        local left = scrollbar.left - 4
        local right = scrollbar.right + 4

        local button =
            self.scrollbar_root:AddChild(
                ImageButton(
                    "images/global.xml",
                    "square.tex"
                )
            )

        button.scale_on_focus = false
        button.move_on_click = false

        button:ForceImageSize(
            right - left + 1,
            bottom - top + 1
        )

        button:SetPosition(
            source_x((left + right) / 2),
            source_y((top + bottom) / 2)
        )

        button:SetImageNormalColour(1, 1, 1, 0)
        button:SetImageFocusColour(1, 1, 1, 0)
        button:SetImageSelectedColour(1, 1, 1, 0)

        button:SetOnClick(function()
            self:StopSearchEditing()
            self:ScrollTopics(offset)
        end)
    end

    add_scroll_arrow_button(
        scrollbar.top_arrow_top,
        scrollbar.top - 1,
        -1
    )

    add_scroll_arrow_button(
        scrollbar.bottom + 1,
        scrollbar.bottom_arrow_bottom,
        1
    )
end

function DST101Widget:UpdateScrollbar(topics)
    if self.scrollbar_root == nil then
        self:BuildScrollbar()
    end

    local maximum_start =
        self:GetMaximumTopicScrollStart(topics)

    self.topic_scroll_index = math.max(
        1,
        math.min(
            maximum_start,
            self.topic_scroll_index
        )
    )

    local scroll_ratio = 0

    if maximum_start > 1 then
        scroll_ratio =
            (self.topic_scroll_index - 1)
            / (maximum_start - 1)
    end

    local geometry =
        self:GetScrollbarGeometry()

    local handle_y =
        geometry.top_y
        + (
            geometry.bottom_y
            - geometry.top_y
        ) * scroll_ratio

    self.scrollbar_handle:SetPosition(
        geometry.center_x,
        handle_y
    )
end

function DST101Widget:ScrollTopics(offset)
    local topics = self:GetSidebarTopics()

    local maximum_start =
        self:GetMaximumTopicScrollStart(topics)

    local new_index = math.max(
        1,
        math.min(
            maximum_start,
            self.topic_scroll_index + offset
        )
    )

    if new_index == self.topic_scroll_index then
        return
    end

    self.topic_scroll_index = new_index
    self:RefreshSidebar()
end

function DST101Widget:RefreshSidebar(preserve_scrollbar_handle)
    if self.sidebar_root ~= nil then
        self.sidebar_root:Kill()
    end

    self.sidebar_root = self.design_root:AddChild(
        Widget("sidebar_root")
    )

    self.sidebar_rows = {}

    local sidebar = LAYOUT.sidebar

    if self.search_root == nil then
        self:BuildSearchRow()
    end

    local topics = self:GetSidebarTopics()

    if self.scrollbar_root == nil then
        self:BuildScrollbar()
    end

    if not preserve_scrollbar_handle then
        self:UpdateScrollbar(topics)
    end

    local header = self.sidebar_root:AddChild(
        Text(
            HEADERFONT,
            sidebar.header.font_size,
            self.data.strings.topics or "",
            LAYOUT.colours.sidebar_text
        )
    )

    header:SetRegionSize(
        region_width(sidebar.header),
        region_height(sidebar.header)
    )
    header:SetHAlign(ANCHOR_MIDDLE)
    header:SetVAlign(ANCHOR_MIDDLE)
    header:SetClickable(false)
    header:SetPosition(
        region_center_x(sidebar.header),
        region_center_y(sidebar.header)
    )

    local row_left = sidebar.content_left
    local row_right = sidebar.content_right
    local row_width = row_right - row_left + 1
    local row_center_x = source_x(
        (row_left + row_right) / 2
    )

    local icon_x =
        source_x(sidebar.topic_icon.center_x)
        - row_center_x

    local text_width =
        sidebar.topic_text.right
        - sidebar.topic_text.left
        + 1

    local text_center_x =
        source_x(
            (
                sidebar.topic_text.left
                + sidebar.topic_text.right
            ) / 2
        )
        - row_center_x

    for slot_index, slot in ipairs(sidebar.topic_rows) do
        local topic_index =
            self.topic_scroll_index + slot_index - 1

        local topic = topics[topic_index]

        if topic ~= nil then
            local row_height =
                slot.bottom - slot.top + 1

            local row_center_y = source_y(
                (slot.top + slot.bottom) / 2
            )

            local button = self.sidebar_root:AddChild(
                ImageButton(
                    "images/global.xml",
                    "square.tex"
                )
            )

            button.scale_on_focus = false
            button.move_on_click = false

            button:ForceImageSize(
                row_width,
                row_height
            )

            button:SetPosition(
                row_center_x,
                row_center_y
            )

            button:SetImageNormalColour(
                1,
                1,
                1,
                0
            )

            button:SetImageFocusColour(
                unpack(LAYOUT.colours.row_hover)
            )

            button:SetImageSelectedColour(
                unpack(LAYOUT.colours.row_selected)
            )

            button.AllowOnControlWhenSelected = true

            button:SetOnClick(function()
                self:StopSearchEditing()

                local page_number =
                    self.search_match_pages
                    and self.search_match_pages[topic.id]
                    or 1

                if topic.id == self.current_topic_id then
                    if self.current_page ~= page_number then
                        self.current_page = page_number
                        self:RefreshPage()
                        self:RefreshSidebar()
                    end

                    return
                end

                self:SetCurrentTopic(
                    topic.id,
                    page_number
                )
            end)

            local icon = button:AddChild(
                Image(
                    TOPIC_ATLAS,
                    topic.icon .. ".tex"
                )
            )

            icon:ScaleToSize(
                sidebar.topic_icon.size,
                sidebar.topic_icon.size
            )
            icon:SetPosition(icon_x, 0)
            icon:SetClickable(false)

            local title = button:AddChild(
                Text(
                    HEADERFONT,
                    sidebar.topic_text.font_size,
                    topic.title or "",
                    LAYOUT.colours.sidebar_text
                )
            )

            title:SetRegionSize(
                text_width,
                row_height
            )
            title:SetHAlign(ANCHOR_LEFT)
            title:SetVAlign(ANCHOR_MIDDLE)
            title:SetPosition(text_center_x, 0)
            title:SetClickable(false)

            local base_on_select = button.OnSelect

            button.OnSelect = function(row)
                base_on_select(row)
                title:SetColour(
                    unpack(LAYOUT.colours.sidebar_selected_text)
                )
            end

            if topic.id == self.current_topic_id then
                button:Select()
            end

            table.insert(
                self.sidebar_rows,
                button
            )
        end
    end

    self.focus_forward = self.sidebar_rows[1]
end


-- =============================================================================
-- page
-- =============================================================================

function DST101Widget:RenderIllustration(page)
    if self.page_illustration ~= nil then
        self.page_illustration:Kill()
        self.page_illustration = nil
    end

    local illustration_name =
        page.illustration

    if illustration_name == nil
        or illustration_name == ""
    then
        return
    end

    local illustration =
        ILLUSTRATIONS.illustrations
        and ILLUSTRATIONS.illustrations[
            illustration_name
        ]
        or nil

    if illustration == nil then
        print(
            "[dst 101] missing illustration: "
            .. tostring(illustration_name)
        )

        return
    end

    local region =
        LAYOUT.regions.illustration

    if region == nil then
        return
    end

    self.page_illustration =
        self.illustration_root:AddChild(
            Image(
                illustration.atlas,
                illustration.texture
            )
        )

    self.page_illustration:ScaleToSize(
        region_width(region),
        region_height(region)
    )

    self.page_illustration:SetPosition(
        region_center_x(region),
        region_center_y(region)
    )
end


function DST101Widget:RenderRegion(
    parent,
    topic,
    page,
    region_name
)
    local region = LAYOUT.regions[region_name]

    local blocks = page.regions
        and page.regions[region_name]
        or nil

    if region == nil
        or blocks == nil
        or #blocks == 0
    then
        return
    end

    if region.mode == "box" then
        local note_animal_index = 1

        if region_name == "note" then
            local note_ordinal =
                get_note_page_ordinal(
                    self.data,
                    topic.id,
                    self.current_page
                )

            -- Only pages that actually contain notes advance the cycle.
            note_animal_index =
                (note_ordinal - 1)
                % #NOTE_ANIMAL_ORDER
                + 1
        end

        render_box_region(
            parent,
            topic,
            region,
            blocks,
            note_animal_index
        )

        return
    end

    local source_cursor_y = region.top

    -- The top-left region is editorially flexible. Opening body prose receives
    -- a small inset and vertical offset so it reads as deliberately placed
    -- prose rather than as a headline that has lost its title.
    local top_left_starts_with_text =
        region_name == "top_left"
        and blocks[1].type == "text"

    if top_left_starts_with_text then
        source_cursor_y =
            source_cursor_y +
            TOP_LEFT_TEXT_START_OFFSET
    end

    local in_opening_text_run =
        top_left_starts_with_text

    for block_index, block in ipairs(blocks) do
        local divider_key = table.concat(
            {
                topic.id or "",
                tostring(self.current_page),
                region_name,
                tostring(block_index),
            },
            "|"
        )

        local horizontal_inset = 0

        if in_opening_text_run
            and block.type == "text"
        then
            horizontal_inset =
                TOP_LEFT_TEXT_START_INSET
        else
            in_opening_text_run = false
        end

        source_cursor_y = render_flow_block(
            self,
            parent,
            topic,
            region,
            source_cursor_y,
            block,
            divider_key,
            horizontal_inset
        )
    end
end

function DST101Widget:NavigateBook(offset)
    self:StopSearchEditing()

    local topic = find_topic(
        self.data,
        self.current_topic_id
    )

    if topic == nil or topic.pages == nil then
        return false
    end

    local page_count = #topic.pages

    if page_count == 0 then
        return false
    end

    if offset < 0 then
        if self.current_page > 1 then
            self.current_page =
                self.current_page - 1

            self:RefreshPage()
            return true
        end

        -- Continue backwards through the book by opening
        -- the previous topic on its final page.
        return self:ChangeTopic(-1, "last")
    end

    if offset > 0 then
        if self.current_page < page_count then
            self.current_page =
                self.current_page + 1

            self:RefreshPage()
            return true
        end

        -- Right from the final page continues to the
        -- next topic, starting on page 1.
        return self:ChangeTopic(1)
    end

    return false
end

function DST101Widget:ChangePage(offset)
    self:StopSearchEditing()
    local topic = find_topic(
        self.data,
        self.current_topic_id
    )

    if topic == nil or topic.pages == nil then
        return
    end

    local page_count = #topic.pages

    if page_count <= 1 then
        return
    end

    local next_page = math.max(
        1,
        math.min(
            page_count,
            self.current_page + offset
        )
    )

    if next_page == self.current_page then
        return
    end

    self.current_page = next_page
    self:RefreshPage()
end


function DST101Widget:RenderFooter(parent, topic)
    local region = LAYOUT.regions.bottom_footer

    if region == nil then
        return
    end

    local pages = topic.pages or {}
    local page_count = #pages

    if page_count == 0 then
        return
    end

    local footer_y = (
        region.top +
        region.bottom
    ) / 2

    local navigation_y = footer_y - 3

    -- Single-page topics only need the decorative footer.
    if page_count == 1 then
        local divider = parent:AddChild(
            Image(
                UI_ATLAS,
                "fleur_de_lis_divider.tex"
            )
        )

        divider:ScaleToSize(
            150,
            29
        )

        divider:SetPosition(
            source_x(715),
            source_y(footer_y - 3)
        )

        divider:SetTint(
            LAYOUT.colours.body_text[1],
            LAYOUT.colours.body_text[2],
            LAYOUT.colours.body_text[3],
            1
        )

        return
    end

    local previous_enabled =
        self.current_page > 1

    local next_enabled =
        self.current_page < page_count

    local disabled_colour = {
        0.40,
        0.40,
        0.40,
        0.45,
    }

    local normal_colour =
        LAYOUT.colours.body_text

    local hover_colour = {
        1,
        0.84,
        0.38,
        1,
    }

    local function configure_button(button, enabled)
        button.scale_on_focus = false
        button.move_on_click = false

        button:ForceImageSize(
            32,
            29
        )

        button:SetImageNormalColour(
            1,
            1,
            1,
            1
        )

        button:SetImageFocusColour(
            hover_colour[1],
            hover_colour[2],
            hover_colour[3],
            hover_colour[4]
        )

        button:SetImageDisabledColour(
            disabled_colour[1],
            disabled_colour[2],
            disabled_colour[3],
            disabled_colour[4]
        )

        if enabled then
            button:Enable()
        else
            button:Disable()
        end
    end

    local previous_button = parent:AddChild(
        ImageButton(
            UI_ATLAS,
            "page_button_previous.tex"
        )
    )

    configure_button(
        previous_button,
        previous_enabled
    )

    previous_button:SetPosition(
        source_x(452),
        source_y(navigation_y)
    )

    previous_button:SetOnClick(function()
        self:ChangePage(-1)
    end)

    local previous_label = parent:AddChild(
        Text(
            BODY_FONT,
            22,
            self.data.strings.previous_page,
            LAYOUT.colours.body_text
        )
    )

    previous_label:SetRegionSize(
        110,
        28
    )
    previous_label:SetHAlign(ANCHOR_MIDDLE)
    previous_label:SetVAlign(ANCHOR_MIDDLE)
    previous_label:SetClickable(false)
    previous_label:SetPosition(
        source_x(530),
        source_y(navigation_y)
    )

    local divider = parent:AddChild(
        Image(
            UI_ATLAS,
            "fleur_de_lis_divider_asymmetric.tex"
        )
    )

    divider:ScaleToSize(
        150,
        29
    )

    divider:SetPosition(
        source_x(715),
        source_y(navigation_y)
    )

    divider:SetTint(
        LAYOUT.colours.body_text[1],
        LAYOUT.colours.body_text[2],
        LAYOUT.colours.body_text[3],
        1
    )

    local page_counter = parent:AddChild(
        Text(
            BODY_FONT,
            42,
            string.format(
                "%d / %d",
                self.current_page,
                page_count
            ),
            LAYOUT.colours.headline_text
        )
    )

    page_counter:SetRegionSize(
        120,
        52
    )
    page_counter:SetHAlign(ANCHOR_MIDDLE)
    page_counter:SetVAlign(ANCHOR_MIDDLE)
    page_counter:SetClickable(false)
    page_counter:SetPosition(
        source_x(795),
        source_y(navigation_y - 4)
    )

    local next_label = parent:AddChild(
        Text(
            BODY_FONT,
            22,
            self.data.strings.next_page,
            LAYOUT.colours.body_text
        )
    )

    next_label:SetRegionSize(
        100,
        28
    )
    next_label:SetHAlign(ANCHOR_MIDDLE)
    next_label:SetVAlign(ANCHOR_MIDDLE)
    next_label:SetClickable(false)
    next_label:SetPosition(
        source_x(890),
        source_y(navigation_y)
    )

    local next_button = parent:AddChild(
        ImageButton(
            UI_ATLAS,
            "page_button_next.tex"
        )
    )

    configure_button(
        next_button,
        next_enabled
    )

    next_button:SetPosition(
        source_x(953),
        source_y(navigation_y)
    )

    next_button:SetOnClick(function()
        self:ChangePage(1)
    end)
end

function DST101Widget:RefreshPage()
    local topic = find_topic(
        self.data,
        self.current_topic_id
    )

    if topic == nil or topic.pages == nil then
        return
    end

    local page_count = #topic.pages

    if page_count == 0 then
        return
    end

    self.current_page = math.max(
        1,
        math.min(
            self.current_page,
            page_count
        )
    )

    local page = topic.pages[self.current_page]

    self:RenderIllustration(page)

    if self.page_root ~= nil then
        self.page_root:Kill()
    end

    self.page_root = self.design_root:AddChild(
        Widget("page_root")
    )

    for _, region_name in ipairs(REGION_ORDER) do
        self:RenderRegion(
            self.page_root,
            topic,
            page,
            region_name
        )
    end

    self:RenderFooter(
        self.page_root,
        topic
    )
end


-- =============================================================================
-- input / reload
-- =============================================================================

function DST101Widget:OnControl(control, down)
    if DST101Widget._base.OnControl(
        self,
        control,
        down
    ) then
        return true
    end

    if down then
        if control == CONTROL_SCROLLBACK then
            self:ScrollTopics(-1)
            return true
        end

        if control == CONTROL_SCROLLFWD then
            self:ScrollTopics(1)
            return true
        end
    end

    return false
end

function DST101Widget:ReloadData()
    package.loaded["dst101data"] = nil
    self.data = require("dst101data")

    if find_topic(
        self.data,
        self.current_topic_id
    ) == nil
        and self.data.topics[1] ~= nil
    then
        self.current_topic_id =
            self.data.topics[1].id

        self.current_page = 1
    end

    self:RefreshPage()
    self:RefreshSidebar()
end

return DST101Widget
