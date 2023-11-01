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
AddEventHandler("savePlayerSettings", function(number1, number2) -- both num1 and num2 should be between 0 - 1
    local enabledInt = nil
    local oxenabledInt = nil

    -- Such a mess but it is what it is
    if number1 == true then
        enabledInt = 1
    else
        enabledInt = 0
    end

    if number2 == true then
        oxenabledInt = 1
    else
        oxenabledInt = 0
    end

    MySQL.Sync.execute("UPDATE settings_district_pede SET enabled=@enabled, ox_notify=@oxenabled WHERE pedeid=@pedeid",
	{
        ['@pedeid'] = GetPlayerCFXID(source),
		['@enabled'] = enabledInt,
        ['@oxenabled'] = oxenabledInt
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
    MySQL.Async.fetchAll('SELECT enabled, ox_notify FROM settings_district_pede WHERE pedeid = @pedeid', {
        ['@pedeid'] = GetPlayerCFXID(source)
    },
    function(result)
            TriggerClientEvent("ReturnToClient", source, result[1].enabled, result[1].ox_notify)
    end)
end)



