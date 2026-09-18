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
                        text = "Watch before you swing",
                    },
                    {
                        type = "subtitle",
                        text = "A missed attack is often your chance to move in.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "One is much easier to study than six.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Find the rhythm",
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
                        text = "When the rhythm breaks",
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
                        topics = { "health", "crafting", "setting_out" },
                    },
                },
            },
        },
    },
}
