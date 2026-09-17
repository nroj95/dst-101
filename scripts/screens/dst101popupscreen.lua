local Screen = require("widgets/screen")
local Widget = require("widgets/widget")
local ImageButton = require("widgets/imagebutton")
local DST101Widget = require("widgets/dst101widget")

local DST101PopupScreen = Class(Screen, function(self, owner)
    self.owner = owner

    Screen._ctor(self, "DST101PopupScreen")

    local black = self:AddChild(
        ImageButton("images/global.xml", "square.tex")
    )

    black.image:SetVRegPoint(ANCHOR_MIDDLE)
    black.image:SetHRegPoint(ANCHOR_MIDDLE)
    black.image:SetVAnchor(ANCHOR_MIDDLE)
    black.image:SetHAnchor(ANCHOR_MIDDLE)
    black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    black.image:SetTint(0, 0, 0, 0.5)
    black:SetOnClick(function()
        TheFrontEnd:PopScreen()
    end)
    black:SetHelpTextMessage("")

    local root = self:AddChild(Widget("root"))
    root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    root:SetHAnchor(ANCHOR_MIDDLE)
    root:SetVAnchor(ANCHOR_MIDDLE)
    root:SetPosition(0, -25)

    self.book = root:AddChild(DST101Widget(owner))
    self.default_focus = self.book

    SetAutopaused(true)
end)

function DST101PopupScreen:OnDestroy()
    SetAutopaused(false)

    DST101PopupScreen._base.OnDestroy(self)
end

function DST101PopupScreen:OnRawKey(key, down)
    if key == KEY_UP
        or key == KEY_DOWN
        or key == KEY_LEFT
        or key == KEY_RIGHT
    then
        if down then
            if key == KEY_UP then
                self.book:ChangeTopic(-1)
            elseif key == KEY_DOWN then
                self.book:ChangeTopic(1)
            elseif key == KEY_LEFT then
                self.book:NavigateBook(-1)
            elseif key == KEY_RIGHT then
                self.book:NavigateBook(1)
            end
        end

        -- Consume both press and release so normal focus movement
        -- cannot also react to the same physical arrow key.
        return true
    end

    return DST101PopupScreen._base.OnRawKey(
        self,
        key,
        down
    )
end

function DST101PopupScreen:OnControl(control, down)
    if DST101PopupScreen._base.OnControl(self, control, down) then
        return true
    end

    if not down
        and (control == CONTROL_MENU_BACK or control == CONTROL_CANCEL)
    then
        TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
        TheFrontEnd:PopScreen()
        return true
    end

    return false
end

function DST101PopupScreen:GetHelpText()
    local controller_id = TheInput:GetControllerID()

    return TheInput:GetLocalizedControl(
        controller_id,
        CONTROL_CANCEL
    ) .. " " .. STRINGS.UI.HELP.BACK
end

return DST101PopupScreen
