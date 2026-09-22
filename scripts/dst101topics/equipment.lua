return {
    id = "equipment",
    title = "Equipment",
    icon = "equipment",

    tags = {
        "gear",
        "equip",
        "equipping",
    },

    pages = {
        {
            illustration = "equipment_slots",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Choose what to equip",
                    },
                    {
                        type = "subtitle",
                        text = "Tools, armor, clothing, and backpacks share a few slots.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Wendy checked what was worth carrying.",
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
                            "combat",
                            "storage",
                            "temperature",
                            "crafting",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Three main slots",
                    },
                    {
                        type = "text",
                        text = [[
Your hand holds one tool, weapon, or other hand item. Hats and head armor use the head slot. Body armor, many clothes, and Backpacks use the body slot.
]],
                    },
                    {
                        type = "heading",
                        text = "One slot can have several jobs",
                    },
                    {
                        type = "text",
                        text = [[
A Backpack gives you more storage, but it uses the same body slot as body armor and many seasonal clothes.

You cannot tuck a Backpack into your normal inventory. If you take it off to wear something else, it stays on the ground with its contents. Remember where you left it.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "equipment_durability",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Durability and swapping",
                    },
                    {
                        type = "text",
                        text = [[
Many tools, weapons, armor pieces, and clothes wear out as you use them. Check the gear you depend on before it fails when you need it.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Winona checked the wear before trusting it again.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Watch what is wearing out",
                    },
                    {
                        type = "text",
                        text = [[
Durability belongs to the item, not the slot. Tools can wear down from work, while armor loses durability when it absorbs damage.

If something important is nearly spent, replace it, repair it when possible, or carry another.
]],
                    },
                    {
                        type = "heading",
                        text = "Swap for the situation",
                    },
                    {
                        type = "text",
                        text = [[
Keeping alternate gear in your inventory lets you change what is equipped instead of committing to one setup all day.

A Backpack may matter while traveling, armor when a fight starts, and seasonal clothing when temperature becomes the bigger problem.
]],
                    },
                },

                note = {},
            },
        },
    },
}
