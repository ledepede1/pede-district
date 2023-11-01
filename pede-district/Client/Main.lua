-- Really empty main.lua haha

function Gta5Notify(message) 
  AddTextEntry("CH_ALERT", message);
  BeginTextCommandDisplayHelp("CH_ALERT");
  EndTextCommandDisplayHelp(0, false, true, -60);
end

function OxNotify(NotifyTitle, Text, type)
  lib.notify({
    title = NotifyTitle,
    description =  Text,
    type = type
  })
end

