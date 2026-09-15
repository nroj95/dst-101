return {
    strings = {
        topics = "Topics",
        search_placeholder = "Search...",
        previous_page = "Previous page",
        next_page = "Next page",
    },

    topics = {
        {
            id = "getting_started",
            title = "Getting Started",
            icon = "getting_started",
            related_topic_tile = 1,
            tags = {
                "beginner",
                "basics",
                "survival",
                "first night",
                "darkness",
                "light",
                "new player",
            },
            pages = {
                {
                    regions = {
                        top_left = {
                            {
                                type = "topic_title",
                            },
                            {
                                type = "subtitle",
                                text = "A few things worth knowing before night falls.",
                            },
                        },

                        illustration_caption = {},

                        bottom_left = {
                            {
                                type = "heading",
                                text = "Related Topics",
                                divider = true,
                            },
                            {
                                type = "related_topics",
                                topics = {
                                    "sailing",
                                },
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "Darkness",
                                divider = true,
                            },
                            {
                                type = "text",
                                text = [[
Darkness is dangerous. Once night arrives, stay in the light until morning.
]],
                            },
                            {
                                type = "heading",
                                text = "No need to rush",
                                divider = true,
                            },
                            {
                                type = "text",
                                text = [[
Explore, experiment, and learn as you go.
]],
                            },
                        },

                        quote = {},
                    },
                },

            },
        },

        {
            id = "sailing",
            title = "Sailing",
            icon = "sailing",
            related_topic_tile = 2,
            tags = {
                "boat",
                "boats",
                "oar",
                "oars",
                "rowing",
                "ocean",
                "sea",
                "water",
                "anchor",
                "sail",
                "sails",
            },
            pages = {
                {
                    regions = {
                        top_left = {
                            {
                                type = "topic_title",
                            },
                            {
                                type = "subtitle",
                                text = "Getting around when dry land is far away.",
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "An oar can get a boat moving without a sail.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "heading",
                                text = "Related Topics",
                                divider = true,
                            },
                            {
                                type = "related_topics",
                                topics = {
                                    "getting_started",
                                },
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "Getting moving",
                                divider = true,
                            },
                            {
                                type = "text",
                                text = [[
Equip an Oar, stand near the edge of the boat, and row into the water.
]],
                            },
                            {
                                type = "heading",
                                text = "Key points",
                                divider = true,
                            },
                            {
                                type = "bullets",
                                items = {
                                    "Raise the anchor before trying to leave.",
                                    "Your position affects the direction of the stroke.",
                                    "Oars are best for precise movement and corrections.",
                                },
                            },
                            {
                                type = "heading",
                                text = "Longer journeys",
                                divider = true,
                            },
                            {
                                type = "text",
                                text = [[
For travelling longer distances, sails provide continuous movement.
]],
                            },
                        },

                        quote = {
                            {
                                type = "quote",
                                text = "Even without a sail, you are not necessarily stranded.",
                            },
                        },
                    },
                },

            },
        },
    },
}
