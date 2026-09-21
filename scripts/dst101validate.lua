local function authoring_error(
    topic_id,
    page_number,
    region_name,
    message
)
    error(
        string.format(
            "[dst 101] invalid handbook content: " ..
            "topic=%s page=%s region=%s: %s",
            tostring(topic_id),
            tostring(page_number),
            tostring(region_name),
            message
        ),
        2
    )
end


local function validate_headline_pair(
    topic,
    page_number,
    region_name,
    blocks
)
    for block_index, block in ipairs(blocks) do
        if block.type == "headline" then
            local next_block =
                blocks[block_index + 1]

            if next_block == nil
                or next_block.type ~= "subtitle"
            then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "headline must be immediately followed by subtitle"
                )
            end

        elseif block.type == "subtitle" then
            local previous_block =
                blocks[block_index - 1]

            if previous_block == nil
                or previous_block.type ~= "headline"
            then
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


local function validate_illustration_caption(
    topic,
    page_number,
    page
)
    local regions =
        page.regions or {}

    local caption_blocks =
        regions.illustration_caption

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

        local caption =
            caption_blocks[1]

        if caption.type ~= "caption" then
            authoring_error(
                topic.id,
                page_number,
                "illustration_caption",
                "illustration_caption block must use type 'caption'"
            )
        end

        if caption.text == nil
            or caption.text == ""
        then
            authoring_error(
                topic.id,
                page_number,
                "illustration_caption",
                "illustration caption text may not be empty"
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

local function validate_right_region(
    topic,
    page_number,
    blocks
)
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
            if previous_type == "heading"
                or (
                    previous_type ~= nil
                    and not section_has_body
                )
            then
                authoring_error(
                    topic.id,
                    page_number,
                    "right",
                    "each right-region heading must have body content"
                )
            end

            section_has_body = false

        elseif block.type == "text"
            or block.type == "bullets"
        then
            if previous_type == nil then
                authoring_error(
                    topic.id,
                    page_number,
                    "right",
                    "right-region body content requires a preceding heading"
                )
            end

            if block.type == "text"
                and previous_type == "text"
            then
                authoring_error(
                    topic.id,
                    page_number,
                    "right",
                    "consecutive text blocks are not allowed in the right region; use paragraphs inside one text block"
                )
            end

            section_has_body = true

        else
            authoring_error(
                topic.id,
                page_number,
                "right",
                "unsupported block type in right region: " ..
                tostring(block.type)
            )
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

    for block_index, block in ipairs(blocks) do
        if block.type == "heading"
            and block.text == "Related topics"
        then
            local next_block =
                blocks[block_index + 1]

            if next_block == nil
                or next_block.type ~= "related_topics"
            then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "'Related topics' heading must immediately precede related_topics"
                )
            end

        elseif block.type == "related_topics" then
            related_block_count =
                related_block_count + 1

            if region_name ~= "bottom_left" then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must be in bottom_left"
                )
            end

            if region_name == "bottom_left"
                and block_index ~= 2
            then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "bottom_left with related_topics may contain only the 'Related topics' heading and related_topics"
                )
            end

            if page_number ~= #topic.pages then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics may appear only on the final page"
                )
            end

            if block_index ~= #blocks then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must be the final block in bottom_left"
                )
            end

            local previous_block =
                blocks[block_index - 1]

            if previous_block == nil
                or previous_block.type ~= "heading"
                or previous_block.text ~= "Related topics"
            then
                authoring_error(
                    topic.id,
                    page_number,
                    region_name,
                    "related_topics must immediately follow the 'Related topics' heading"
                )
            end

            local related =
                block.topics or {}

            if #related < 2 or #related > 4 then
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
                        "related topic appears more than once: " ..
                        tostring(related_id)
                    )
                end

                if not topic_ids[related_id] then
                    authoring_error(
                        topic.id,
                        page_number,
                        region_name,
                        "unknown related topic: " ..
                        tostring(related_id)
                    )
                end

                seen_related[related_id] = true
            end
        end
    end

    return related_block_count
end


local function validate_topics(data)
    local topic_ids = {}

    for _, topic in ipairs(data.topics or {}) do
        if topic.id == nil or topic.id == "" then
            error(
                "[dst 101] invalid handbook content: topic id is missing",
                2
            )
        end

        if topic_ids[topic.id] then
            error(
                "[dst 101] invalid handbook content: duplicate topic id: " ..
                tostring(topic.id),
                2
            )
        end

        topic_ids[topic.id] = true
    end

    for _, topic in ipairs(data.topics or {}) do
        local related_block_count = 0

        for page_number, page in ipairs(
            topic.pages or {}
        ) do
            validate_illustration_caption(
                topic,
                page_number,
                page
            )

            for region_name, blocks in pairs(
                page.regions or {}
            ) do
                blocks = blocks or {}

                if region_name == "right" then
                    validate_right_region(
                        topic,
                        page_number,
                        blocks
                    )
                end

                validate_headline_pair(
                    topic,
                    page_number,
                    region_name,
                    blocks
                )

                related_block_count =
                    related_block_count +
                    validate_related_topics(
                        topic,
                        page_number,
                        region_name,
                        blocks,
                        topic_ids
                    )
            end
        end

        if related_block_count > 1 then
            error(
                "[dst 101] invalid handbook content: topic=" ..
                tostring(topic.id) ..
                " contains more than one related_topics block",
                2
            )
        end
    end
end


return validate_topics
