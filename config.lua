Config = {}

-- General configuration
Config.UseOldESX = true
Config.UsevSync = false
Config.BlackoutDuration = 60 -- How long will the blackout last (In seconds)
Config.HackingTime = 15 -- How long will hacking take (In seconds) 
Config.SendNotification = true
Config.Soundeffect = true
Config.ShowVehicleLights = true
Config.DiscordLog = true

-- How blackout can be triggered
Config.UsableItem = true -- Item can be changed in sv_bo.lua
Config.UseCommand = true -- Command can be changed in sv_bo.lua

-- Blackout notify
Config.NotifyImageBlackoutON = 'CHAR_LESTER_DEATHWISH'
Config.NotifyImageBlackoutOFF = 'CHAR_CALL911'
Config.BlackoutOnNotifyTitle = 'HACKED'
Config.BlackoutOnNotifyText = '~r~Time to fear the greatness of Masi~w~'
Config.BlackoutOffNotifyTitle = 'GOVERNMENT'
Config.BlackoutOffNotifyText = '~g~Power has been restored~w~'