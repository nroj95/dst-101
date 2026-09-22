return {
    id = "wetness",
    title = "Wetness",
    icon = "wetness",

    tags = {
        "waterproof",
        "water resistance",
        "soaked",
    },

    pages = {
        {
            illustration = "wetness_rain",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "When everything gets wet",
                    },
                    {
                        type = "subtitle",
                        text = "Rain turns small problems into one cold, slippery mess.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Much easier to think when my tools stay in my hands.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "What wetness changes",
                    },
                    {
                        type = "text",
                        text = "Rain is mostly troublesome because several smaller problems arrive together.",
                    },
                    {
                        type = "bullets",
                        items = {
                            "Your body cools down, making freezing easier.",
                            "Wet clothing and held tools can drain sanity.",
                            "Held tools and weapons can slip from your hands.",
                            "Soggy food spoils faster, and wet fuel burns for less time.",
                        },
                    },
                    {
                        type = "heading",
                        text = "Keeping dry",
                    },
                    {
                        type = "text",
                        text = [[Rain protection adds together, up to full coverage. An Umbrella already blocks most rain, so even a little more protection can make a large difference.

If you are already soaked, warm up near a fire. A Backpack can get wet, but the items inside stay dry. Chests protect their contents too.]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "I didn't expect the trees to help with the rain.",
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
                            "temperature",
                            "sanity",
                            "food",
                            "seasons",
                        },
                    },
                },
            },
        },
    },
}
