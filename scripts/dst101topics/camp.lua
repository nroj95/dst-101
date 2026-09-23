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
                        text = "It only needs to work for now.",
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
Your first camp does not need to become your permanent home. A place to leave supplies, cook, craft, and recover is already enough.

I like some room around camp and the things I use often within easy reach. Paths, food, materials, and whatever you are exploring next can all matter.

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
If another part of the world becomes more convenient, build there too or move on. I still carry enough light and basic supplies to handle an unexpected night away from camp.
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
Supplies and structures have a habit of collecting in one place. I leave some room between important structures, especially where fire or a fight could spread.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The camp could wait until it was safe to go back.",
                    },
                },


                right = {
                    {
                        type = "heading",
                        text = "A backup away from camp",
                    },
                    {
                        type = "text",
                        text = [[
I do not like all my important supplies in one place. A few basics carried with you, or a small spare supply somewhere else, can make recovery much easier.
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
