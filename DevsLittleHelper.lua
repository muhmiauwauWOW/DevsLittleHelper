local _, DevsLittleHelper = ...

DLHAddon = LibStub("AceAddon-3.0"):NewAddon("DevsLittleHelper", "AceEvent-3.0");

-- DevsLittleHelper.Options.LogMode

print("DevsLittleHelper loaded")




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
	

	DevsLittleHelper.LogMode.DropDown(self)
end
