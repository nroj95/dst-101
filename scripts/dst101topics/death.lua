return {
    id = "death",
    title = "Death",
    icon = "death",
    tags = {
        "dead",
        "ghost",
        "revive",
        "revival",
        "resurrection",
        "telltale heart",
        "touch stone",
        "booster shot",
    },

    pages = {
        {
            illustration = "death_ghost",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Death is not always the end",
                    },
                    {
                        type = "subtitle",
                        text = "As a ghost, you can still look for a way back.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Still here. More or less.",
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
                            "camp",
                            "seasons",
                            "exploration",
                        },
                    },
                },
                right = {
                    {
                        type = "heading",
                        text = "Your things stay behind",
                    },
                    {
                        type = "text",
                        text = "When you die, the things you were carrying are dropped where you fell. You return as a ghost instead.",
                    },
                    {
                        type = "heading",
                        text = "A friend can bring you back",
                    },
                    {
                        type = "text",
                        text = "A living survivor can craft a Telltale Heart from Cut Grass and a Spider Gland, then use it on your ghost. Making one costs some health, and being revived this way blocks part of your maximum health until a Booster Shot restores it.",
                    },
                    {
                        type = "heading",
                        text = "There are other ways back",
                    },
                    {
                        type = "text",
                        text = "Touch Stones, Meat Effigies, and Life Giving Amulets can also revive ghosts. Which options you have depends on what you have found, prepared, and unlocked.",
                    },
                },
            },
        },

        {
            illustration = "death_recovery",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Touch Stones",
                    },
                    {
                        type = "text",
                        text = "These are worth remembering when you find them. A ghost can haunt one to come back.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "A few spare basics here could save a lot of trouble.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "You come back empty-handed",
                    },
                    {
                        type = "text",
                        text = "Your old inventory stays where you died. A Touch Stone gives you another chance, but it does not return your belongings with you.",
                    },
                    {
                        type = "heading",
                        text = "Leave a small backup nearby",
                    },
                    {
                        type = "text",
                        text = "A torch, a few basic materials, and whatever protection the current season demands can make revival much easier. You do not need another full set of equipment waiting there.",
                    },
                    {
                        type = "heading",
                        text = "Each stone has limits",
                    },
                    {
                        type = "text",
                        text = "Each Touch Stone can normally be used once by each player. Finding more than one gives you more options if things go badly later.",
                    },
                },


            },
        },
    },
}