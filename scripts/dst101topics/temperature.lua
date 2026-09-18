return {
    id = "temperature",
    title = "Temperature",
    icon = "temperature",
    tags = {
        "cold",
        "heat",
        "freezing",
        "overheating",
        "insulation",
        "thermal stone",
    },
    pages = {
        {
            illustration = "temperature_thermal_stone",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Watch for the first signs",
                    },
                    {
                        type = "subtitle",
                        text = "Your view changes before cold or heat hurts.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "It stayed warm longer than I expected. Useful little rock.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Read the change",
                    },
                    {
                        type = "text",
                        text = table.concat({
                            "Your body temperature follows the conditions around you. Stay too cold and you begin freezing; stay too hot and you begin overheating. The edges of your view warn you before either starts hurting you.",
                            "",
                            "That warning is useful time. Find a way to warm or cool yourself before the weather turns into a health problem.",
                        }, "\n"),
                    },
                    {
                        type = "heading",
                        text = "Slow the change",
                    },
                    {
                        type = "text",
                        text = table.concat({
                            "Insulation slows temperature change. A Thermal Stone can carry stored warmth or cold after you warm or cool it with the right source.",
                            "",
                            "Both buy time rather than immunity. Use that time to reach the next place where you can warm up or cool down properly.",
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
                        topics = { "health", "crafting" },
                    },
                },
            },
        },
    },
}
