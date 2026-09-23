return {
    id = "gathering",
    title = "Gathering",
    icon = "gathering",
    tags = {
        "resources",
        "materials",
        "harvest",
        "harvesting",
        "collect",
        "collecting",
    },
    pages = {
        {
            illustration = "gathering_shadow_servants",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Notice where things come from",
                    },
                    {
                        type = "subtitle",
                        text = "Knowing where useful materials come from saves time.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "His shadows did most of the gathering.",
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
                            "crafting",
                            "storage",
                            "food",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Use the right tool",
                    },
                    {
                        type = "text",
                        text = [[
Some materials can be picked up by hand. Others need an axe, pickaxe, shovel, or another tool before you can gather them.

A shovel can also move some useful plants. Grass Tufts and Berry Bushes need fertilizer after you replant them.

When you need something unfamiliar, look at what is growing, lying around, or moving nearby. The source is often easier to remember once you have found it yourself.
]],
                    },
                    {
                        type = "heading",
                        text = "Gather for what you are doing",
                    },
                    {
                        type = "text",
                        text = [[
I can lose half a day collecting things simply because they are there. I try to take what helps with the next part of the trip and leave some room for whatever I find.

If I keep needing the same material, I remember where I found it.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "gathering_regrowth",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "What comes back",
                    },
                    {
                        type = "text",
                        text = [[
Harvesting something and destroying its source are not always the same thing.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Walter was already planting another one.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Leave the source working",
                    },
                    {
                        type = "text",
                        text = [[
Picking Grass, Twigs, Berries, Reeds, and many similar resources leaves the plant behind. Given enough time and the right conditions, it can produce more.
]],
                    },
                    {
                        type = "heading",
                        text = "Destroyed is different",
                    },
                    {
                        type = "text",
                        text = [[
Digging up, burning, chopping, or mining can remove the thing that was producing the resource.

Trees are a good example. Chopping removes that tree, but larger Evergreens can drop Pine Cones you can plant to grow new ones. New trees may also appear over time.

Other resources may return in different ways, so something can be renewable without the original source simply growing back where it was.
]],
                    },
                },

                note = {},
            },
        },
    },
}
