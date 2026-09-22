return {
    id = "seasons",
    title = "Seasons",
    icon = "seasons",

    tags = {
        "autumn",
        "winter",
        "spring",
        "summer",
        "weather",
    },

    pages = {
        {
            illustration = "seasons_overview",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "The world keeps changing",
                    },
                    {
                        type = "subtitle",
                        text = "Use the easier days to prepare for what comes next.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Autumn is when I get most things ready.",
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
                            "temperature",
                            "wetness",
                            "fire",
                            "caves",
                        },
                    },
                },
                right = {
                    {
                        type = "heading",
                        text = "Each season changes the rules",
                    },
                    {
                        type = "bullets",
                        items = {
                            "Autumn is usually mild and gives you room to explore and prepare.",
                            "Winter makes warmth important.",
                            "Spring brings frequent rain and wetness.",
                            "Summer brings dangerous heat and surface fires.",
                        },
                    },
                    {
                        type = "heading",
                        text = "Prepare before you need it",
                    },
                    {
                        type = "text",
                        text = "Watch for the season changing and use calmer days to gather what the next one may demand. Food, fuel, clothing, cooling, and a few useful structures are much easier to arrange before conditions become urgent.",
                    },
                },
            },
        },

        {
            illustration = "seasons_winter",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Winter",
                    },
                    {
                        type = "text",
                        text = "The cold can become severe enough to freeze you. A reliable way to warm up matters both at camp and while traveling.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The fire needed more fuel than expected.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Keep warmth within reach",
                    },
                    {
                        type = "text",
                        text = "Fires restore warmth, while insulated clothing and a heated Thermal Stone give you more time before the cold catches up. Carry enough fuel to make another fire when you are away from camp.",
                    },
                    {
                        type = "heading",
                        text = "Winter is still for exploring",
                    },
                    {
                        type = "text",
                        text = [[
Winter changes what grows and which creatures appear, but it also brings things worth looking for. Mini Glaciers are fullest now, so this is a good time to mine some ice while you travel.

With enough warmth and fuel, you can keep exploring instead of waiting for better weather.
]],
                    },
                },
            },
        },

        {
            illustration = "seasons_spring",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Spring",
                    },
                    {
                        type = "text",
                        text = "Expect long stretches of rain, wet ground, and frequent storms. Staying soaked causes several smaller problems to pile up.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Wet again. At least the plants seem happy.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Stay dry enough to function",
                    },
                    {
                        type = "text",
                        text = "Rain protection keeps wetness under control. Too much wetness can drain sanity, make tools slippery, and cool you enough to start freezing, especially early in the season.",
                    },
                    {
                        type = "heading",
                        text = "Give lightning somewhere safe to go",
                    },
                    {
                        type = "text",
                        text = "Spring storms bring frequent lightning. A Lightning Rod helps protect nearby camp structures from strikes and the fires they can start.",
                    },
                    {
                        type = "heading",
                        text = "The rain is useful too",
                    },
                    {
                        type = "text",
                        text = "Spring is not only trouble. Rain helps crops grow quickly and brings other parts of the world back to life, so good rain protection lets you keep working instead of simply waiting for dry weather.",
                    },
                },
            },
        },

        {
            illustration = "seasons_summer",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Summer",
                    },
                    {
                        type = "text",
                        text = "The surface becomes hot enough to overheat you, while nearby flammable things can begin to smolder. Decide how you want to spend the season before the worst heat arrives.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Nobody was complaining about the cold fire.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Keep something cold nearby",
                    },
                    {
                        type = "text",
                        text = "Endothermic Fires cool instead of warm you. Chilled Thermal Stones, cooling gear, and shade can also buy time while you travel on the surface.",
                    },
                    {
                        type = "heading",
                        text = "Choose your summer plan",
                    },
                    {
                        type = "text",
                        text = "Underground, you avoid surface overheating and wildfires, making the caves a useful place to spend much of summer. A prepared camp around the oasis is another option. If you stay at an ordinary surface base, an Ice Flingomatic can protect nearby structures and plants from smoldering.",
                    },
                },


            },
        },
    },
}
