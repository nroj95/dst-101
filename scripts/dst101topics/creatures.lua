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
                        text = "Not every creature reacts to you the same way.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "He stayed back and watched what they did.",
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
                            "companions",
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

Who you are can matter too. Some creatures treat certain survivors differently.

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
If you want a closer look, leave yourself room to back away. What seemed harmless from a distance may behave differently once you get involved.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "creatures_naughtiness",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Leave some creatures alone",
                    },
                    {
                        type = "text",
                        text = [[
Not every harmless creature needs to become food or materials. The world quietly keeps track when you kill creatures it treats as innocent.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "That sound started after the last one.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "The world notices",
                    },
                    {
                        type = "text",
                        text = [[
This hidden value is called Naughtiness. Some innocent creatures count more than others, and it belongs to the player who made the kill.

Leave them alone for a while and it gradually falls again.
]],
                    },
                    {
                        type = "heading",
                        text = "If you keep going",
                    },
                    {
                        type = "text",
                        text = [[
As Naughtiness rises, kills may be followed by an unusual hissing sound that grows more threatening as you get closer to the limit.

That is your warning. You can leave the wildlife alone for a while, or keep going if you are willing to deal with whatever comes looking.
]],
                    },
                },

                note = {},
            },
        },
    },
}
