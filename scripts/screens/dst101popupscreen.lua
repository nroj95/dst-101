-- =============================================================================
-- dst 101 popup screen
--
-- hosts the handbook widget over a dimmed backdrop that closes it when
-- clicked, requests autopause while open, and routes the keyboard:
-- - Escape leaves search first, clearing a non-empty query, then closes.
-- - Tab toggles between Contents and the last reading location.
-- - Enter starts search. while searching, Up/Down step through results
--   and other keys go to the search field even if hover moved focus.
-- - otherwise Up/Down (W/S) change topic and Left/Right (A/D) turn pages,
--   continuing into the neighbouring topic.
--
-- closing stores the reading position on the owner for the next opening.
-- =============================================================================

local Screen = require("widgets/screen")
local Widget = require("widgets/widget")
local ImageButton = require("widgets/dst101quietimagebutton")
local DST101Widget = require("widgets/dst101widget")

-- Outside search, WASD mirrors the arrow keys.
local NAVIGATION_KEYS = {
    [KEY_UP] = { "ChangeTopic", -1 },
    [KEY_W] = { "ChangeTopic", -1 },
    [KEY_DOWN] = { "ChangeTopic", 1 },
    [KEY_S] = { "ChangeTopic", 1 },
    [KEY_LEFT] = { "NavigateBook", -1 },
    [KEY_A] = { "NavigateBook", -1 },
    [KEY_RIGHT] = { "NavigateBook", 1 },
    [KEY_D] = { "NavigateBook", 1 },
}

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
    if self.owner:IsValid() then
        self.owner._dst101_handbook_state =
            self.book:GetState()
    end

    SetAutopaused(false)

    DST101PopupScreen._base.OnDestroy(self)
end

function DST101PopupScreen:OnRawKey(key, down)
    local search_editing = self.book.search_edit.editing

    if key == KEY_ESCAPE then
        if down and search_editing then
            self.book.search_escape_consumed = true

            if self.book.search_query ~= "" then
                self.book:ClearSearch(false)
            else
                self.book:StopSearchEditing()
            end
        end

        if self.book.search_escape_consumed then
            return true
        end
    end

    -- Tab toggles between Contents and the previous reading location.
    if key == KEY_TAB then
        if down then
            self.book:ToggleContents()
        end

        return true
    end

    -- Enter jumps directly into handbook search.
    if not search_editing
        and down
        and key == KEY_ENTER
    then
        self.book.search_edit:SetEditing(true)
        return true
    end

    -- Keep keyboard editing routed to search even if mouse hover has
    -- moved visual focus onto another handbook control.
    if search_editing then
        if key == KEY_UP or key == KEY_DOWN then
            if down then
                self.book:ChangeTopic(
                    key == KEY_UP and -1 or 1,
                    "search"
                )
            end

            return true
        end

        if key == KEY_ENTER then
            return true
        end

        return self.book.search_edit:OnRawKey(key, down)
    end

    local navigation = NAVIGATION_KEYS[key]

    if navigation ~= nil then
        if down then
            local method, offset = unpack(navigation)

            self.book[method](self.book, offset)
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
    if self.book.search_edit.editing then
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
