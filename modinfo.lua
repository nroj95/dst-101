name = "dst 101 (dev)"
description = "a simple in-game guide to dst's basics and survival systems"
author = "nroj"
version = "0.0.1"

api_version = 10
dst_compatible = true
client_only_mod = true
all_clients_require_mod = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

local function add_option(options, description, data)
    options[#options + 1] = {
        description = description,
        data = data,
    }
end


local function shortcut_options()
    return {
        { description = "Disabled", data = "disabled" },

        { description = "F1", data = "f1" },
        { description = "F2", data = "f2" },
        { description = "F3", data = "f3" },
        { description = "F4", data = "f4" },
        { description = "F5", data = "f5" },
        { description = "F6", data = "f6" },
        { description = "F7", data = "f7" },
        { description = "F8", data = "f8" },
        { description = "F9", data = "f9" },
        { description = "F10", data = "f10" },
        { description = "F11", data = "f11" },
        { description = "F12", data = "f12" },

        { description = "A", data = "a" },
        { description = "B", data = "b" },
        { description = "C", data = "c" },
        { description = "D", data = "d" },
        { description = "E", data = "e" },
        { description = "F", data = "f" },
        { description = "G", data = "g" },
        { description = "H", data = "h" },
        { description = "I", data = "i" },
        { description = "J", data = "j" },
        { description = "K", data = "k" },
        { description = "L", data = "l" },
        { description = "M", data = "m" },
        { description = "N", data = "n" },
        { description = "O", data = "o" },
        { description = "P", data = "p" },
        { description = "Q", data = "q" },
        { description = "R", data = "r" },
        { description = "S", data = "s" },
        { description = "T", data = "t" },
        { description = "U", data = "u" },
        { description = "V", data = "v" },
        { description = "W", data = "w" },
        { description = "X", data = "x" },
        { description = "Y", data = "y" },
        { description = "Z", data = "z" },

        { description = "0", data = "0" },
        { description = "1", data = "1" },
        { description = "2", data = "2" },
        { description = "3", data = "3" },
        { description = "4", data = "4" },
        { description = "5", data = "5" },
        { description = "6", data = "6" },
        { description = "7", data = "7" },
        { description = "8", data = "8" },
        { description = "9", data = "9" },

        { description = "Up arrow", data = "up" },
        { description = "Down arrow", data = "down" },
        { description = "Left arrow", data = "left" },
        { description = "Right arrow", data = "right" },

        { description = "Home", data = "home" },
        { description = "End", data = "end" },
        { description = "Page Up", data = "pageup" },
        { description = "Page Down", data = "pagedown" },
        { description = "Insert", data = "insert" },
        { description = "Delete", data = "delete" },

        { description = "Tab", data = "tab" },
        { description = "Space", data = "space" },
        { description = "Enter", data = "enter" },
        { description = "Backspace", data = "backspace" },
        { description = "Escape", data = "escape" },

        { description = "Minus (-)", data = "minus" },
        { description = "Equals (=)", data = "equals" },
        { description = "Period (.)", data = "period" },
        { description = "Slash (/)", data = "slash" },
        { description = "Semicolon (;)", data = "semicolon" },
        { description = "Left bracket ([)", data = "leftbracket" },
        { description = "Backslash (\\)", data = "backslash" },
        { description = "Right bracket (])", data = "rightbracket" },
        { description = "Tilde (`)", data = "tilde" },

        { description = "Pause", data = "pause" },
        { description = "Print Screen", data = "print" },
        { description = "Caps Lock", data = "capslock" },
        { description = "Scroll Lock", data = "scrolllock" },

        { description = "Numpad 0", data = "kp_0" },
        { description = "Numpad 1", data = "kp_1" },
        { description = "Numpad 2", data = "kp_2" },
        { description = "Numpad 3", data = "kp_3" },
        { description = "Numpad 4", data = "kp_4" },
        { description = "Numpad 5", data = "kp_5" },
        { description = "Numpad 6", data = "kp_6" },
        { description = "Numpad 7", data = "kp_7" },
        { description = "Numpad 8", data = "kp_8" },
        { description = "Numpad 9", data = "kp_9" },

        { description = "Numpad period", data = "kp_period" },
        { description = "Numpad divide", data = "kp_divide" },
        { description = "Numpad multiply", data = "kp_multiply" },
        { description = "Numpad minus", data = "kp_minus" },
        { description = "Numpad plus", data = "kp_plus" },
        { description = "Numpad Enter", data = "kp_enter" },
        { description = "Numpad equals", data = "kp_equals" },
    }
end


local modifier_options = {
    { description = "None", data = "none" },
    { description = "Ctrl", data = "ctrl" },
    { description = "Shift", data = "shift" },
    { description = "Alt", data = "alt" },
    { description = "Ctrl + Shift", data = "ctrl_shift" },
    { description = "Ctrl + Alt", data = "ctrl_alt" },
    { description = "Shift + Alt", data = "shift_alt" },
    {
        description = "Ctrl + Shift + Alt",
        data = "ctrl_shift_alt",
    },
}


local shortcuts = shortcut_options()


configuration_options = {
    {
        name = "show_hud_button",
        label = "Show handbook HUD button",
        hover = "Shows a DST 101 button beside the map controls.",
        options = {
            { description = "Enabled", data = true },
            { description = "Disabled", data = false },
        },
        default = true,
    },
    {
        name = "open_shortcut",
        label = "Open handbook key",
        hover = "Opens or closes DST 101 while playing.",
        options = shortcuts,
        default = "b",
    },
    {
        name = "open_modifier",
        label = "Open handbook modifier",
        hover = "Optional modifier keys required with the handbook key.",
        options = modifier_options,
        default = "none",
    },
    {
        name = "reload_shortcut",
        label = "Developer: reload handbook key",
        hover = "Hot-reloads handbook Lua while developing or testing changes.",
        options = shortcuts,
        default = "disabled",
    },
    {
        name = "reload_modifier",
        label = "Developer: reload modifier",
        hover = "Optional modifier keys required with the reload key.",
        options = modifier_options,
        default = "none",
    },
}
