local TOPIC_MODULES = {
    -- getting started
    "dst101topics/setting_out",
    "dst101topics/survivors",
    "dst101topics/teamwork",
    "dst101topics/exploration",
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
    "dst101topics/combat",
    "dst101topics/hounds",

    -- changing conditions
    "dst101topics/seasons",
    "dst101topics/temperature",
    "dst101topics/wetness",

    -- larger expeditions
    "dst101topics/sailing",
    "dst101topics/beefalo",
    "dst101topics/caves",
}


local data = {
    strings = {
        topics = "Topics",
        search_placeholder = "Search...",
        previous_page = "Previous page",
        next_page = "Next page",
    },

    topics = {},
}


for _, module_name in ipairs(TOPIC_MODULES) do
    data.topics[#data.topics + 1] =
        require(module_name)
end


require("dst101validate")(data)

return data
