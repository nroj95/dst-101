local Screen = require("widgets/screen")
local Widget = require("widgets/widget")
local ImageButton = require("widgets/dst101quietimagebutton")
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
    if key == KEY_ESCAPE then
        local search_editing =
            self.book.search_edit ~= nil
            and self.book.search_edit.editing

        if down and search_editing then
            self.book.search_escape_consumed = true

            if (self.book.search_query or "") ~= "" then
                self.book:ClearSearch(false)
            else
                self.book:StopSearchEditing()
            end
        end

        if self.book.search_escape_consumed then
            return true
        end
    end

    local search_editing =
        self.book.search_edit ~= nil
        and self.book.search_edit.editing

    -- Enter jumps directly into handbook search.
    if not search_editing
        and down
        and key == KEY_ENTER
        and self.book.search_edit ~= nil
    then
        self.book.search_edit:SetEditing(true)
        return true
    end

    -- Keep keyboard editing routed to search even if mouse hover has
    -- moved visual focus onto another handbook control.
    if search_editing then
        if key == KEY_UP or key == KEY_DOWN then
            if down then
                self.book:NavigateSearchResults(
                    key == KEY_UP and -1 or 1
                )
            end

            return true
        end

        if key == KEY_ENTER then
            return true
        end

        return self.book.search_edit:OnRawKey(key, down)
    end

    local navigation_key = key

    -- WASD mirrors the arrow keys outside text entry.
    if key == KEY_W then
        navigation_key = KEY_UP
    elseif key == KEY_S then
        navigation_key = KEY_DOWN
    elseif key == KEY_A then
        navigation_key = KEY_LEFT
    elseif key == KEY_D then
        navigation_key = KEY_RIGHT
    end

    if navigation_key == KEY_UP
        or navigation_key == KEY_DOWN
        or navigation_key == KEY_LEFT
        or navigation_key == KEY_RIGHT
    then
        if down then
            if navigation_key == KEY_UP then
                self.book:ChangeTopic(-1)
            elseif navigation_key == KEY_DOWN then
                self.book:ChangeTopic(1)
            elseif navigation_key == KEY_LEFT then
                self.book:NavigateBook(-1)
            elseif navigation_key == KEY_RIGHT then
                self.book:NavigateBook(1)
            end
        end

        -- Consume press and release so normal focus movement cannot
        -- react to the same navigation input.
        return true
    end

    return DST101PopupScreen._base.OnRawKey(
        self,
        key,
        down
    )
end

function DST101PopupScreen:OnTextInput(text)
    if self.book.search_edit ~= nil
        and self.book.search_edit.editing
    then
        return self.book.search_edit:OnTextInput(text)
    end

    return DST101PopupScreen._base.OnTextInput(
        self,
        text
    )
end

function DST101PopupScreen:OnControl(control, down)
    if not down
        and (
            control == CONTROL_MENU_BACK
            or control == CONTROL_CANCEL
        )
        and self.book.search_escape_consumed
    then
        self.book.search_escape_consumed = false
        return true
    end

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
