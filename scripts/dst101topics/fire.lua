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
                        text = "Fire needs tending",
                    },
                    {
                        type = "subtitle",
                        text = "A fire still needs fuel, space, and a little attention.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Willow clearly knows her way around a fire.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Campfire or Fire Pit?",
                    },
                    {
                        type = "text",
                        text = [[A Campfire is quick and temporary. Once it burns out, it is gone. It can also ignite flammable things that are too close.

A Fire Pit stays behind and can be fueled again later. Its flames are contained, which makes it a much friendlier choice around things you would rather not burn.]],
                    },
                    {
                        type = "heading",
                        text = "Give it something to burn",
                    },
                    {
                        type = "text",
                        text = "Fires shrink as their fuel runs out. A little spare fuel nearby is useful when you expect to rely on one through the night.",
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
