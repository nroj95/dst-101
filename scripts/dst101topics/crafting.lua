return {
    id = "crafting",
    title = "Crafting",
    icon = "crafting",
    related_topic_tile = 5,
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

An Alchemy Engine has more advanced science to offer. Learn what helps now. The rest will still be there when you come back.
]],
                    },
                },

                note = {},
            },
        },
    },
}
