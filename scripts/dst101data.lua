local TOPIC_MODULES = {
    "dst101topics/setting_out",
    "dst101topics/darkness",
    "dst101topics/fire",
    "dst101topics/food",
    "dst101topics/health",
    "dst101topics/death",
    "dst101topics/sanity",
    "dst101topics/crafting",
    "dst101topics/camp",
    "dst101topics/storage",
    "dst101topics/gathering",
    "dst101topics/exploration",
    "dst101topics/creatures",
    "dst101topics/companions",
    "dst101topics/combat",
    "dst101topics/hounds",
    "dst101topics/temperature",
    "dst101topics/wetness",
    "dst101topics/seasons",
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
