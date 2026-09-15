local Image = require("widgets/image")
local ImageButton = require("widgets/imagebutton")
local Text = require("widgets/text")
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
        spacing = 13,
    },

    heading = {
        font = HEADERFONT,
        colour = LAYOUT.colours.headline_text,
        size = 36,
        spacing = 13,
    },

    text = {
        font = BODY_FONT,
        colour = LAYOUT.colours.body_text,
        size = 24,
        spacing = 17,
    },

    bullets = {
        font = BODY_FONT,
        colour = LAYOUT.colours.body_text,
        size = 24,
        spacing = 17,
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

local function add_divider(parent, region, source_cursor_y)
    local divider_index = math.random(1, 6)

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
        region_center_x(region),
        source_y(
            source_cursor_y +
            divider_height / 2
        )
    )

    return source_cursor_y +
        divider_height +
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

    local tile_size = 76
    local icon_size = 50
    local label_height = 20
    local label_gap = 1
    local column_gap = 14
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
            region.left +
            (
                available_width -
                row_width
            ) / 2

        local tile_center_x =
            row_left +
            column * (
                tile_size +
                column_gap
            ) +
            tile_size / 2

        local row_top =
            source_cursor_y -
            12 +
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
            LAYOUT.colours.body_text[1],
            LAYOUT.colours.body_text[2],
            LAYOUT.colours.body_text[3],
            0.95
        )

        icon:SetClickable(false)
        icon:SetPosition(0, 3)

        local label = parent:AddChild(
            Text(
                BODY_FONT,
                17,
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
    block
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
            source_cursor_y
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

    local _, height = text:GetRegionSize()

    -- Keep the full authored region width so left alignment is meaningful.
    text:SetRegionSize(width, height)

    text:SetPosition(
        region_center_x(region),
        source_y(source_cursor_y + height / 2)
    )

    source_cursor_y = source_cursor_y + height

    if block.divider then
        source_cursor_y = add_divider(
            parent,
            region,
            source_cursor_y + 2
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

    self:ReloadData()
end)


-- =============================================================================
-- sidebar
-- =============================================================================

function DST101Widget:SetCurrentTopic(topic_id)
    if find_topic(self.data, topic_id) == nil then
        return
    end

    self.current_topic_id = topic_id
    self.current_page = 1

    self:RefreshPage()
    self:RefreshSidebar()
end

function DST101Widget:ScrollTopics(offset)
    local topics = self.data.topics or {}
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

        local topic = self.data.topics[topic_index]

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

            button:SetOnClick(function()
                self:SetCurrentTopic(topic.id)
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

    for _, block in ipairs(blocks) do
        source_cursor_y = render_flow_block(
            self,
            parent,
            topic,
            region,
            source_cursor_y,
            block
        )
    end
end

function DST101Widget:ChangePage(offset)
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
            240,
            46
        )

        divider:SetPosition(
            source_x(755),
            source_y(footer_y - 8)
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
            normal_colour[1],
            normal_colour[2],
            normal_colour[3],
            normal_colour[4]
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
        source_x(700),
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
            21,
            string.format(
                "%d / %d",
                self.current_page,
                page_count
            ),
            LAYOUT.colours.headline_text
        )
    )

    page_counter:SetRegionSize(
        64,
        28
    )
    page_counter:SetHAlign(ANCHOR_MIDDLE)
    page_counter:SetVAlign(ANCHOR_MIDDLE)
    page_counter:SetClickable(false)
    page_counter:SetPosition(
        source_x(805),
        source_y(navigation_y)
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
        source_x(870),
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
        source_x(933),
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















