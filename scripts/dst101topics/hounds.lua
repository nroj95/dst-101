return {
    id = "hounds",
    title = "Hounds",
    icon = "hounds",
    tags = {
        "hound",
        "dogs",
        "attack wave",
        "growling",
        "warning",
    },
    pages = {
        {
            illustration = "hounds_distraction",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Listen before they arrive",
                    },
                    {
                        type = "subtitle",
                        text = "The growling gives you a little time to prepare.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Much easier when they find something else to argue with.",
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
                            "camp",
                            "creatures",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Use the warning",
                    },
                    {
                        type = "text",
                        text = [[
When distant growling starts, hounds are on the way. Get your weapon and armor ready, make sure you can see what you are doing, and choose somewhere with room to move.

I would rather leave camp for the fight than discover what the hounds can damage while I am busy with them.
]],
                    },
                    {
                        type = "heading",
                        text = "Something else may keep them busy",
                    },
                    {
                        type = "text",
                        text = [[
Hounds are aggressive toward more than just you. If a pack becomes difficult to handle, other creatures may distract them and change the fight.

Later attacks can bring more hounds, so something that worked comfortably before may need a different plan next time.
]],
                    },
                },

                note = {},
            },
        },
    },
}
