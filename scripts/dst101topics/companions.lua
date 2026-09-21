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
                        text = "I had not planned on bringing company.",
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
                        text = "Company comes in different forms",
                    },
                    {
                        type = "text",
                        text = [[
Some creatures can be persuaded to follow for a while. Others stay with you for different reasons, and some are better thought of as pets than helpers.

Pigs are one easy example: meat can make one friendly for a time. Other companions may want something completely different.
]],
                    },
                    {
                        type = "heading",
                        text = "See what kind of help they offer",
                    },
                    {
                        type = "text",
                        text = [[
A companion might help in a fight, carry things, work nearby, or simply follow along. It may wander off, react to something nearby, or stop following later.

Keep an eye on what they are doing. Do not assume every companion behaves the same way.
]],
                    },
                },

                note = {},
            },
        },
    },
}
