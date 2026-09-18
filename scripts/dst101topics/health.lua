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
                        text = "Don't use all your healing at once",
                    },
                    {
                        type = "subtitle",
                        text = "Health stays lost until you do something about it.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Kept one salve for the walk home. Used it sooner than planned.",
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
                            "Food can restore health, and dedicated healing items can restore it directly. Character abilities can change the details, so pay attention to what works for the survivor you are playing.",
                            "",
                            "I like to keep a little recovery unused before setting out. The moment you need it is usually a poor time to discover you left the ingredients at camp.",
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
