return {
    id = "food",
    title = "Food",
    icon = "food",
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
                        type = "heading",
                        text = "Related topics",
                    },
                    {
                        type = "related_topics",
                        topics = {
                            "farming",
                            "fishing",
                            "hunting",
                            "storage",
                        },
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
Most food does not stay fresh forever. As it goes stale, it becomes less useful; leave it long enough and it rots. Older food is usually worth using first.
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
            illustration = "food_fire_cooking",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Cooking",
                    },
                    {
                        type = "text",
                        text = [[
You can cook food directly over a fire, or combine several ingredients in a Crock Pot.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Willow was not convinced yet.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
Simple cooked food is still useful when all you need is something to eat now.
]],
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Cooking over a fire",
                    },
                    {
                        type = "text",
                        text = [[
Many foods can be cooked directly. Cooking changes what they restore and sometimes how long they stay fresh. It can make a food better in one way and worse in another, so it is worth trying familiar ingredients both ways.
]],
                    },
                    {
                        type = "heading",
                        text = "Using a Crock Pot",
                    },
                    {
                        type = "text",
                        text = [[
A Crock Pot takes four ingredients and turns them into one dish. Dishes can solve hunger, health, or sanity in ways the ingredients alone may not.

You do not need to understand every recipe before using one. A Cookbook keeps track of dishes you have already discovered.
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
                        type = "page_heading",
                        text = "Crock Pot patterns",
                    },
                    {
                        type = "text",
                        text = [[
The Crock Pot does not simply add the ingredients together. It checks what kinds of food you used and whether they satisfy a recipe.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Some combinations turned out better than others.",
                    },
                },

                bottom_left = {
                    {
                        type = "text",
                        text = [[
Many recipes need fewer than four specific ingredients. The remaining slots can often be filled with other food without changing the dish. Those extra ingredients are usually called fillers.
]],
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "A few reliable combinations",
                    },
                    {
                        type = "text",
                        text = [[
Meatballs are useful for hunger. One Monster Meat with three Berries is a simple example.

Pierogi are useful for healing. One Monster Meat, one Egg, one Carrot, and one Berry is a reliable combination.
]],
                    },
                    {
                        type = "heading",
                        text = "Monster Meat in the pot",
                    },
                    {
                        type = "text",
                        text = [[
One piece of Monster Meat can safely count as meat in many Crock Pot dishes.

Two or more Monster Meats usually turn the result into Monster Lasagna. Start with one until you know a recipe can handle more.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "food_preservation",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Keeping food longer",
                    },
                    {
                        type = "text",
                        text = [[
When you have more food than you can eat soon, preserving it saves you from replacing the same supplies again.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "That should last a while.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Cold storage",
                    },
                    {
                        type = "text",
                        text = [[
An Ice Box slows food spoilage. It works on its own; you do not need to put ice inside it.

A Salt Box keeps certain raw foods fresh even longer, but it cannot store every kind of food.
]],
                    },
                    {
                        type = "heading",
                        text = "Dry meat in clear weather",
                    },
                    {
                        type = "text",
                        text = [[
A Drying Rack turns many raw meats into longer-lasting jerky. The finished jerky comes off fresh, so drying meat that is getting old can give it much more time.

Rain pauses the drying process. If the weather is already wet, an Ice Box or Salt Box is usually the better choice until the rain stops.
]],
                    },
                },

                note = {},
            },
        },
    },
}
