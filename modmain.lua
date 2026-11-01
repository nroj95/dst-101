-- =============================================================================
-- dst 101 mod entry point
--
-- registers the handbook's runtime assets and fonts, and the ways to open
-- it:
-- - the configured keyboard shortcut. modifiers must match exactly, plain
--   typing keys are ignored while a text field is active, and a key the
--   open handbook navigates with never closes it.
-- - the HUD button beside the map controls, unless turned off in config.
-- - a controller's Menu Misc 3 button, or an LB+RB skill slot when the
--   Simple Controller mod is active.
--
-- closing the popup stores the reading position on the player. opening
-- restores it unless the reopen option is set to always open Contents.
--
-- the developer reload shortcut clears every dst101 module and reopens the
-- handbook at the same place. it does not reload modmain.lua, modinfo.lua,
-- textures or fonts. release builds drop its config options, which leaves
-- it unbound.
-- =============================================================================

local illustration_data = require("dst101illustrations")

Assets = {
    Asset("ATLAS", "images/ui/handbook_base.xml"),
    Asset("IMAGE", "images/ui/handbook_base.tex"),

    Asset("ATLAS", "images/ui/handbook_page.xml"),
    Asset("IMAGE", "images/ui/handbook_page.tex"),

    Asset("ATLAS", "images/ui/dst101_ui.xml"),
    Asset("IMAGE", "images/ui/dst101_ui.tex"),

    Asset("ATLAS", "images/ui/dst101_toc_grid.xml"),
    Asset("IMAGE", "images/ui/dst101_toc_grid.tex"),

    Asset("ATLAS", "images/topics/dst101_topics_color.xml"),
    Asset("IMAGE", "images/topics/dst101_topics_color.tex"),

    Asset("ATLAS", "images/topics/dst101_topics_gray.xml"),
    Asset("IMAGE", "images/topics/dst101_topics_gray.tex"),

    Asset("FONT", "fonts/dst101_alegreya_regular.zip"),
    Asset("FONT", "fonts/dst101_alegreya_italic.zip"),
}

for _, illustration_atlas in ipairs(illustration_data.atlases) do
    table.insert(Assets, Asset("ATLAS", illustration_atlas.atlas))

    table.insert(Assets, Asset("IMAGE", illustration_atlas.image))
end

local TheInput = GLOBAL.TheInput

-- Shortcut names follow the game's KEY_* constants, apart from the
-- game's own KEY_SCROLLOCK spelling. rawget keeps strict mode quiet
-- for names such as "disabled".
local function get_key(shortcut)
    if shortcut == "scrolllock" then
        return GLOBAL.KEY_SCROLLOCK
    end

    return GLOBAL.rawget(GLOBAL, "KEY_" .. string.upper(shortcut))
end

-- Single letters and digits type text, and so do these.
local text_input_shortcuts = {
    tab = true,
    minus = true,
    equals = true,
    space = true,
    enter = true,
    backspace = true,
    period = true,
    slash = true,
    semicolon = true,
    leftbracket = true,
    backslash = true,
    rightbracket = true,
    tilde = true,
}

local function types_text(shortcut)
    return #shortcut == 1 or text_input_shortcuts[shortcut] == true
end

-- Modifier names such as "ctrl_shift" list the keys they require.
-- Matching is exact, so "ctrl" also requires Shift and Alt to be up.
local function modifiers_match(modifier_name)
    local function requires(name)
        return modifier_name:find(name, 1, true) ~= nil
    end

    return TheInput:IsKeyDown(GLOBAL.KEY_CTRL) == requires("ctrl")
        and TheInput:IsKeyDown(GLOBAL.KEY_SHIFT) == requires("shift")
        and TheInput:IsKeyDown(GLOBAL.KEY_ALT) == requires("alt")
end

-- Keys the open handbook uses itself.
local handbook_keys = {
    tab = true,
    enter = true,
    escape = true,
    up = true,
    down = true,
    left = true,
    right = true,
    w = true,
    a = true,
    s = true,
    d = true,
}

local function get_handbook_screen()
    local active_screen = GLOBAL.TheFrontEnd ~= nil
        and GLOBAL.TheFrontEnd:GetActiveScreen()

    if active_screen and active_screen.name == "DST101PopupScreen" then
        return active_screen
    end
end

local function is_text_input_active()
    if GLOBAL.TheFrontEnd == nil then
        return false
    end

    if GLOBAL.TheFrontEnd.forceProcessText == true then
        return true
    end

    local screen = get_handbook_screen()

    return screen ~= nil and screen.book.search_edit.editing == true
end

local function is_simple_controller_active()
    local player = GLOBAL.ThePlayer

    return player ~= nil and player.components.simplecontroller ~= nil
end

-- The popup saves the reading position on the player when it closes.
local function push_handbook(player, restore_position)
    local DST101PopupScreen = require("screens/dst101popupscreen")

    local screen = DST101PopupScreen(player)

    GLOBAL.TheFrontEnd:PushScreen(screen)

    local state = player._dst101_handbook_state

    if restore_position and state ~= nil then
        screen.book:RestoreState(state)
    end
end

local function open_handbook()
    if
        GLOBAL.ThePlayer == nil
        or GLOBAL.TheWorld == nil
        or GLOBAL.TheFrontEnd == nil
    then
        return
    end

    if get_handbook_screen() ~= nil then
        GLOBAL.TheFrontEnd:PopScreen()
        return
    end

    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()

    if active_screen == nil or active_screen.name ~= "HUD" then
        return
    end

    push_handbook(
        GLOBAL.ThePlayer,
        GetModConfigData("reopen_behavior") ~= "contents"
    )
end

-- Every handbook module, topics included, carries "dst101" in its name.
local function clear_handbook_modules()
    for module_name in pairs(GLOBAL.package.loaded) do
        if
            type(module_name) == "string"
            and module_name:find("dst101", 1, true)
        then
            GLOBAL.package.loaded[module_name] = nil
        end
    end
end

local function reload_handbook()
    local was_open = get_handbook_screen() ~= nil

    if was_open then
        GLOBAL.TheFrontEnd:PopScreen()
    end

    clear_handbook_modules()

    local player = GLOBAL.ThePlayer

    if not was_open or player == nil or not player:IsValid() then
        print("[dst 101] handbook modules reloaded")
        return
    end

    player:DoTaskInTime(0, function()
        push_handbook(player, true)

        print("[dst 101] handbook hot reloaded")
    end)
end

local function bind_shortcut(key_config_name, modifier_config_name, callback)
    local shortcut = GetModConfigData(key_config_name)

    local modifier = GetModConfigData(modifier_config_name) or "none"

    -- Release builds drop the reload options, leaving shortcut nil.
    local key = shortcut ~= nil and get_key(shortcut)

    if not key then
        return
    end

    TheInput:AddKeyDownHandler(key, function()
        if not modifiers_match(modifier) then
            return
        end

        -- An open key the handbook also uses for navigation must not
        -- close it mid-navigation.
        if
            key_config_name == "open_shortcut"
            and handbook_keys[shortcut]
            and get_handbook_screen() ~= nil
        then
            return
        end

        -- Do not steal ordinary typing keys from active text fields.
        -- Function/navigation keys such as F5 still work normally.
        if
            is_text_input_active()
            and modifier == "none"
            and types_text(shortcut)
        then
            return
        end

        callback()
    end)
end

local function open_handbook_from_controller(down)
    if
        down
        or not TheInput:ControllerAttached()
        or is_simple_controller_active()
    then
        return
    end

    open_handbook()
end

local function add_simple_controller_skill(player)
    local attempts = 0

    local function try_register()
        attempts = attempts + 1

        if not player:IsValid() then
            return
        end

        local simple_controller = player.components.simplecontroller

        if
            simple_controller ~= nil
            and simple_controller.AddTemporarySkill ~= nil
        then
            local slot = simple_controller:AddTemporarySkill(
                "LBRB",
                "UP",
                function(_, down)
                    if not down then
                        open_handbook()
                    end
                end,
                "dst 101",
                nil,
                true,
                "dst101",
                nil,
                nil,
                { 6, 7, 8, 3, 4, 1, 2, 9, 10 }
            )

            if slot ~= nil then
                print("[dst 101] simple controller skill registered")
            else
                print("[dst 101] simple controller skill unavailable")
            end

            return
        end

        if attempts < 20 then
            player:DoTaskInTime(0.25, try_register)
        end
    end

    player:DoTaskInTime(0, try_register)
end

if GetModConfigData("show_hud_button") ~= false then
    local shortcut_display_names = {
        up = "Up Arrow",
        down = "Down Arrow",
        left = "Left Arrow",
        right = "Right Arrow",
        pageup = "Page Up",
        pagedown = "Page Down",
        backspace = "Backspace",
        escape = "Escape",
        minus = "-",
        equals = "=",
        period = ".",
        slash = "/",
        semicolon = ";",
        leftbracket = "[",
        backslash = "\\",
        rightbracket = "]",
        tilde = "`",
        print = "Print Screen",
        capslock = "Caps Lock",
        scrolllock = "Scroll Lock",
        kp_period = "Numpad .",
        kp_divide = "Numpad /",
        kp_multiply = "Numpad *",
        kp_minus = "Numpad -",
        kp_plus = "Numpad +",
        kp_enter = "Numpad Enter",
        kp_equals = "Numpad =",
    }

    local modifier_display_names = {
        ctrl = "Ctrl",
        shift = "Shift",
        alt = "Alt",
        ctrl_shift = "Ctrl + Shift",
        ctrl_alt = "Ctrl + Alt",
        shift_alt = "Shift + Alt",
        ctrl_shift_alt = "Ctrl + Shift + Alt",
    }

    local function get_handbook_shortcut_label()
        local shortcut = GetModConfigData("open_shortcut")

        if shortcut == nil or shortcut == "disabled" then
            return nil
        end

        local key_label = shortcut_display_names[shortcut]

        if key_label == nil then
            if string.sub(shortcut, 1, 3) == "kp_" then
                key_label = "Numpad " .. string.sub(shortcut, 4)
            else
                key_label = string.upper(shortcut)
            end
        end

        local modifier = GetModConfigData("open_modifier") or "none"

        local modifier_label = modifier_display_names[modifier]

        if modifier_label ~= nil then
            return modifier_label .. " + " .. key_label
        end

        return key_label
    end

    AddClassPostConstruct("widgets/mapcontrols", function(self)
        local ImageButton = require("widgets/imagebutton")

        self.dst101_handbook_button = self:AddChild(
            ImageButton("images/ui/dst101_ui.xml", "hud_handbook.tex")
        )

        self.dst101_handbook_button:SetScale(0.72, 0.72, 0.72)

        self.dst101_handbook_button:SetPosition(-101, -26, 0)

        local shortcut_label = get_handbook_shortcut_label()

        local tooltip = "Show Handbook"

        if shortcut_label ~= nil then
            tooltip = tooltip .. "\n(" .. shortcut_label .. ")"
        end

        self.dst101_handbook_button:SetTooltip(tooltip)

        self.dst101_handbook_button:SetOnClick(open_handbook)
    end)
end

bind_shortcut("open_shortcut", "open_modifier", open_handbook)

bind_shortcut("reload_shortcut", "reload_modifier", reload_handbook)

TheInput:AddControlHandler(
    GLOBAL.CONTROL_MENU_MISC_3,
    open_handbook_from_controller
)

AddPlayerPostInit(add_simple_controller_skill)

-- =============================================================================
-- custom fonts
-- =============================================================================

local DST101_FONTS = {
    {
        filename = MODROOT .. "fonts/dst101_alegreya_regular.zip",
        alias = "dst101_alegreya_regular",
    },
    {
        filename = MODROOT .. "fonts/dst101_alegreya_italic.zip",
        alias = "dst101_alegreya_italic",
    },
}

for _, font in ipairs(DST101_FONTS) do
    table.insert(GLOBAL.FONTS, {
        filename = font.filename,
        alias = font.alias,
        fallback = GLOBAL.DEFAULT_FALLBACK_TABLE,
    })
end

AddSimPostInit(GLOBAL.LoadFonts)
