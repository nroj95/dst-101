return {
    id = "caves",
    title = "Caves",
    icon = "caves",
    tags = {
        "underground",
        "sinkhole",
        "sinkholes",
    },

    pages = {
        {
            illustration = "caves_first_descent",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Before you go below",
                    },
                    {
                        type = "subtitle",
                        text = "Take enough light and supplies for the way back.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I could not see much past the first few steps.",
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
                            "sanity",
                            "combat",
                            "hounds",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Bring dependable light",
                    },
                    {
                        type = "text",
                        text = [[
Opening a plugged Sinkhole with a pickaxe reveals the stairs below. Those stairs are also your way back to the surface.

Light Flowers grow underground. Their bulbs are used to make Lanterns and can refuel both Lanterns and Miner Hats, giving you a renewable way to keep portable light going.
]],
                    },
                    {
                        type = "heading",
                        text = "Keep the first trip simple",
                    },
                    {
                        type = "text",
                        text = [[
Food, healing, armor, and a few basic tools are plenty for a first look. Check your map before wandering far from the stairs.

Long trips underground also wear on sanity. You do not need to push farther just because your light is still good. You can always come back after you know what you actually need.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "caves_nightmare_cycle",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "The Nightmare Cycle",
                    },
                    {
                        type = "text",
                        text = [[
In some deeper places, red lights and fissures can grow brighter and more active before the dangerous phase begins.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "I noticed the red glow before the shadows appeared.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Read the warning",
                    },
                    {
                        type = "text",
                        text = [[
The stronger the red glow becomes, the more dangerous the cycle is getting. Nightmare lights can also drain sanity while they are active.
]],
                    },
                    {
                        type = "heading",
                        text = "When it peaks",
                    },
                    {
                        type = "text",
                        text = [[
At its worst, nightmare lights and fissures can release hostile Shadow Creatures even when your sanity is fine. The cycle eventually settles again, and those creatures disappear with it.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "caves_depths_worms",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Depths Worms",
                    },
                    {
                        type = "text",
                        text = [[
While you are underground, rumbling growls can warn that a Depths Worm attack is coming. The growls become more frequent as it gets closer.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "That growling was getting closer.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Move before they arrive",
                    },
                    {
                        type = "text",
                        text = [[
If you are near camp or somewhere awkward, use the warning to find more room. Depths Worms hit hard, and several arriving together can turn a cramped fight into a bad one.
]],
                    },
                    {
                        type = "heading",
                        text = "You do not have to fight them there",
                    },
                    {
                        type = "text",
                        text = [[
They are slow enough to outrun, and enough distance can make them lose interest. If the growling starts near an exit, returning to the surface before they arrive is another option.

The same idea works the other way above ground: if hounds are coming and you are near an open Sinkhole, heading into the caves before they arrive can avoid the surface attack.
]],
                    },
                },

                note = {},
            },
        },
    },
}
