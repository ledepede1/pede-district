fx_version 'adamant'

game 'gta5'

author 'ledepede1'
description 'Pede District'

--[[
Pede Distrcit needs following dependencies:
ox_lib
polyzone
oxmysql
]]--

version '1.0'

lua54 'yes'

shared_scripts {
  '@ox_lib/init.lua',
  'Configs/Config.lua',
}

-- Comment out ESX out if using QBCORE
shared_script {'@es_extended/imports.lua'}


client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/ComboZone.lua',
  'Client/Zones.lua',
  'Client/Main.lua',
  'Client/Settings.lua',
  'Client/Districts.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'Server/Server.lua',
}