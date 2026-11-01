-- =============================================================================
-- dst 101 handbook data
--
-- loads the handbook in one language: the interface strings and the topic
-- modules in sidebar order, then checks the result with dst101validate.lua.
-- an authoring error stops the handbook from opening, with a message naming
-- the topic, page and region.
--
-- English is the source. dst101translations.lua lists each translation and
-- the topics it covers; anything it does not translate stays English, so a
-- translation can grow one topic at a time.
--
-- sidebar order is loose thematic grouping, not a progression path.
-- tools/handbook_overview.ps1 also reads TOPIC_MODULES, so keep one module
-- per line.
-- =============================================================================

local TRANSLATIONS = require("dst101translations")

local TOPIC_MODULES = {
    -- getting started
    "dst101topics/setting_out",
    "dst101topics/survivors",
    "dst101topics/exploration",
    "dst101topics/biomes",
    "dst101topics/teamwork",
    "dst101topics/darkness",
    "dst101topics/fire",
    "dst101topics/food",
    "dst101topics/health",
    "dst101topics/death",
    "dst101topics/sanity",

    -- making and keeping things
    "dst101topics/gathering",
    "dst101topics/crafting",
    "dst101topics/camp",
    "dst101topics/storage",
    "dst101topics/equipment",

    -- getting food and using the world
    "dst101topics/farming",
    "dst101topics/fishing",
    "dst101topics/hunting",

    -- living things and danger
    "dst101topics/creatures",
    "dst101topics/companions",
    "dst101topics/merms",
    "dst101topics/combat",
    "dst101topics/spiders",
    "dst101topics/bees",
    "dst101topics/hounds",
    "dst101topics/giants",

    -- changing conditions
    "dst101topics/seasons",
    "dst101topics/temperature",
    "dst101topics/wetness",

    -- larger expeditions
    "dst101topics/sailing",
    "dst101topics/beefalo",
    "dst101topics/caves",
    "dst101topics/mysteries",
    "dst101topics/credits",
}

local ENGLISH_STRINGS = {
    show_handbook = "Show Handbook",
    topics = "Topics",
    contents = "Contents",
    page = "Page %d",
    search_placeholder = "Search...",
    no_matches = "No matches",
    related_topics = "Related topics",
    previous_page = "Previous page",
    next_page = "Next page",
}

local function translation_error(language, message)
    error("[dst 101] invalid " .. language .. " translation: " .. message, 0)
end

local loaded = {}

local M = {}

function M.load_strings(language)
    local strings = {}

    for key, text in pairs(ENGLISH_STRINGS) do
        strings[key] = text
    end

    if TRANSLATIONS[language] ~= nil then
        local translated =
            require("dst101translations/" .. language .. "/strings")

        for key, text in pairs(translated) do
            if ENGLISH_STRINGS[key] == nil then
                translation_error(language, "unknown string " .. key)
            end

            strings[key] = text
        end
    end

    return strings
end

-- Validates once per language and session.
function M.load(language)
    if TRANSLATIONS[language] == nil then
        language = "en"
    end

    if loaded[language] ~= nil then
        return loaded[language]
    end

    local translated_topics = {}

    for _, topic_id in ipairs(TRANSLATIONS[language] or {}) do
        translated_topics[topic_id] = true
    end

    local data = {
        strings = M.load_strings(language),
        topics = {},
    }

    for _, module_name in ipairs(TOPIC_MODULES) do
        local topic_id = module_name:match("[^/]+$")
        local topic

        if translated_topics[topic_id] then
            translated_topics[topic_id] = nil

            topic =
                require("dst101translations/" .. language .. "/" .. topic_id)

            if topic.id ~= topic_id then
                translation_error(language, topic_id .. " must keep its id")
            end
        else
            topic = require(module_name)
        end

        data.topics[#data.topics + 1] = topic
    end

    local unknown_topic = next(translated_topics)

    if unknown_topic ~= nil then
        translation_error(language, "unknown topic " .. unknown_topic)
    end

    require("dst101validate")(data)

    loaded[language] = data

    return data
end

return M
