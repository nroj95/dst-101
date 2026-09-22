return {
    id = "combat",
    title = "Combat",
    icon = "combat",
    tags = {
        "fight",
        "fighting",
        "kiting",
        "kite",
        "hit and run",
        "melee",
    },
    pages = {
        {
            illustration = "combat_study",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Watch how it attacks",
                    },
                    {
                        type = "subtitle",
                        text = "A missed attack is often your chance to move in.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The timing was much easier to see with only one of them.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Learn the timing",
                    },
                    {
                        type = "text",
                        text = table.concat({
                            "Many melee creatures commit to an attack. If you move as it starts, you can often let the hit miss, then step back in for one or two swings before moving again.",
                            "",
                            "Start cautiously. One safe opening you understand is more useful than guessing how many hits you can squeeze in.",
                        }, "\n"),
                    },
                    {
                        type = "heading",
                        text = "When the fight gets messy",
                    },
                    {
                        type = "text",
                        text = table.concat({
                            "Armor and a proper weapon make mistakes less expensive, but groups can turn neat timing into a mess. Attacks overlap. Space disappears. The sensible fight can become a very different one in a few seconds.",
                            "",
                            "If the situation stops making sense, leave. You can come back with more room, better gear, or a different idea.",
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
                        topics = {
                            "health",
                            "creatures",
                            "hounds",
                            "equipment",
                        },
                    },
                },
            },
        },

        {
            illustration = "combat_weapons_armor",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Weapons and armor",
                    },
                    {
                        type = "text",
                        text = [[
A proper weapon shortens a fight, while armor gives you room to make a mistake. Both help before you worry about perfect timing.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The helmet caught that one.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Start with simple gear",
                    },
                    {
                        type = "text",
                        text = [[
A Spear is an easy early weapon to craft and a clear step up from fighting with ordinary tools. A Football Helmet or Log Suit is a straightforward early armor choice.

Later gear may hit harder, last longer, or offer different trade-offs. You do not need the strongest equipment available for every fight.
]],
                    },
                    {
                        type = "heading",
                        text = "Head and body armor",
                    },
                    {
                        type = "text",
                        text = [[
Wearing head and body armor together does not add their physical protection percentages. The stronger protection is used for the hit, while durability loss is shared between the equipped armor pieces.

That can make armor last longer, but body armor also competes with Backpacks and some clothing. Choose what matters for the fight in front of you.
]],
                    },
                },

                note = {},
            },
        },
    },
}
