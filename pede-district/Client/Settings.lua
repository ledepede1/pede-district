--[[

Todo: Gøre så at spilleren selv kan vælge hvilket notify system han/hun vil bruge!

]]--


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


IsEnabled = false

-- Changes the global variable to wether the client wants notifys or not
RegisterNetEvent("ReturnToClient")
AddEventHandler("ReturnToClient", function(val)
    if val == 1 then
    IsEnabled = true
    else
        IsEnabled = false
    end
end)

RegisterCommand(Config.CommandName, function(source, args, rawCommand)
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


--function GetPlayerSettings(val)
--    Citizen.Wait(10)
--    return val
--end

function OpenSettingsMenu()
    lib.registerContext({
        id = 'district_settings',
        title = Config.MenuTitle,
        options = {
          {
            title = Config.MenuButton,
            description = Config.MenuButtonDescription,
            icon = Config.MenuButtonIcon,
            onSelect = function()
                local input = lib.inputDialog(Config.MenuButtonDialogTitle , {
                {type = 'checkbox', label = Config.MenuButtonDialogLabel, checked = IsEnabled},
                })
                if not input then return end
                if input[1] == true then
                    TriggerServerEvent("savePlayerSettings", 1)
                else if input[1] == false then
                    TriggerServerEvent("savePlayerSettings", 0) 
                    end
                end
            end,
          },
        }
    })
    lib.showContext('district_settings')
end

-- Debug command
--RegisterCommand("testsql", function (source, args, rawCommand)
--    TriggerServerEvent("playerSpawn:Pede")
--end, false)