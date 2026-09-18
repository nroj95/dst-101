local TOPIC_MODULES = {
    "dst101topics/setting_out",
    "dst101topics/darkness",
    "dst101topics/food",
    "dst101topics/health",
    "dst101topics/sanity",
    "dst101topics/crafting",
    "dst101topics/combat",
    "dst101topics/temperature",
    "dst101topics/beefalo",
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
