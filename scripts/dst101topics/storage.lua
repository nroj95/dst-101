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
                        text = "I knew where most of it was.",
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
Light, food, tools, protection, and spare materials can all be useful. A backpack gives you more room, but even that fills quickly.

Take what seems useful for this trip. Leave some space for what you find; the rest can wait at camp.
]],
                    },
                    {
                        type = "heading",
                        text = "Keep things where you can find them",
                    },
                    {
                        type = "text",
                        text = [[
Chests are useful, but ground piles can keep common materials easy to see and grab. Dropped items are less protected, and some creatures may carry them away.

Some containers have special uses. An Ice Box keeps food and slows spoilage.

Use whatever arrangement helps you find things quickly.
]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "Stop leaving the loose rocks outside.",
                    },
                },
            },
        },
    },
}
