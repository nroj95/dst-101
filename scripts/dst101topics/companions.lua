return {
    id = "companions",
    title = "Companions",
    icon = "companions",
    tags = {
        "followers",
        "allies",
        "friends",
        "pets",
        "pigmen",
    },
    pages = {
        {
            illustration = "companions_pigmen",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Bring some company",
                    },
                    {
                        type = "subtitle",
                        text = "Not every companion follows the same rules.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Followers tend to stick around longer for a certain woodsman.",
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
                            "creatures",
                            "combat",
                            "food",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "How some followers work",
                    },
                    {
                        type = "text",
                        text = [[
Some creatures can be persuaded to follow for a while. Others stay with you for different reasons, and some are better thought of as pets than helpers.

Pigs are one easy example: meat can make one friendly for a time. A friendly Pig can help in a fight, and may join in chopping after it sees you start on a tree. Other companions may want something completely different.
]],
                    },
                    {
                        type = "heading",
                        text = "Watch what they do",
                    },
                    {
                        type = "text",
                        text = [[
Followers still react to the world around them. They may notice a creature, stop to work, wander away, or eventually stop following.

Learn what kind of help a companion offers instead of assuming it will behave like the last one.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "companions_chester",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Chester",
                    },
                    {
                        type = "text",
                        text = [[
Pick up the Eye Bone and Chester appears. He carries nine stacks and follows whoever has the Eye Bone.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "It only worked under a full moon.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
Drop the Eye Bone if you want Chester to wait somewhere. The Eye Bone also drops when you enter the Caves, leaving Chester on the surface.
]],
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Full-moon transformations",
                    },
                    {
                        type = "text",
                        text = [[
On a Full Moon, put one Nightmare Fuel or one Blue Gem in each of Chester's nine slots:
]],
                    },
                    {
                        type = "bullets",
                        items = {
                            "Nightmare Fuel turns him into Shadow Chester. He gains three extra storage slots, but food spoils faster inside him.",
                            "Blue Gems turn him into Snow Chester. Food lasts twice as long, Ice does not melt, and Thermal Stones cool inside him.",
                        },
                    },
                    {
                        type = "heading",
                        text = "The change can be undone",
                    },
                    {
                        type = "text",
                        text = [[
Only ordinary Chester can transform. If a transformed Chester dies, he returns later as ordinary Chester, so you can choose again on another Full Moon.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "companions_cave",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Cave companions",
                    },
                    {
                        type = "text",
                        text = [[
The caves have their own companions. Hutch carries supplies, while some creatures can be persuaded to follow for a while.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Winona had plenty of company down here.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
Hutch has two other forms. With a light source inside, add a spear-type weapon for Fugu Hutch, which damages attackers. Use a One-man Band instead for Music Box Hutch, which restores sanity nearby.
]],
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Hutch",
                    },
                    {
                        type = "text",
                        text = [[
Star-Sky makes Hutch follow. He holds nine stacks and stays in the Caves. Put a Light Bulb inside and he glows without consuming it.
]],
                    },
                    {
                        type = "heading",
                        text = "Bunnymen",
                    },
                    {
                        type = "text",
                        text = [[
Carrots make Bunnymen follow. Carrying Meat, Eggs, or many Crock Pot dishes can make even friendly ones attack.

Ham Bats are safe, and meat carried by Chester, Hutch, or Woby does not count.
]],
                    },
                    {
                        type = "heading",
                        text = "Rock Lobsters",
                    },
                    {
                        type = "text",
                        text = [[
Give a Rock Lobster a Rock, Flint, or another mineral and it follows and fights for you.

They are slow but tough, and hide in their shells to recover when badly hurt.
]],
                    },
                },

                note = {},
            },
        },
    },
}
