local AddonName, DevsLittleHelper = ...
local L, _ = DevsLittleHelper:GetLibs()



DevsLittleHelper.LogMode  = {}


DevsLittleHelper.LogMode.LogTypes = {
    "Verbose",
    "Info",
    "Warning",
    "Error"
}




function DevsLittleHelper.LogMode:DropDown()

    local function IsSelected(mode)
        return self.db.global.Options.LogMode[mode];
    end

    local function SetSelected(mode,m,e)
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

        _.forEach(DevsLittleHelper.LogMode.LogTypes, function(entry, idx)
            rootDescription:CreateCheckbox(entry, IsSelected, SetSelected, idx);
        end)
    end);
end



function DevsLittleHelper.LogMode:Store(addonName, channel, ...)
    DevsLittleHelper.LogMode.StoreTable =  DevsLittleHelper.LogMode.StoreTable or {}

    table.insert( DevsLittleHelper.LogMode.StoreTable, {
        channel = channel,
        addonName = addonName,
        arg = {...}
    })
end


function DevsLittleHelper.LogMode:OutputStore()
    if not DevsLittleHelper.LogMode.StoreTable then return end

    print("Replay log entries before Initialize")
    _.forEach( DevsLittleHelper.LogMode.StoreTable, function(entry)
        self:Output(entry.addonName, entry.channel.. "Store", entry.arg)
    end)
end


function DevsLittleHelper.LogMode:Output(addonName, channel, ...)
    local addonName = addonName or AddonName
    local channel = channel

    local name = string.format("%s-%s", addonName, channel)
    local arg = {...}

    if type(arg[1]) == "table" then
         local localname = arg[2] or "Unnamed"
         name = string.format("%s %s", name, localname)

        if DevTool then 
            DevTool:AddData(arg[1], name)
        else 
            print(name)
            DevTools_Dump(arg[1])
        end
    else
        print(string.format("%s:", name), ...)
    end
end





function DevsLittleHelper.LogMode:LogFunction(idx, obj, ...)
    local typ = DevsLittleHelper.LogMode.LogTypes[idx]
    local addonName = obj.addon and obj.addon.addonName or AddonName

    if DevsLittleHelper.db then 
        if DevsLittleHelper.db.global.Options.LogMode[idx] then
            DevsLittleHelper.LogMode:Output(addonName, typ, ...)
        end
    else
        DevsLittleHelper.LogMode:Store(addonName, typ, ...)
    end
end



function DLH:Verbose(...)
    DevsLittleHelper.LogMode:LogFunction(1, self, ...)
end

function DLH:Info(...) 
    DevsLittleHelper.LogMode:LogFunction(2, self, ...)
end

function DLH:Warning(...)
    DevsLittleHelper.LogMode:LogFunction(3, self, ...)
end

function DLH:Error(...)
    DevsLittleHelper.LogMode:LogFunction(4, self, ...)
end