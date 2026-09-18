return {
    id = "fire",
    title = "Fire",
    icon = "fire",

    tags = {
        "campfire",
        "fire pit",
        "fuel",
    },

    pages = {
        {
            illustration = "fire_tending",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Keep it burning",
                    },
                    {
                        type = "subtitle",
                        text = "A useful fire still needs fuel, space, and a little attention.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Useful flame. I may have added a little too much fuel.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Campfire or fire pit?",
                    },
                    {
                        type = "text",
                        text = [[A campfire is quick and temporary. Once it burns out, it is gone.

A fire pit stays behind and can be fueled again later. It also keeps its flames contained, which makes it a much friendlier choice around things you would rather not burn.]],
                    },
                    {
                        type = "heading",
                        text = "Give it something to burn",
                    },
                    {
                        type = "text",
                        text = "Fires shrink as their fuel runs out. Keep something combustible nearby when you expect to rely on one, especially before settling in for the night.",
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
                            "darkness",
                            "temperature",
                            "food",
                        },
                    },
                },
            },
        },
    },
}
