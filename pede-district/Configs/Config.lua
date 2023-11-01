Config = {}

-- # Vigtigt #
Config.Framework = "ESX" -- QBCORE or ESX (testet på esx-legacy og qbcore)
Config.PoliceJobName = "police"
Config.CommandName = "settings" -- altså feks. /settings

Config.EnablePlayerChoosenNotify = true -- om spilleren selv må vælge hvilket notify system som vil blive vist for ham/hende!

-- # Settings menu #
Config.MenuTitle = "Distrikt Indstillinger"
Config.MenuButtonIcon = "list-ul"
Config.MenuButton = "Toggle Distrikt Notifikationer"
Config.MenuButtonDescription = "Giver mulighed for at slå distrikt notifikationer til/fra"
Config.MenuButtonDialogTitle = "Distrikt Notifikationer"
Config.MenuButtonDialogLabel = "Notifikationer"

Config.OxEnabledLabel = "Ox Notify"

-- # Notifikationer #
Config.NotifyTitle = "Distrikt" -- Ignore if using gta5
Config.EnterType = 'success'
Config.LeaveType = 'error'

-- # Tekst til notifikationer #

Config.TextJoin = "Du har nu bevæget dig ind i det " 
-- og så er der imellem de to zone.name
Config.Text2Join = " distrikt"

Config.TextLeave = "Du har nu bevæget dig ud af det " 
-- og så er der imellem de to zone.name {"Nordlige", "Sydlige" osv osv...}
Config.Text2Leave = " distrikt"

Config.North = {
    Label = "Nordlige"
}
Config.South = {
    Label = "Sydlige"
}
Config.East = {
    Label = "Østlige"
}
Config.West = {
    Label = "Vestlige"
}


