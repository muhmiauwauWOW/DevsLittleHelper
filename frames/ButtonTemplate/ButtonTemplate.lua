local AddonName, DevsLittleHelper = ...

local ButtonMixin = {}







function ButtonMixin:OnShow()

    if not self.Icon then return end
    self.iconTexture:SetAtlas(self.Icon, TextureKitConstants.IgnoreAtlasSize);
end

function ButtonMixin:OnEnter()
	if self.backgroundTexture:GetAtlas() == "GM-button-marker-available" then
		self.backgroundTexture:SetAtlas("GM-button-marker-hover", TextureKitConstants.IgnoreAtlasSize);
	end
end

function ButtonMixin:OnLeave()
	if self.backgroundTexture:GetAtlas() == "GM-button-marker-hover" then
		self.backgroundTexture:SetAtlas("GM-button-marker-available", TextureKitConstants.IgnoreAtlasSize);
	end
end




DevsLittleHelperButtonMixin = ButtonMixin





















DevsLittleHelperButtonMixin = ButtonMixin

