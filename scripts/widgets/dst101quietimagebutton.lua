local ImageButton = require "widgets/imagebutton"
local Widget = require "widgets/widget"


-- =============================================================================
-- dst 101 quiet image button
--
-- behaves like the normal DST ImageButton, except gaining focus does not play
-- the standard mouseover sound or an optional ImageButton focus sound.
--
-- click sounds remain unchanged.
-- =============================================================================

local DST101QuietImageButton = Class(
    ImageButton,
    function(
        self,
        atlas,
        normal,
        focus,
        disabled,
        down,
        selected,
        scale,
        offset
    )
        ImageButton._ctor(
            self,
            atlas,
            normal,
            focus,
            disabled,
            down,
            selected,
            scale,
            offset
        )
    end
)


function DST101QuietImageButton:OnGainFocus()
    -- Button:OnGainFocus() normally plays:
    --
    --     dontstarve/HUD/click_mouseover
    --
    -- Reproduce its non-audio behaviour directly instead.
    Widget.OnGainFocus(self)

    if self:IsEnabled()
        and not self:IsSelected()
    then
        self.text:SetColour(
            self.textfocuscolour
        )
    end

    if self.ongainfocus then
        self.ongainfocus(
            self:IsEnabled()
        )
    end

    -- Preserve ImageButton's normal visual focus behaviour.
    if self.hover_overlay then
        self.hover_overlay:Show()
    end

    if self:IsSelected()
        or self:IsDisabledState()
    then
        return
    end

    if self:IsEnabled() then
        self.image:SetTexture(
            self.atlas,
            self.image_focus
        )

        if self.size_x
            and self.size_y
        then
            if self.ignore_standard_scaling
                and self.focus_scale
            then
                self.image:ScaleToSize(
                    self.size_x *
                        self.focus_scale[1],
                    self.size_y *
                        self.focus_scale[2]
                )
            else
                self.image:ScaleToSize(
                    self.size_x,
                    self.size_y
                )
            end
        end

        if not self.ignore_standard_scaling
            and self.image_focus ==
                self.image_normal
            and self.scale_on_focus
            and self.focus_scale
        then
            self.image:SetScale(
                self.focus_scale[1],
                self.focus_scale[2],
                self.focus_scale[3]
            )
        end

        if self.imagefocuscolour then
            self.image:SetTint(
                unpack(
                    self.imagefocuscolour
                )
            )
        end

        -- Deliberately omit:
        --
        --   dontstarve/HUD/click_mouseover
        --   self.focus_sound
    end
end


return DST101QuietImageButton
