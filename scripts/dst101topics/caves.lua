return {
    id = "caves",
    title = "Caves",
    icon = "caves",
    tags = {
        "underground",
        "sinkhole",
        "sinkholes",
    },

    pages = {
        {
            illustration = "caves_first_descent",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Before you go below",
                    },
                    {
                        type = "subtitle",
                        text = "Take enough light and supplies for the way back.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The daylight ended sooner than I expected.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
A plugged Sinkhole can be opened with a pickaxe. The stairs lead into the caves, and the stairway below leads back to the surface.
]],
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Bring dependable light",
                    },
                    {
                        type = "text",
                        text = [[
There is some daylight around the stairway, but it does not follow you. Bring a light you can rely on, plus enough fuel or materials to replace it.
]],
                    },
                    {
                        type = "heading",
                        text = "Keep the first trip simple",
                    },
                    {
                        type = "text",
                        text = [[
Food, healing, armor, and a few basic tools are plenty for a first look. Check your map before wandering far from the stairs, and leave some light and supplies for the return trip.

You can always come back after you know what you actually need.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "caves_nightmare_cycle",

            regions = {
                top_left = {
                    {
                        type = "text",
                        text = [[
Some deeper places change on their own. If the red lights and fissures start growing more active, pay attention.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I noticed the red glow before the shadows appeared.",
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
                            "darkness",
                            "sanity",
                            "combat",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "The nightmare cycle",
                    },
                    {
                        type = "text",
                        text = [[
At their worst, those lights and fissures can release hostile Shadow Creatures even when your sanity is fine.

The danger settles again later.
]],
                    },
                    {
                        type = "heading",
                        text = "You can wait",
                    },
                    {
                        type = "text",
                        text = [[
If an area suddenly becomes much more dangerous, backing out and waiting for the cycle to ease is a reasonable choice. You do not have to fight everything that appears.
]],
                    },
                },

                note = {},
            },
        },
    },
}
