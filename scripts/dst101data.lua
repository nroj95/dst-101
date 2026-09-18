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
                                text = "You do not need to know where you are going yet.",
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "The path was convincing. I followed it anyway.",
                            },
                        },

                        bottom_left = {},

                        right = {
                            {
                                type = "text",
                                text = [[
Pick up grass, twigs, flint, and some food while you wander. You'll find uses for all of them soon enough.
]],
                            },
                            {
                                type = "heading",
                                text = "Before night falls",
                            },
                            {
                                type = "text",
                                text = [[
Night is worth seeing. Darkness isn't. Make sure you have a way to make light before it arrives.
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
                                text = "They look like trouble. Usually they are only large.",
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
                                text = "A red rear means distance",
                            },
                            {
                                type = "text",
                                text = [[
When a Beefalo's rear turns red, give it space. That is not the moment to test its patience — or the herd's.
]],
                            },
                            {
                                type = "heading",
                                text = "Useful without a fight",
                            },
                            {
                                type = "text",
                                text = [[
They leave manure behind, and sleeping Beefalo can be shaved for wool. Not every useful thing needs chasing.
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
                "night",
                "light",
                "fire",
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
                                text = "The road does not end just because the sun does.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
If you expect to be travelling after dark, bring a light you can take with you. Being able to see is considerably more useful than discovering why you should have.
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
                                text = "Fires are for stopping",
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
                "science machine",
                "alchemy engine",
                "prototype",
                "prototyping",
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
                                text = "It looked absurd. Then it taught me something.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
Some useful things can be made without a machine. If you have the materials, you already know how.
]],
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
A Science Machine lets you prototype more recipes while you are near it. Once you have learned one, you can make it elsewhere whenever you have the materials.
]],
                            },
                            {
                                type = "text",
                                text = [[
An Alchemy Engine opens more advanced science recipes. There is no need to learn the whole workshop at once.
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
                    illustration = "food_cooking",

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
Berries, carrots, and other familiar food can keep a journey moving. You do not need to carry the whole landscape home.
]],
                            },
                        },

                        right = {
                            {
                                type = "heading",
                                text = "Food does not wait forever",
                            },
                            {
                                type = "text",
                                text = [[
Most food spoils after it is picked. Keep an eye on freshness and use what is fading before the better stuff.
]],
                            },
                            {
                                type = "heading",
                                text = "Empty means trouble",
                            },
                            {
                                type = "text",
                                text = [[
Once your stomach is empty, hunger starts costing health. Better to eat before one problem becomes two.
]],
                            },
                        },

                        note = {},
                    },
                },

                {
                    illustration = "food_foraging",

                    regions = {
                        top_left = {
                            {
                                type = "text",
                                text = [[
Cooking changes familiar ingredients in useful ways. A fire treats one ingredient at a time; a Crock Pot combines several into something new. Both are useful, but they solve different problems.
]],
                            },
                        },

                        illustration_caption = {
                            {
                                type = "caption",
                                text = "Four things in. One answer out. Worth taking notes.",
                            },
                        },

                        bottom_left = {
                            {
                                type = "text",
                                text = [[
Many raw foods can be cooked directly over a fire. Cooking changes what they restore and how long they keep, so it is worth checking the result instead of assuming cooked is always better. Simple food is still useful when you only need a quick meal.
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
A Crock Pot takes four ingredients and turns them into a dish. What comes out depends on what went in; some combinations are much better than others. Once you find a reliable recipe, it becomes much easier to plan a meal around what you have.
]],
                            },
                            {
                                type = "text",
                                text = [[
Try combinations when you can afford a surprise. Keep something simple to eat while you learn what the pot likes, and remember the combinations that are worth repeating.
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
