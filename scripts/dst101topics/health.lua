return {
    id = "health",
    title = "Health",
    icon = "health",
    tags = {
        "hp",
        "injury",
        "injuries",
        "healing",
        "wounds",
    },
    pages = {
        {
            illustration = "health_recovering",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Getting health back",
                    },
                    {
                        type = "subtitle",
                        text = "Health stays lost until you do something about it.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "That salve did not last long.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "What hurts",
                    },
                    {
                        type = "text",
                        text = table.concat({
                            "A bite is only one way to lose health. Starvation, fire, freezing, overheating, and a few unfortunate meals can do it too.",
                            "",
                            "Armor can soften ordinary physical hits, but it will not solve every kind of damage.",
                        }, "\n"),
                    },
                    {
                        type = "heading",
                        text = "How to recover",
                    },
                    {
                        type = "text",
                        text = table.concat({
                            "Food can restore health. Spider Glands can be used directly or made into Healing Salve, and most survivors can also recover health by sleeping at the cost of hunger.",
                            "",
                            "Character abilities can change the details, so food, sleep, and other recovery options do not work the same way for everyone.",
                            "",
                            "I like to keep a little healing in reserve before setting out. It is easy to need more than expected.",
                        }, "\n"),
                    },
                },

                bottom_left = {
                    {
                        type = "heading",
                        text = "Related topics",
                    },
                    {
                        type = "related_topics",
                        topics = { "food", "combat", "temperature" },
                    },
                },
            },
        },

        {
            illustration = "health_sleeping",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Sleeping",
                    },
                    {
                        type = "text",
                        text = [[
Sleeping turns hunger and time into health and sanity. That can be useful, but it is usually one recovery option among several.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Walter seems to sleep especially well in his tent.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Know what it costs",
                    },
                    {
                        type = "text",
                        text = [[
A Tent works at dusk and night. While you sleep, health and sanity recover, wetness falls, and you warm up, while hunger drains.

You are also spending time that could have been used gathering, cooking, traveling, or preparing.
]],
                    },
                    {
                        type = "heading",
                        text = "Use it when the trade helps",
                    },
                    {
                        type = "text",
                        text = [[
If food is plentiful and both health and sanity need attention, sleeping can solve several problems at once.

If only one problem needs fixing, another recovery method may let you keep moving.
]],
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
A Siesta Lean-to works during the day instead. It cools you while restoring health and sanity, with the same basic trade of time and hunger.
]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "Wickerbottom cannot sleep.",
                    },
                },
            },
        },
    },
}
