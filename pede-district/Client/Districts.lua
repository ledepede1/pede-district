--[[

Functions to send notifications to the
player when he/she enters the zone

]]--

if Config.Framework == "QBCORE" then
  QBCore = exports['qb-core']:GetCoreObject()
  
  RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
  AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
      Citizen.SetTimeout(1000, function()
       PlayerJob = QBCore.Functions.GetPlayerData().job
       LoggedIn = true
       TriggerServerEvent("playerSpawn:Pede")
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
        TriggerServerEvent("playerSpawn:Pede")
    end)
    
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
      end)
    end
  end

function QBZone(zone, isPointInside)
  if IsPedInAnyVehicle(PlayerPedId(), false) then
  zone.name = zone.name
  TriggerServerEvent("fetchPlayerSettings")
  Citizen.Wait(150)
  if IsEnabled == false then return end
  QBCore.Functions.GetPlayerData(function(PlayerData)
    Citizen.Wait(0)
    if PlayerData.job.name == Config.PoliceJobName then
          if Config.NotificationType == "ox" then
          if isPointInside then
            OxNotify(Config.NotifyTitle, Config.TextJoin.. zone.name ..Config.Text2Join)
          else
            OxNotify(Config.NotifyTitle, Config.TextLeave.. zone.name ..Config.Text2Leave)
        end 
      else if Config.NotificationType == "gta5" then
        if isPointInside then
        Gta5Notify(Config.TextJoin.. zone.name ..Config.Text2Join)
        else
          Gta5Notify(Config.TextLeave.. zone.name ..Config.Text2Leave)
              end
            end
          end
        end
    end)
  end
end

function ESXZone(zone, isPointInside)
if IsPedInAnyVehicle(PlayerPedId(), false) then
  zone.name = zone.name
  TriggerServerEvent("fetchPlayerSettings")
  Citizen.Wait(150)
  if IsEnabled == false then return end
  Citizen.Wait(150)
      Citizen.Wait(0)
      if ESX.PlayerData.job.name == Config.PoliceJobName then
          if isPointInside then
            OxNotify(Config.NotifyTitle, Config.TextJoin.. zone.name ..Config.Text2Join)
          else
            OxNotify(Config.NotifyTitle, Config.TextLeave.. zone.name ..Config.Text2Leave)
          end
              else if Config.NotificationType == "gta5" then
                if isPointInside then
                Gta5Notify(Config.TextJoin.. zone.name ..Config.Text2Join)
                else
                  Gta5Notify(Config.TextLeave.. zone.name ..Config.Text2Leave)
                  end
                end
              end
            end
          end


