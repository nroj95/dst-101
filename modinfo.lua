name = "dst 101 (dev)"
description = "a simple in-game guide to dst's basics and survival systems"
author = "nroj"
version = "0.0.1"

api_version = 10
dst_compatible = true
client_only_mod = true
all_clients_require_mod = false

local function shortcut_options()
    local options = {
        { description = "Disabled", data = "disabled" },
    }

    for number = 1, 12 do
        options[#options + 1] = {
            description = "F" .. number,
            data = "f" .. number,
        }
    end

    return options
end

local shortcuts = shortcut_options()

configuration_options = {
    {
        name = "open_shortcut",
        label = "Open handbook shortcut",
        hover = "Opens DST 101 while playing.",
        options = shortcuts,
        default = "f5",
    },
    {
        name = "reload_shortcut",
        label = "Reload handbook shortcut",
        hover = "Reloads handbook topics and pages from disk without restarting DST.",
        options = shortcuts,
        default = "f7",
    },
}