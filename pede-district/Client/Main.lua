--[[

Todo: Gøre så at spilleren selv kan vælge hvilket notify system han/hun vil bruge!

]]--

function Gta5Notify(message) 
  AddTextEntry("CH_ALERT", message);
  BeginTextCommandDisplayHelp("CH_ALERT");
  EndTextCommandDisplayHelp(0, false, false, -60);
end

function OxNotify(NotifyTitle, Text)
  lib.notify({
    title = NotifyTitle,
    description =  Text,
    type = 'inform'
  })
end