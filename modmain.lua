Assets = {
    Asset("ATLAS", "images/ui/base_template.xml"),
    Asset("IMAGE", "images/ui/base_template.tex"),

    Asset("ATLAS", "images/topics/dst101_topics_color.xml"),
    Asset("IMAGE", "images/topics/dst101_topics_color.tex"),

    Asset("ATLAS", "images/topics/dst101_topics_gray.xml"),
    Asset("IMAGE", "images/topics/dst101_topics_gray.tex"),

    Asset("FONT", "fonts/dst101_alegreya_regular.zip"),
    Asset("FONT", "fonts/dst101_alegreya_italic.zip"),
}
local TheInput = GLOBAL.TheInput

local key_by_shortcut = {
    f1 = GLOBAL.KEY_F1,
    f2 = GLOBAL.KEY_F2,
    f3 = GLOBAL.KEY_F3,
    f4 = GLOBAL.KEY_F4,
    f5 = GLOBAL.KEY_F5,
    f6 = GLOBAL.KEY_F6,
    f7 = GLOBAL.KEY_F7,
    f8 = GLOBAL.KEY_F8,
    f9 = GLOBAL.KEY_F9,
    f10 = GLOBAL.KEY_F10,
    f11 = GLOBAL.KEY_F11,
    f12 = GLOBAL.KEY_F12,
}

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

local function reload_handbook()
    GLOBAL.package.loaded["dst101data"] = nil

    if GLOBAL.TheFrontEnd == nil then
        return
    end

    local active_screen = GLOBAL.TheFrontEnd:GetActiveScreen()

    if active_screen ~= nil
        and active_screen.name == "DST101PopupScreen"
        and active_screen.book ~= nil
    then
        active_screen.book:ReloadData()
    end

    print("[dst 101] handbook reloaded")
end

local function bind_shortcut(config_name, callback)
    local shortcut = GetModConfigData(config_name)
    local key = key_by_shortcut[shortcut]

    if key ~= nil then
        TheInput:AddKeyDownHandler(key, callback)
    end
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

bind_shortcut("open_shortcut", open_handbook)
bind_shortcut("reload_shortcut", reload_handbook)

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

