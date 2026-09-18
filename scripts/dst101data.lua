return {
    strings = {
        topics = "Topics",
        search_placeholder = "Search...",
        previous_page = "Previous page",
        next_page = "Next page",
    },

    topics = {
        {
            id = "setting_out",
            title = "Setting Out",
            icon = "setting_out",
            related_topic_tile = 1,
            tags = {
                "beginner",
                "basics",
                "first night",
                "new player",
            },
            pages = {
                {
                    illustration = "setting_out_sketch",

                    regions = {
                        top_left = {
                            {
                                type = "headline",
                                text = "Before you wander",
                            },
                            {
                                type = "subtitle",
                                text = "You don't need a destination yet.",
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "I started walking before I had a plan.",
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
                                    "food",
                                },
                            },
                        },

                        right = {
                            {
                                type = "text",
                                text = [[
Pick up grass, twigs, flint, and something to eat as you wander. A few basics in your pockets make an unexpected detour much easier.
]],
                            },
                            {
                                type = "heading",
                                text = "Before night falls",
                            },
                            {
                                type = "text",
                                text = [[
Night is manageable with a light in hand. Make one before you need it.
]],
                            },
                        },

                        note = {},
                    },
                },
            },
        },

        {
            id = "beefalo",
            title = "Beefalo",
            icon = "beefalo",
            related_topic_tile = 3,
            tags = {
                "mating season",
                "heat",
            },
            pages = {
                {
                    illustration = "beefalo_color",

                    regions = {
                        top_left = {
                            {
                                type = "headline",
                                text = "Large company",
                            },
                            {
                                type = "subtitle",
                                text = "Big, shaggy, and not always in the mood for company.",
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "Bigger up close. Calmer than I expected.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
Beefalo are often content to mind their own business. If you leave them alone, they will usually return the favor.
]],
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "When their rear turns red",
                            },
                            {
                                type = "text",
                                text = [[
When a Beefalo's rear turns red, give the herd plenty of space. They become much less interested in minding their own business.
]],
                            },
                            {
                                type = "heading",
                                text = "Useful when left alone",
                            },
                            {
                                type = "text",
                                text = [[
They leave manure as they wander, and a sleeping Beefalo can be shaved for wool. Plenty to gather without picking a fight.
]],
                            },
                        },

                        note = {},
                    },
                },
            },
        },

        {
            id = "darkness",
            title = "Darkness",
            icon = "darkness",
            related_topic_tile = 4,
            tags = {
                "beginner",
            },
            pages = {
                {
                    illustration = "darkness_night",

                    regions = {
                        top_left = {
                            {
                                type = "headline",
                                text = "Keep a light handy",
                            },
                            {
                                type = "subtitle",
                                text = "Night is manageable. Complete darkness is another matter.",
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "I kept walking after dark. The torch was worth carrying.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
If you expect to be travelling after dark, bring a light you can take with you. It is easier to make one before you need it.
]],
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "If the light goes out",
                            },
                            {
                                type = "text",
                                text = [[
Make another source of light or reach one quickly. Complete darkness is not a safe place to wait and think.
]],
                            },
                            {
                                type = "heading",
                                text = "Stopping for the night",
                            },
                            {
                                type = "text",
                                text = [[
A fire gives you somewhere bright to spend the night. Portable light lets the journey continue.
]],
                            },
                        },

                        note = {
                            {
                                type = "note",
                                text = "Something watched from beyond the light. I chose not to investigate.",
                            },
                        },
                    },
                },
            },
        },

        {
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
                    illustration = "crafting_science",

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
]],
                            },
                            {
                                type = "text",
                                text = [[
An Alchemy Engine has more advanced science to offer. Learn what helps now. The rest will still be there when you come back.
]],
                            },
                        },

                        note = {},
                    },
                },
            },
        },

        {
            id = "food",
            title = "Food",
            icon = "food",
            related_topic_tile = 6,
            tags = {
                "hungry",
                "starving",
                "starvation",
                "perish",
            },
            pages = {
                {
                    illustration = "food_foraging",

                    regions = {
                        top_left = {
                            {
                                type = "headline",
                                text = "Keep food nearby",
                            },
                            {
                                type = "subtitle",
                                text = "Hunger is easier to solve before it becomes urgent.",
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "A good walk often turns up lunch.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
Berries, carrots, and other familiar food can keep a journey moving. Pick up what you need as you go.
]],
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "Food spoils",
                            },
                            {
                                type = "text",
                                text = [[
Most food does not stay fresh forever. Keep an eye on what is fading. Use those things first when you can; the fresher food will wait.
]],
                            },
                            {
                                type = "heading",
                                text = "An empty stomach costs health",
                            },
                            {
                                type = "text",
                                text = [[
Once your stomach is empty, hunger starts costing health. Eat before it gets that far.
]],
                            },
                        },

                        note = {},
                    },
                },

                {
                    illustration = "food_cooking",

                    regions = {
                        top_left = {
                            {
                                type = "text",
                                text = [[
There is more than one way to cook what you find. A fire changes one ingredient at a time. A Crock Pot combines four into a dish. Both are worth trying; neither makes every ingredient better.
]],
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "Some combinations worked better than others. I wrote those down.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
Many foods can be cooked directly over a fire. Cooking changes what they restore and sometimes how long they keep, so pay attention to the result. Simple food is still useful when all you need is lunch.
]],
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "Four things in a pot",
                            },
                            {
                                type = "text",
                                text = [[
A Crock Pot needs four ingredients before it starts. What comes out depends on what went in, and a promising combination can still become something disappointing. Once you find a reliable recipe, it becomes much easier to plan around what you have.
]],
                            },
                            {
                                type = "text",
                                text = [[
Experiment when you have food to spare. Keep something simple to eat while you test combinations, and remember the ones worth repeating.
]],
                            },
                        },

                        note = {},
                    },
                },
            },
        },

    },
}
