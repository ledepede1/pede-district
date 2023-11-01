IsDispatchEnabled = nil
IsOxEnabled = nil

-- Framework shit
if Config.Framework == "QBCORE" then
    QBCore = exports['qb-core']:GetCoreObject()
    
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        Citizen.SetTimeout(1000, function()
         PlayerJob = QBCore.Functions.GetPlayerData().job
         LoggedIn = true
        end)
    end)
    
    RegisterNetEvent('QBCore:Client:OnPlayerUnload')
    AddEventHandler('QBCore:Client:OnPlayerUnload', function()
        LoggedIn = false
    end)
    
    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerJob = JobInfo
      end)
    
    
    -- ESX
    else if Config.Framework == "ESX" then
      RegisterNetEvent('esx:playerLoaded')
      AddEventHandler('esx:playerLoaded', function(xPlayer)
          ESX.PlayerData = xPlayer
      end)
      
      RegisterNetEvent('esx:setJob')
      AddEventHandler('esx:setJob', function(job)
          ESX.PlayerData.job = job
        end)
      end
    end

-- Changes the global variable to wether the client wants notifys or not
RegisterNetEvent("ReturnToClient")
AddEventHandler("ReturnToClient", function(val1, val2)
        if val1 == 1 then
            IsDispatchEnabled = true
            else
            IsDispatchEnabled = false
        end
            if val2 == 1 then
            IsOxEnabled = true
            else
            IsOxEnabled = false
        end
    Wait(10)
end)

-- Creating the settings command
RegisterCommand(Config.CommandName, function()
    if Config.Framework == "QBCORE" then
        QBCore.Functions.GetPlayerData(function(PlayerData)
          Citizen.Wait(0)
          if PlayerData.job.name == Config.PoliceJobName then
            TriggerServerEvent("fetchPlayerSettings")
            OpenSettingsMenu()
          end
        end)
    else if Config.Framework == "ESX" then
        Citizen.Wait(0)
        if ESX.PlayerData.job.name == Config.PoliceJobName then
            TriggerServerEvent("fetchPlayerSettings")
            OpenSettingsMenu()
            end
        end
    end
end, false)

-- Open settings menu func.
function OpenSettingsMenu()
    while IsDispatchEnabled == nil and IsOxEnabled == nil do
        Citizen.Wait(10) -- Wait for users data to be fully fetched
    end

    local input = lib.inputDialog(Config.MenuButtonDialogTitle , {
        {type = 'checkbox', label = Config.MenuButtonDialogLabel, checked = IsDispatchEnabled},
        {type = 'checkbox', label = Config.OxEnabledLabel, checked = IsOxEnabled},
    })
    
    if not input then return end
    TriggerServerEvent("savePlayerSettings", input[1], input[2])
    IsDispatchEnabled = nil
    IsOxEnabled = nil
end
