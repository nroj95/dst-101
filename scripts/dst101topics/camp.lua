return {
    id = "camp",
    title = "Camp",
    icon = "camp",
    tags = {
        "base",
        "home",
        "campfire",
        "shelter",
    },
    pages = {
        {
            illustration = "camp_home",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "A place to come back to",
                    },
                    {
                        type = "subtitle",
                        text = "It only needs to be useful for now.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I came back here more often than I expected.",
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
                            "crafting",
                            "food",
                            "seasons",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Pick what helps nearby",
                    },
                    {
                        type = "text",
                        text = [[
Your first camp does not need to become your permanent home. A place to leave supplies, cook, craft, and recover is already useful.

I like some room around camp and a few useful things within easy reach. Paths, food, materials, and whatever you are exploring next can all matter.

Different trips make different places convenient.
]],
                    },
                    {
                        type = "heading",
                        text = "You can move later",
                    },
                    {
                        type = "text",
                        text = [[
If another part of the world becomes more useful, build there too or move on. I still carry enough light and basic supplies to handle an unexpected night away from camp.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "camp_safety",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Camp safety",
                    },
                    {
                        type = "text",
                        text = [[
Useful things have a habit of collecting in one place. I leave some room between important structures, especially where fire or a fight could spread.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I left first. I could sort out the camp afterward.",
                    },
                },


                right = {
                    {
                        type = "heading",
                        text = "Keep a few things elsewhere",
                    },
                    {
                        type = "text",
                        text = [[
I do not like every useful thing living in one place. A few basics carried with you, or a small spare supply somewhere else, can make recovery much easier.
]],
                    },
                    {
                        type = "heading",
                        text = "If camp stops being safe",
                    },
                    {
                        type = "text",
                        text = [[
You do not have to defend it immediately. Get clear, recover, then decide when it is worth going back.
]],
                    },
                },

                note = {},
            },
        },
    },
}
