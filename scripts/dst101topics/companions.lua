return {
    id = "companions",
    title = "Companions",
    icon = "companions",
    tags = {
        "followers",
        "allies",
        "friends",
        "pets",
        "pigmen",
    },
    pages = {
        {
            illustration = "companions_pigmen",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Bring some company",
                    },
                    {
                        type = "subtitle",
                        text = "Not every companion follows the same rules.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Followers tend to stick around longer for a certain woodsman.",
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
                            "creatures",
                            "combat",
                            "food",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "How some followers work",
                    },
                    {
                        type = "text",
                        text = [[
Some creatures can be persuaded to follow for a while. Others stay with you for different reasons, and some are better thought of as pets than helpers.

Pigs are one easy example: meat can make one friendly for a time. A friendly Pig can help in a fight, and may join in chopping after it sees you start on a tree. Other companions may want something completely different.
]],
                    },
                    {
                        type = "heading",
                        text = "Watch what they do",
                    },
                    {
                        type = "text",
                        text = [[
Followers still react to the world around them. They may notice a creature, stop to work, wander away, or eventually stop following.

Learn what kind of help a companion offers instead of assuming it will behave like the last one.
]],
                    },
                },

                note = {},
            },
        },
    },
}
