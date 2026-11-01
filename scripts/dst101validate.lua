-- =============================================================================
-- dst 101 authoring validation
--
-- returns a function that checks the loaded handbook data and raises an
-- error naming the topic, page and region of the first broken rule. the
-- rules are the authoring grammar in docs/development.md: known regions
-- and block types, headline/subtitle pairs, page_heading placement,
-- captions for illustrated pages, right-column heading/body structure,
-- and related-topic placement and links.
-- =============================================================================

-- Level 0: the message names the content location, and the line inside
-- this validator would only mislead.
local function content_error(message)
    error("[dst 101] invalid handbook content: " .. message, 0)
end

local function authoring_error(topic_id, page_number, region_name, message)
    content_error(
        string.format(
            "topic=%s page=%s region=%s: %s",
            tostring(topic_id),
            tostring(page_number),
            tostring(region_name),
            message
        )
    )
end

-- Block types each region renders. Anything else would silently vanish.
local REGION_BLOCK_TYPES = {
    top_left = {
        headline = true,
        subtitle = true,
        page_heading = true,
        heading = true,
        text = true,
        bullets = true,
    },
    illustration_caption = {
        caption = true,
    },
    bottom_left = {
        text = true,
        bullets = true,
        related_topics = true,
    },
    right = {
        heading = true,
        text = true,
        bullets = true,
    },
    note = {
        note = true,
    },
}

local function validate_block_types(topic, page_number, region_name, blocks)
    local allowed = REGION_BLOCK_TYPES[region_name]

    if allowed == nil then
        authoring_error(topic.id, page_number, region_name, "unknown region")
    end

    -- The note strip shows a single note.
    if region_name == "note" and #blocks > 1 then
        authoring_error(
            topic.id,
            page_number,
            region_name,
            "note region may contain at most one note"
        )
    end

    for _, block in ipairs(blocks) do
        -- Headlines fall back to the topic title; related topics and
        -- bullets carry lists instead of text.
        if block.type == "bullets" then
            if type(block.items) ~= "table" or #block.items == 0 then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "bullets need at least one item"
                )
            end
        elseif
            block.type ~= "headline"
            and block.type ~= "related_topics"
            and (type(block.text) ~= "string" or block.text == "")
        then
            authoring_error(
                topic.id,
                page_number,
                region_name,
                "empty " .. tostring(block.type) .. " block"
            )
        end

        if not allowed[block.type] then
            authoring_error(
                topic.id,
                page_number,
                region_name,
                "unsupported block type: " .. tostring(block.type)
            )
        end
    end
end

local function validate_headline_pair(topic, page_number, region_name, blocks)
    for block_index, block in ipairs(blocks) do
        if block.type == "headline" then
            local next_block = blocks[block_index + 1]

            if next_block == nil or next_block.type ~= "subtitle" then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "headline must be immediately followed by subtitle"
                )
            end
        elseif block.type == "subtitle" then
            local previous_block = blocks[block_index - 1]

            if previous_block == nil or previous_block.type ~= "headline" then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "subtitle must immediately follow headline"
                )
            end
        end
    end
end

local function validate_page_heading(topic, page_number, region_name, blocks)
    for block_index, block in ipairs(blocks) do
        if block.type == "page_heading" then
            if region_name ~= "top_left" then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "page_heading may only appear in top_left"
                )
            end

            if page_number == 1 then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "page_heading is reserved for secondary pages"
                )
            end

            if block_index ~= 1 then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "page_heading must be the first top_left block"
                )
            end
        end
    end
end

local function validate_illustration_caption(topic, page_number, page)
    local regions = page.regions

    local caption_blocks = regions.illustration_caption

    if page.illustration ~= nil then
        if caption_blocks == nil then
            authoring_error(
                topic.id,
                page_number,
                "illustration_caption",
                "illustrated page must have an illustration_caption region"
            )
        end

        if #caption_blocks ~= 1 then
            authoring_error(
                topic.id,
                page_number,
                "illustration_caption",
                "illustration_caption must contain exactly one block"
            )
        end

        local caption = caption_blocks[1]

        if caption.type ~= "caption" then
            authoring_error(
                topic.id,
                page_number,
                "illustration_caption",
                "illustration_caption block must use type 'caption'"
            )
        end
    elseif caption_blocks ~= nil then
        authoring_error(
            topic.id,
            page_number,
            "illustration_caption",
            "illustration_caption requires a page illustration"
        )
    end
end

local function validate_right_region(topic, page_number, blocks)
    if #blocks == 0 then
        return
    end

    if blocks[1].type ~= "heading" then
        authoring_error(
            topic.id,
            page_number,
            "right",
            "right region must begin with a heading"
        )
    end

    local section_has_body = false
    local previous_type = nil

    for _, block in ipairs(blocks) do
        if block.type == "heading" then
            if
                previous_type == "heading"
                or (previous_type ~= nil and not section_has_body)
            then
                authoring_error(
                    topic.id,
                    page_number,
                    "right",
                    "each right-region heading must have body content"
                )
            end

            section_has_body = false
        elseif block.type == "text" or block.type == "bullets" then
            if previous_type == nil then
                authoring_error(
                    topic.id,
                    page_number,
                    "right",
                    "right-region body content requires a preceding heading"
                )
            end

            if block.type == "text" and previous_type == "text" then
                authoring_error(
                    topic.id,
                    page_number,
                    "right",
                    "consecutive text blocks are not allowed in the right region; use paragraphs inside one text block"
                )
            end

            section_has_body = true
        end

        previous_type = block.type
    end

    if not section_has_body then
        authoring_error(
            topic.id,
            page_number,
            "right",
            "final right-region heading must have body content"
        )
    end
end

local function validate_related_topics(
    topic,
    page_number,
    region_name,
    blocks,
    topic_ids
)
    local related_block_count = 0

    for _, block in ipairs(blocks) do
        if block.type == "related_topics" then
            related_block_count = related_block_count + 1

            if region_name ~= "bottom_left" then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must be in bottom_left"
                )
            end

            -- The renderer adds the translated heading above the tiles.
            if #blocks ~= 1 then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must be the only block in bottom_left"
                )
            end

            if page_number ~= 1 then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must be on page 1"
                )
            end

            local related = block.topics

            if type(related) ~= "table" or #related < 2 or #related > 4 then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must contain 2-4 topics"
                )
            end

            local seen_related = {}

            for _, related_id in ipairs(related) do
                if related_id == topic.id then
                    authoring_error(
                        topic.id,
                        page_number,
                        region_name,
                        "topic may not link to itself"
                    )
                end

                if seen_related[related_id] then
                    authoring_error(
                        topic.id,
                        page_number,
                        region_name,
                        "related topic appears more than once: "
                            .. tostring(related_id)
                    )
                end

                if not topic_ids[related_id] then
                    authoring_error(
                        topic.id,
                        page_number,
                        region_name,
                        "unknown related topic: " .. tostring(related_id)
                    )
                end

                seen_related[related_id] = true
            end
        end
    end

    return related_block_count
end

-- The fields the renderer reads without checking.
local function validate_topic_structure(topic)
    for _, field in ipairs({ "title", "icon" }) do
        if type(topic[field]) ~= "string" or topic[field] == "" then
            content_error("topic=" .. topic.id .. " is missing its " .. field)
        end
    end

    if type(topic.pages) ~= "table" or #topic.pages == 0 then
        content_error("topic=" .. topic.id .. " needs at least one page")
    end

    for page_number, page in ipairs(topic.pages) do
        if type(page.regions) ~= "table" then
            authoring_error(
                topic.id,
                page_number,
                nil,
                "page needs a regions table"
            )
        end
    end
end

local function validate_topics(data)
    local topic_ids = {}

    for _, topic in ipairs(data.topics) do
        if type(topic.id) ~= "string" or topic.id == "" then
            content_error("topic id is missing")
        end

        if topic_ids[topic.id] then
            content_error("duplicate topic id: " .. topic.id)
        end

        topic_ids[topic.id] = true

        validate_topic_structure(topic)
    end

    for _, topic in ipairs(data.topics) do
        local related_block_count = 0

        for page_number, page in ipairs(topic.pages) do
            validate_illustration_caption(topic, page_number, page)

            for region_name, blocks in pairs(page.regions) do
                validate_block_types(topic, page_number, region_name, blocks)

                if region_name == "right" then
                    validate_right_region(topic, page_number, blocks)
                end

                validate_headline_pair(topic, page_number, region_name, blocks)

                validate_page_heading(topic, page_number, region_name, blocks)

                related_block_count = related_block_count
                    + validate_related_topics(
                        topic,
                        page_number,
                        region_name,
                        blocks,
                        topic_ids
                    )
            end
        end

        if related_block_count > 1 then
            content_error(
                "topic="
                    .. topic.id
                    .. " contains more than one related_topics block"
            )
        end
    end
end

return validate_topics
