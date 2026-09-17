Assets = {
    Asset("ATLAS", "images/ui/base_template.xml"),
    Asset("IMAGE", "images/ui/base_template.tex"),

    Asset("ATLAS", "images/ui/dst101_ui.xml"),
    Asset("IMAGE", "images/ui/dst101_ui.tex"),

    Asset("ATLAS", "images/topics/dst101_topics_color.xml"),
    Asset("IMAGE", "images/topics/dst101_topics_color.tex"),

    Asset("ATLAS", "images/topics/dst101_topics_gray.xml"),
    Asset("IMAGE", "images/topics/dst101_topics_gray.tex"),

    Asset("FONT", "fonts/dst101_alegreya_regular.zip"),
    Asset("FONT", "fonts/dst101_alegreya_italic.zip"),
}
local TheInput = GLOBAL.TheInput

local key_by_shortcut = {
    tab = GLOBAL.KEY_TAB,
    minus = GLOBAL.KEY_MINUS,
    equals = GLOBAL.KEY_EQUALS,
    space = GLOBAL.KEY_SPACE,
    enter = GLOBAL.KEY_ENTER,
    escape = GLOBAL.KEY_ESCAPE,
    home = GLOBAL.KEY_HOME,
    insert = GLOBAL.KEY_INSERT,
    delete = GLOBAL.KEY_DELETE,
    ["end"] = GLOBAL.KEY_END,
    pause = GLOBAL.KEY_PAUSE,
    print = GLOBAL.KEY_PRINT,
    capslock = GLOBAL.KEY_CAPSLOCK,
    scrolllock = GLOBAL.KEY_SCROLLOCK,
    backspace = GLOBAL.KEY_BACKSPACE,
    period = GLOBAL.KEY_PERIOD,
    slash = GLOBAL.KEY_SLASH,
    semicolon = GLOBAL.KEY_SEMICOLON,
    leftbracket = GLOBAL.KEY_LEFTBRACKET,
    backslash = GLOBAL.KEY_BACKSLASH,
    rightbracket = GLOBAL.KEY_RIGHTBRACKET,
    tilde = GLOBAL.KEY_TILDE,

    up = GLOBAL.KEY_UP,
    down = GLOBAL.KEY_DOWN,
    right = GLOBAL.KEY_RIGHT,
    left = GLOBAL.KEY_LEFT,
    pageup = GLOBAL.KEY_PAGEUP,
    pagedown = GLOBAL.KEY_PAGEDOWN,

    kp_period = GLOBAL.KEY_KP_PERIOD,
    kp_divide = GLOBAL.KEY_KP_DIVIDE,
    kp_multiply = GLOBAL.KEY_KP_MULTIPLY,
    kp_minus = GLOBAL.KEY_KP_MINUS,
    kp_plus = GLOBAL.KEY_KP_PLUS,
    kp_enter = GLOBAL.KEY_KP_ENTER,
    kp_equals = GLOBAL.KEY_KP_EQUALS,
}

for number = 1, 12 do
    key_by_shortcut["f" .. number] =
        GLOBAL["KEY_F" .. number]
end

for code = string.byte("a"), string.byte("z") do
    local letter = string.char(code)

    key_by_shortcut[letter] =
        GLOBAL["KEY_" .. string.upper(letter)]
end

for number = 0, 9 do
    key_by_shortcut[tostring(number)] =
        GLOBAL["KEY_" .. number]

    key_by_shortcut["kp_" .. number] =
        GLOBAL["KEY_KP_" .. number]
end


local modifier_requirements = {
    none = {
        ctrl = false,
        shift = false,
        alt = false,
    },
    ctrl = {
        ctrl = true,
        shift = false,
        alt = false,
    },
    shift = {
        ctrl = false,
        shift = true,
        alt = false,
    },
    alt = {
        ctrl = false,
        shift = false,
        alt = true,
    },
    ctrl_shift = {
        ctrl = true,
        shift = true,
        alt = false,
    },
    ctrl_alt = {
        ctrl = true,
        shift = false,
        alt = true,
    },
    shift_alt = {
        ctrl = false,
        shift = true,
        alt = true,
    },
    ctrl_shift_alt = {
        ctrl = true,
        shift = true,
        alt = true,
    },
}


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

for code = string.byte("a"), string.byte("z") do
    text_input_shortcuts[string.char(code)] = true
end

for number = 0, 9 do
    text_input_shortcuts[tostring(number)] = true
end


local function modifiers_match(modifier_name)
    local required =
        modifier_requirements[modifier_name]
        or modifier_requirements.none

    return TheInput:IsKeyDown(GLOBAL.KEY_CTRL)
            == required.ctrl
        and TheInput:IsKeyDown(GLOBAL.KEY_SHIFT)
            == required.shift
        and TheInput:IsKeyDown(GLOBAL.KEY_ALT)
            == required.alt
end


local function is_text_input_active()
    if GLOBAL.TheFrontEnd == nil then
        return false
    end

    if GLOBAL.TheFrontEnd.forceProcessText == true then
        return true
    end

    local active_screen =
        GLOBAL.TheFrontEnd:GetActiveScreen()

    return active_screen ~= nil
        and active_screen.name == "DST101PopupScreen"
        and active_screen.book ~= nil
        and active_screen.book.search_edit ~= nil
        and active_screen.book.search_edit.editing == true
end


local function is_simple_controller_active()
    local player = GLOBAL.ThePlayer

    return player ~= nil
        and player.components ~= nil
        and player.components.simplecontroller ~= nil
end

local function open_handbook()
    if GLOBAL.ThePlayer == nil
        or GLOBAL.TheWorld == nil
        or GLOBAL.TheFrontEnd == nil
    then
        return
    end

    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()

    if active_screen ~= nil
        and active_screen.name == "DST101PopupScreen"
    then
        GLOBAL.TheFrontEnd:PopScreen()
        return
    end

    if active_screen == nil
        or active_screen.name ~= "HUD"
    then
        return
    end

    local DST101PopupScreen =
        require("screens/dst101popupscreen")

    GLOBAL.TheFrontEnd:PushScreen(
        DST101PopupScreen(GLOBAL.ThePlayer)
    )
end

local function clear_handbook_modules()
    local modules = {
        "dst101data",
        "dst101layout",
        "widgets/dst101widget",
        "screens/dst101popupscreen",
    }

    for _, module_name in ipairs(modules) do
        GLOBAL.package.loaded[module_name] = nil
    end
end


local function reload_handbook()
    if GLOBAL.TheFrontEnd == nil then
        return
    end

    local active_screen =
        GLOBAL.TheFrontEnd:GetActiveScreen()

    local was_open =
        active_screen ~= nil
        and active_screen.name == "DST101PopupScreen"

    local topic_id = nil
    local page_number = nil

    if was_open and active_screen.book ~= nil then
        topic_id =
            active_screen.book.current_topic_id

        page_number =
            active_screen.book.current_page
    end

    if was_open then
        GLOBAL.TheFrontEnd:PopScreen()
    end

    clear_handbook_modules()

    if not was_open then
        print("[dst 101] handbook modules reloaded")
        return
    end

    local player = GLOBAL.ThePlayer

    if player == nil or not player:IsValid() then
        print("[dst 101] handbook modules reloaded")
        return
    end

    player:DoTaskInTime(0, function()
        if GLOBAL.TheFrontEnd == nil then
            return
        end

        local DST101PopupScreen =
            require("screens/dst101popupscreen")

        local screen =
            DST101PopupScreen(player)

        GLOBAL.TheFrontEnd:PushScreen(screen)

        if screen.book ~= nil
            and topic_id ~= nil
        then
            screen.book:SetCurrentTopic(
                topic_id,
                page_number or 1
            )
        end

        print("[dst 101] handbook hot reloaded")
    end)
end

local function bind_shortcut(
    key_config_name,
    modifier_config_name,
    callback
)
    local shortcut =
        GetModConfigData(key_config_name)

    local modifier =
        GetModConfigData(modifier_config_name)
        or "none"

    local key = key_by_shortcut[shortcut]

    if key == nil then
        return
    end

    TheInput:AddKeyDownHandler(
        key,
        function()
            if not modifiers_match(modifier) then
                return
            end

            -- Do not steal ordinary typing keys from active text fields.
            -- Function/navigation keys such as F5 still work normally.
            if is_text_input_active()
                and modifier == "none"
                and text_input_shortcuts[shortcut]
            then
                return
            end

            callback()
        end
    )
end

local function open_handbook_from_controller(down)
    if down
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

        if player == nil or not player:IsValid() then
            return
        end

        local simple_controller =
            player.components
            and player.components.simplecontroller

        if simple_controller ~= nil
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
                print(
                    "[dst 101] simple controller skill registered"
                )
            else
                print(
                    "[dst 101] simple controller skill unavailable"
                )
            end

            return
        end

        if attempts < 20 then
            player:DoTaskInTime(0.25, try_register)
        end
    end

    player:DoTaskInTime(0, try_register)
end

bind_shortcut(
    "open_shortcut",
    "open_modifier",
    open_handbook
)

bind_shortcut(
    "reload_shortcut",
    "reload_modifier",
    reload_handbook
)

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
