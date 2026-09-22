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
                        type = "text",
                        text = [[
Bring a light you can carry if you expect to keep moving into the night. You do not need it during dusk, so save it until the world goes dark.
]],
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
Make another source of light or reach one quickly. Complete darkness is not a safe place to wait and think.
]],
                    },
                    {
                        type = "heading",
                        text = "Stopping for the night",
                    },
                    {
                        type = "text",
                        text = [[
A fire gives you somewhere bright to spend the night. Portable light lets the journey continue.
]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "Something watched from beyond the light. I chose not to investigate.",
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
                        text = "As sanity falls, strange shadows may begin appearing. They do not all behave the same way.",
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
                        text = "Some shadows retreat when you approach. Pay attention to what they actually do before deciding how to respond.\n\nAt very low sanity, some become tangible and attack. What only watched from a distance before may not stay harmless.",
                    },
                },
            },
        },
    },
}
