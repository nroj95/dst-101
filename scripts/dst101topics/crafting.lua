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
            illustration = "crafting_hammer",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Taking things apart",
                    },
                    {
                        type = "text",
                        text = [[
A Hammer can dismantle many structures. It is useful for misplaced builds, old camp pieces, and structures you find in the world.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Wolfgang had not expected that much to come back.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
Pig Heads can be hammered too. They give Pig Skin and Twigs without removing a Pig House.
]],
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Some materials come back",
                    },
                    {
                        type = "text",
                        text = [[
Many structures return part of their building materials when hammered. Containers also drop anything stored inside rather than destroying it.

That makes building mistakes less permanent. If something is in the wrong place, taking it apart may give you enough material to rebuild elsewhere.
]],
                    },
                    {
                        type = "heading",
                        text = "What Pig Houses give",
                    },
                    {
                        type = "text",
                        text = [[
A naturally generated Pig House gives 2 Boards, 2 Cut Stone, and 2 Pig Skins when hammered. Taking apart a few early can save quite a bit of gathering and refining.

The house stops producing Pigs once it is gone. Leave some standing if you still want a renewable source of Pigs.
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
                        text = "So that's what the Living Logs were for.",
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

If a strange material has no obvious use yet, keeping a few gives you more options later, including some unusually powerful or peculiar equipment.
]],
                    },
                },

                note = {},
            },
        },
    },
}
