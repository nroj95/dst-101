return {
    id = "crafting",
    title = "Crafting",
    icon = "crafting",
    tags = {
        "prototyping",
        "recipe",
        "recipes",
    },
    pages = {
        {
            illustration = "crafting",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Learn it once",
                    },
                    {
                        type = "subtitle",
                        text = "Some things are simple. Others need a little science first.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Strange little machine. It keeps giving me ideas.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
A few useful things need no machine at all. Keep the materials handy and you can make them wherever the road takes you.
]],
                    },
                    {
                        type = "bullets",
                        items = {
                            "Axe for chopping trees",
                            "Pickaxe for breaking boulders",
                            "Torch for light that travels",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Prototype nearby",
                    },
                    {
                        type = "text",
                        text = [[
A Science Machine lets you prototype more recipes while you are near it. Prototype something once and you have learned it; after that, you can make it elsewhere whenever you have the materials.

An Alchemy Engine opens more advanced science and can also prototype the recipes a Science Machine can. You do not need both nearby.

Learning a recipe for the first time also gives you a small sanity boost. Learn what helps now. The rest will still be there when you come back.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "crafting_magic",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Magic crafting",
                    },
                    {
                        type = "text",
                        text = [[
Some strange materials become much more useful once you start experimenting beyond ordinary science.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Keeping the strange stuff opens more possibilities later.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Another kind of station",
                    },
                    {
                        type = "text",
                        text = [[
A Prestihatitator opens the first magical recipes. A Shadow Manipulator opens more advanced ones, much like the Science Machine and Alchemy Engine do for science.

Once you prototype something, you can make it elsewhere later when you have the materials.
]],
                    },
                    {
                        type = "heading",
                        text = "Keep the strange stuff",
                    },
                    {
                        type = "text",
                        text = [[
Living Logs and Nightmare Fuel are worth keeping for magical crafting. Gems have uses there too, but they also turn up in other recipes and structures.

You do not need to know what every strange material is for when you first find it. Keeping a few gives you more options later, including some unusually powerful or peculiar equipment.
]],
                    },
                },

                note = {},
            },
        },
    },
}
