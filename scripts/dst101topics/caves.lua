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
                        text = "Bring dependable light",
                    },
                    {
                        type = "text",
                        text = [[
A plugged Sinkhole can be opened with a pickaxe. The stairs lead into the caves, and the stairway below leads back to the surface.

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
                        type = "page_heading",
                        text = "The Nightmare Cycle",
                    },
                    {
                        type = "text",
                        text = [[
Red lights and fissures can grow brighter and more active before the dangerous phase begins.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I noticed the red glow before the shadows appeared.",
                    },
                },


                right = {
                    {
                        type = "heading",
                        text = "Read the warning",
                    },
                    {
                        type = "text",
                        text = [[
The stronger the red glow becomes, the more dangerous the cycle is getting. Nightmare lights can also drain sanity while they are active.
]],
                    },
                    {
                        type = "heading",
                        text = "When it peaks",
                    },
                    {
                        type = "text",
                        text = [[
At its worst, nightmare lights and fissures can release hostile Shadow Creatures even when your sanity is fine. The cycle eventually settles again, and those creatures disappear with it.
]],
                    },
                },

                note = {},
            },
        },
    },
}
