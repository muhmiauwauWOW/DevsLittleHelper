local AddonName, DevsLittleHelper = ...

DLHAddon = LibStub("AceAddon-3.0"):NewAddon("DevsLittleHelper", "AceEvent-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale("DevsLittleHelper")
local _ = LibStub("LibLodash-1"):Get()

function DevsLittleHelper:GetLibs()
	return L, _
end




DLH = {}

function DLH:Setup(addonName)

	local opts = {
		addon = {
			addonName = addonName
		}
	}

  return Mixin({}, self, opts)
end


local default_global_data = {
	global = {
		Options = {
			LogMode = { false, true, true, true } -- Verbose, Info, Warning, Error
		},
	}
}

function DLHAddon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DevsLittleHelperDB", default_global_data, true)
	self.dbDefault = Mixin({}, default_global_data)
	DevsLittleHelper.db = self.db
	DevsLittleHelper.LogMode.DropDown(self)

end


function DLHAddon:OnEnable()
	DevsLittleHelper.LogMode:OutputStore()
end