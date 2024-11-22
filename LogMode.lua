local _, DevsLittleHelper = ...




DevsLittleHelper.LogMode  = {}


function DevsLittleHelper.LogMode:DropDown()
    --Verbose, Info, Warning, Error

    local function IsSelected(mode)
        return self.db.global.Options.LogMode[mode];
    end

    local function SetSelected(mode,m,e)
        DevTool:AddData({mode,m,e})
        DevTool:AddData(self)
        self.db.global.Options.LogMode[mode] = not self.db.global.Options.LogMode[mode] 
    end

    local dropdown = DevsLittleHelperFrame.displayFrame.ModeControlDropdown;
    dropdown:SetWidth(100);
    dropdown:SetupMenu(function(dropdown, rootDescription)
        rootDescription:SetTag("MENU_DevsLittleHelperFrame_ModeControlDropdown");
        rootDescription:CreateButton("Default", function()
            self.db.global.Options.LogMode = Mixin({},self.dbDefault.global.Options.LogMode)
        end);

        rootDescription:CreateDivider()
        rootDescription:CreateCheckbox("Verbose", IsSelected, SetSelected, 1);
        rootDescription:CreateCheckbox("Info", IsSelected, SetSelected, 2);
        rootDescription:CreateCheckbox("Warning", IsSelected, SetSelected, 3);
        rootDescription:CreateCheckbox("Error", IsSelected, SetSelected, 4);
    end);
end