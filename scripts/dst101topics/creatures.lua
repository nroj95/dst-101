return {
    id = "creatures",
    title = "Creatures",
    icon = "creatures",
    tags = {
        "animals",
        "hostile",
        "neutral",
        "peaceful",
    },
    pages = {
        {
            illustration = "creatures_observation",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Give it a moment",
                    },
                    {
                        type = "subtitle",
                        text = "Not every creature wants the same thing from you.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Much easier to think when I watch first.",
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
                            "combat",
                            "beefalo",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Watch before you approach",
                    },
                    {
                        type = "text",
                        text = [[
Some creatures are content to ignore you. Others care very much about how close you get, what you touch, or what is happening around them.

Stay far enough away to see what a creature does before you decide what to do with it. Notice whether it ignores you, follows you, warns you off, or becomes aggressive when you get closer.

Sometimes I watch for a moment and decide there is no reason to bother it.
]],
                    },
                    {
                        type = "heading",
                        text = "Leave room to change your mind",
                    },
                    {
                        type = "text",
                        text = [[
If you want a closer look, make sure you can back away again. What seemed harmless from a distance may behave differently once you get involved.
]],
                    },
                },

                note = {},
            },
        },
    },
}
