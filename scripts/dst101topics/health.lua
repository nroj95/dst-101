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
                        text = "I thought that salve would last longer.",
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
                            "Character abilities can change the details, so pay attention to what works for the survivor you are playing.",
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
    },
}
