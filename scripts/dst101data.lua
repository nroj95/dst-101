local TOPIC_MODULES = {
    "dst101topics/setting_out",
    "dst101topics/beefalo",
    "dst101topics/darkness",
    "dst101topics/sanity",
    "dst101topics/crafting",
    "dst101topics/food",
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
