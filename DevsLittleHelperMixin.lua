local AddonName, DevsLittleHelper = ...
local AddOnInfo = {C_AddOns.GetAddOnInfo(AddonName)}


local DLHMixin = {}





function DLHMixin:OnLoad()
    -- print("load")

    self:Collapse()
    self.displayFrame.label:SetText(AddOnInfo[2]);

    self.BGPartyRegulars:Show();

end

function DLHMixin:Toggle()
    if ( self.collapsed ) then
		self:Expand();
	else
		self:Collapse();
	end
end


function DLHMixin:Expand()
	self.collapsed = false;
	self:SetPoint("TOPLEFT", UIParent, "TOPLEFT",0, -140);
	self.displayFrame:Show();
	self.toggleButton:GetNormalTexture():SetTexCoord(0.5, 1, 0, 1);

    self.reloadButton:SetPoint("TOPRIGHT", -11, -2);

end


function DLHMixin:Collapse()
	self.collapsed = true;
	self:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -200, -140);
	self.displayFrame:Hide();
	self.toggleButton:GetNormalTexture():SetTexCoord(0, 0.5, 0, 1);
    self.reloadButton:SetPoint("TOPRIGHT", 25, -2);
end



DevsLittleHelperMixin = DLHMixin





local ToggleButtonMixin = {}



function ToggleButtonMixin:OnLoad()
    -- print("ToggleButtonMixin:OnLoad")
    self:GetNormalTexture():SetDrawLayer("OVERLAY");
end

function ToggleButtonMixin:OnClick()
    -- print("ToggleButtonMixin:OnClick")
    self:GetParent():Toggle();
end

function ToggleButtonMixin:OnMouseUp()
    -- print("ToggleButtonMixin:OnMouseUp")
    local tex = self:GetNormalTexture();
	tex:SetAllPoints();
end

function ToggleButtonMixin:OnMouseDown()
    -- print("ToggleButtonMixin:OnMouseDown")
    local tex = self:GetNormalTexture();
    tex:ClearAllPoints();
    tex:SetSize(self:GetSize());
    tex:SetPoint("CENTER", 1, 0);
end






DevsLittleHelperToggleButtonMixin = ToggleButtonMixin

