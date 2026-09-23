return {
    id = "storage",
    title = "Storage",
    icon = "storage",
    tags = {
        "inventory",
        "chest",
        "chests",
        "containers",
        "backpack",
        "ground",
        "piles",
    },
    pages = {
        {
            illustration = "storage_supplies",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Leave some things behind",
                    },
                    {
                        type = "subtitle",
                        text = "You do not need to carry every useful thing at once.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I keep the food cold and the bulky things where I can reach them.",
                    },
                },

                bottom_left = {
                    {
                        type = "heading",
                        text = "Related topics",
                    },
                    {
                        type = "related_topics",
                        topics = {
                            "camp",
                            "crafting",
                            "food",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Pack for where you are going",
                    },
                    {
                        type = "text",
                        text = [[
Light, food, tools, and protection all compete for space. A Backpack adds room, but it shares the body slot with armor and seasonal clothing.

Take what this trip needs and leave some room for what you find.
]],
                    },
                    {
                        type = "heading",
                        text = "Chests and ground piles",
                    },
                    {
                        type = "text",
                        text = [[
Chests are useful, but ground piles work well for common materials.

Put the things you use often somewhere easy to find. Use whatever arrangement works for you.
]],
                    },
                },
                note = {
                    {
                        type = "note",
                        text = "Some creatures are surprisingly interested in other people's things.",
                    },
                },
            },
        },
    },
}
