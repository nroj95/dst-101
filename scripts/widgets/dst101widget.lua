local Image = require("widgets/image")
local ImageButton = require("widgets/imagebutton")
local Text = require("widgets/text")
local TextEdit = require("widgets/textedit")
local Widget = require("widgets/widget")

local LAYOUT = require("dst101layout")

local BACKDROP_ATLAS = "images/ui/base_template.xml"
local BACKDROP_TEXTURE = "base_template.tex"

local TOPIC_ATLAS = "images/topics/dst101_topics_color.xml"
local TOPIC_GRAY_ATLAS = "images/topics/dst101_topics_gray.xml"
local UI_ATLAS = "images/ui/dst101_ui.xml"

local BODY_FONT = "dst101_alegreya_regular"
local ITALIC_FONT = "dst101_alegreya_italic"

local BLOCK_STYLES = {
    topic_title = {
        font = HEADERFONT,
        colour = LAYOUT.colours.headline_text,
        size = 64,
        spacing = 7,
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

    quote = {
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
    "quote",
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
    if block.type == "topic_title" then
        return topic.title or ""
    end

    if block.type == "quote" then
        return '"' .. (block.text or "") .. '"'
    end

    if block.type == "bullets" then
        local lines = {}

        for _, item in ipairs(block.items or {}) do
            table.insert(lines, "◆  " .. item)
        end

        return table.concat(lines, "\n")
    end

    return block.text or ""
end


-- =============================================================================
-- generic page-content rendering
-- =============================================================================

local function get_divider_index(key)
    local hash = 0

    for index = 1, #key do
        hash = (
            hash * 31 +
            string.byte(key, index)
        ) % 2147483647
    end

    return hash % 6 + 1
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
        divider_width * 26 / 496

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
    local tile_index = tonumber(
        topic.related_topic_tile
    ) or 1

    tile_index = math.max(
        1,
        math.min(
            6,
            math.floor(tile_index)
        )
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
    local column_gap = 34
    local row_gap = 12
    local maximum_columns = 4

    local available_width =
        region_width(region)

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
            region.left

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
        icon:SetPosition(0, 3)

        local label = parent:AddChild(
            Text(
                BODY_FONT,
                19,
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

local function render_flow_block(
    handbook,
    parent,
    topic,
    region,
    source_cursor_y,
    block,
    divider_key
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
    local width = block.width or region_width(region)

    text:SetHAlign(ANCHOR_LEFT)
    text:SetVAlign(ANCHOR_TOP)
    text:SetClickable(false)

    -- Page length intentionally stays under manual author control.
    text:SetMultilineTruncatedString(
        value,
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
        region_center_x(region),
        source_y(
            source_cursor_y +
            measured_height / 2
        )
    )

    source_cursor_y =
        source_cursor_y + layout_height

    if block.divider then
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
    blocks
)
    local block = blocks[1]

    if block == nil then
        return
    end

    local style = BLOCK_STYLES[block.type]

    if style == nil then
        return
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

    if block.type == "caption" then
        text:SetTruncatedString(
            value,
            width,
            nil,
            false
        )
    elseif block.type == "quote" then
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
        region_center_x(region),
        region_center_y(region)
    )
end


-- =============================================================================
-- widget
-- =============================================================================

local DST101Widget = Class(Widget, function(self, owner)
    Widget._ctor(self, "DST101Widget")

    self.owner = owner
    self.current_topic_id = "sailing"
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
            "magnifying_glass.tex"
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

function DST101Widget:ScrollTopics(offset)
    local topics = self:GetSidebarTopics()
    local visible_count = #LAYOUT.sidebar.topic_rows

    local maximum_start = math.max(
        1,
        #topics - visible_count + 1
    )

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

function DST101Widget:RefreshSidebar()
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
        render_box_region(
            parent,
            topic,
            region,
            blocks
        )

        return
    end

    local source_cursor_y = region.top

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

        source_cursor_y = render_flow_block(
            self,
            parent,
            topic,
            region,
            source_cursor_y,
            block,
            divider_key
        )
    end
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
        0.55,
        0.55,
        0.55,
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

    local previous_colour =
        previous_enabled
        and LAYOUT.colours.body_text
        or disabled_colour

    local previous_label = parent:AddChild(
        Text(
            BODY_FONT,
            20,
            self.data.strings.previous_page,
            previous_colour
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

    local next_colour =
        next_enabled
        and LAYOUT.colours.body_text
        or disabled_colour

    local next_label = parent:AddChild(
        Text(
            BODY_FONT,
            20,
            self.data.strings.next_page,
            next_colour
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
