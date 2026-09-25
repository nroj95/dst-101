return {
    id = "darkness",
    title = "Darkness",
    icon = "darkness",
    tags = {
        "beginner",
    },
    pages = {
        {
            illustration = "darkness",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Keep a light handy",
                    },
                    {
                        type = "subtitle",
                        text = "Night is manageable. Complete darkness is another matter.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The torch was enough to keep moving.",
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
                            "fire",
                            "sanity",
                            "caves",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "If the light goes out",
                    },
                    {
                        type = "text",
                        text = [[
Make another source of light or reach one quickly. Complete darkness becomes dangerous very quickly.
]],
                    },
                    {
                        type = "heading",
                        text = "Stopping for the night",
                    },
                    {
                        type = "text",
                        text = [[
A fire gives you somewhere bright to spend the night. Portable light lets the journey continue after dusk. Dusk itself is still safe without it.
]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "Something kept moving just beyond the firelight.",
                    },
                },
            },
        },

        {
            illustration = "darkness_shadow_hand",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Shadow creatures",
                    },
                    {
                        type = "text",
                        text = "Some shadows can start appearing before sanity gets especially low. They do not all behave the same way.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I noticed the hand just before it reached the flames.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "When one reaches for the fire",
                    },
                    {
                        type = "text",
                        text = "If a shadowy hand creeps toward the flames, step toward it. It will pull back. Keep following it away from the fire and it eventually disappears.",
                    },
                    {
                        type = "heading",
                        text = "Watch what changes",
                    },
                    {
                        type = "text",
                        text = "Some shadows retreat when you approach.\n\nAt very low sanity, some become tangible and attack. What only watched from a distance before may not stay harmless.",
                    },
                },
            },
        },
    },
}
