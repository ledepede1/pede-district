-- Function to get the players license
function GetPlayerCFXID(player)
    local value = -1
    for _,v in pairs(GetPlayerIdentifiers(player)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            value = v
            return value
        end
    end
    return value
end

-- Event that gets triggered when player is loaded in 
-- Checks if the player is already created in the database and 
-- if not then create player
RegisterNetEvent("playerSpawn:Pede") 
AddEventHandler("playerSpawn:Pede", function ()
    
    local source = source
    local license = GetPlayerCFXID(source)
    local list = MySQL.Sync.fetchAll('SELECT * FROM `settings_district_pede` WHERE `pedeid` = ?', {
        license
    })
    if not list[1] then
        MySQL.Sync.execute("INSERT INTO `settings_district_pede` (pedeid, enabled) VALUES (@pedeid, @number)",
        {
            ['@pedeid'] = license,
            ['@number'] = 1
        })
    end
end)

-- Event to save the players settings into the database releated to 
-- the players license that gets made on join with `playerSpawn:Pede` 
RegisterNetEvent("savePlayerSettings")
AddEventHandler("savePlayerSettings", function(number) -- burde være imellem 0 - 1
    MySQL.Sync.execute("UPDATE settings_district_pede SET enabled=@number WHERE pedeid=@pedeid",
	{
        ['@pedeid'] = GetPlayerCFXID(source),
		['@number'] = number
	})
end)

--[[ 
    Event to fetch/get the players settings from the
    database and add the settings to the Ox_lib
    and it also is used for checking if player wants to have
    notifications when he/she enters the districts
--]]
RegisterServerEvent("fetchPlayerSettings")
AddEventHandler("fetchPlayerSettings", function()
    local source = source
    MySQL.Async.fetchAll('SELECT enabled FROM settings_district_pede WHERE pedeid = @pedeid', {
        ['@pedeid'] = GetPlayerCFXID(source)
    },
    function(result)
        TriggerClientEvent("ReturnToClient", source, result[1].enabled)
    end)
end)



