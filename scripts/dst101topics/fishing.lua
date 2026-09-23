return {
    id = "fishing",
    title = "Fishing",
    icon = "fishing",
    tags = {},
    pages = {
        {
            illustration = "fishing_pond",

            regions = {
                top_left = {
                    {
                        type = "headline",
                        text = "Start with a pond",
                    },
                    {
                        type = "subtitle",
                        text = "Freshwater fishing is the simple kind.",
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "The waiting part was longer than the catching part.",
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
                            "food",
                            "exploration",
                            "seasons",
                        },
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Use the freshwater rod",
                    },
                    {
                        type = "text",
                        text = [[
A Freshwater Fishing Rod works in ponds and does not need bait. Cast into the pond, wait for a tug, hook the fish, then reel it in.

Each pond holds a limited number of fish and slowly replaces what you catch. If bites start taking much longer, leave it alone for a while and come back later.
]],
                    },
                    {
                        type = "heading",
                        text = "Pick a quiet time",
                    },
                    {
                        type = "text",
                        text = [[
Frog Ponds spawn Frogs during the day, while Marsh Ponds bring out Mosquitoes at dusk and night. If you only want to fish, visit each kind when its residents are less active.

Surface ponds also freeze in winter and cannot be fished until they thaw.
]],
                    },
                },

                note = {},
            },
        },

        {
            illustration = "fishing_ocean",

            regions = {
                top_left = {
                    {
                        type = "page_heading",
                        text = "Ocean fishing",
                    },
                    {
                        type = "text",
                        text = [[
Fishing in the sea uses a Sea Fishing Rod and takes more attention than fishing from a pond. Look for fish shadows in the water and cast near them.
]],
                    },
                },

                illustration_caption = {
                    {
                        type = "caption",
                        text = "Warly was much more interested once the fish started fighting.",
                    },
                },

                right = {
                    {
                        type = "heading",
                        text = "Watch the rod",
                    },
                    {
                        type = "text",
                        text = [[
Once a fish is hooked, it usually pulls away first. Wait while the rod is high and your character is straining.

When the rod drops and the fish swims toward you, reel. Stop again when the rod rises. Reeling against a hard pull can snap the line, while leaving the line loose at the wrong time can let the fish escape.
]],
                    },
                    {
                        type = "heading",
                        text = "Start with simple tackle",
                    },
                    {
                        type = "text",
                        text = [[
Lures make fish more likely to bite. Floats improve casting range and accuracy; both are optional.

A Twig works as a basic float. Seeds, Berries, or Rot work as simple single-use lures.

If you would rather let a net do the waiting, an Ocean Trawler can catch nearby ocean fish too.
]],
                    },
                },

                note = {},
            },
        },
    },
}
