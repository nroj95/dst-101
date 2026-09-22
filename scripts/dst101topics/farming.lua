return {
    id = "farming",
    title = "Farming",
    icon = "farming",
    tags = {
        "gardening",
        "vegetables",
    },
    pages = {
        {
            illustration = "farming_wormwood",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Start a garden",
                    },
                    {
                        type = "subtitle",
                        text = "A few seeds and a patch of farm soil are enough to begin.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Wormwood was already talking to the sprouts.",
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
                            "food",
                            "gathering",
                            "seasons",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Prepare the ground",
                    },
                    {
                        type = "text",
                        text = [[
Use a Garden Digamajig to turn ordinary ground into farm soil. It leaves garden debris behind; dig that out with a shovel, then use a Garden Hoe to make planting spots.

Plant ordinary Seeds when you are happy to discover what grows. Crop Seeds grow a known crop instead.
]],
                    },
                    {
                        type = "heading",
                        text = "Water, then watch",
                    },
                    {
                        type = "text",
                        text = [[
Plants can still grow without perfect care. Watering the soil and checking the garden as it develops are enough to start learning what helps.

Do not wait until you understand every farming system. A small imperfect garden still gives you food.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "farming_plants",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Plant care",
                    },
                    {
                        type = "text",
                        text = [[
Farm plants react to the conditions around them as they grow. Stress slows them down and reduces how many crop-specific seeds they return, but a stressed plant can still give you its crop.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I did not expect the pumpkin to get that big.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "What plants notice",
                    },
                    {
                        type = "bullets",
                        items = {
                            "Whether the crop likes the current season.",
                            "Moisture and nutrients in its farm-soil tile.",
                            "Nearby plants, including whether it has enough of its own kind or is overcrowded.",
                            "Weeds, rotten plants, or garden debris nearby.",
                            "Whether someone tends to it as it changes growth stages.",
                        },
                    },
                    {
                        type = "heading",
                        text = "Let the garden teach you",
                    },
                    {
                        type = "text",
                        text = [[
A Gardeneer Hat lets you research crops, weeds, and seeds and builds their entries in the Plant Registry. It can also tell you when a plant is stressed.

Once you know the basics, you can experiment with seasons, neighboring crops, and soil nutrients if that sounds fun. You do not need giant crops to make farming worthwhile.
]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "Some weeds have uses of their own. I still keep them out of the crop rows.",
                    },
                },
            },
        },
    },
}
