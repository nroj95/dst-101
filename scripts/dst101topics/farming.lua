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
Farm plants check their surroundings as they grow. Better conditions mean faster growth and better seed returns, and exceptionally well-cared-for crops can grow huge.
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
                        text = "Water the soil",
                    },
                    {
                        type = "text",
                        text = [[
A Watering Can moistens the whole farm-soil tile at once. You do not need to keep it soaked; watering once during each growth stage is enough for the plant's moisture need.

Refill the can at a Pond. Rain can help keep the soil wet too.
]],
                    },
                    {
                        type = "heading",
                        text = "What plants notice",
                    },
                    {
                        type = "bullets",
                        items = {
                            "Whether the crop likes the current season.",
                            "Moisture and nutrients in its farm-soil tile.",
                            "Nearby plants: enough of its own kind without overcrowding.",
                            "Weeds, rotten plants, or garden debris nearby.",
                            "Whether someone tends to it as it changes growth stages.",
                        },
                    },
                    {
                        type = "text",
                        text = "Giant crops need almost all of those needs met while they grow.",
                    },
                },

                note = {},
            },
        },

        {
            illustration = "farming_upkeep",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Garden upkeep",
                    },
                    {
                        type = "text",
                        text = [[
Once a garden is producing food, you can start keeping the crops you want and clearing out what interferes with them.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "It ate the pumpkin and gave me a pumpkin seed.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Getting more crop seeds",
                    },
                    {
                        type = "text",
                        text = [[
Better-cared-for Farm Plants can return Crop Seeds when harvested. Those seeds grow the same crop again.

A bird in a Birdcage gives one corresponding Crop Seed when fed an uncooked Farm Plant crop.
]],
                    },
                    {
                        type = "heading",
                        text = "Weeds and garden debris",
                    },
                    {
                        type = "text",
                        text = [[
Ordinary Seeds can grow into weeds. Weeds, rotten plants, and Garden Detritus stress nearby crops, and weeds also consume soil nutrients without replacing them.

Dig weeds up when they get in the way. Some can hurt or trap you when handled, and some have useful harvests of their own, so unfamiliar weeds are worth inspecting before you clear them.
]],
                    },
                },

                note = {
                    {
                        type = "note",
                        text = "A Gardeneer Hat can research crops, seeds, and weeds for the Plant Registry.",
                    },
                },
            },
        },
    },
}
