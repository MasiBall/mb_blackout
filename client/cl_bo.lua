ESX = ESX

if Config.UseOldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj
    end)
end

RegisterNetEvent('mb_blackout:triggerblackout')
AddEventHandler('mb_blackout:triggerblackout', function()
    BlackoutOn()
    Wait(Config.BlackoutDuration *1000)
    BlackoutOff()
end)

RegisterNetEvent('mb_blackout:triggeranim')
AddEventHandler('mb_blackout:triggeranim', function(source)
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local tabletProp = GetHashKey('prop_cs_tablet')
    local animdict = 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a'
    local anim = 'idle_a'
    local pedX, pedY, pedZ = table.unpack(pedCoords)
    prop = CreateObject(tabletProp, pedX, pedY, pedZ + 0.2, true, true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true) -- Thanks to Dullpear_dev since the prop placement is taken from dpEmotes
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Wait(0)
    end
    TaskPlayAnim(playerPed, animdict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
    Wait(Config.HackingTime *1000)
    ClearPedSecondaryTask(playerPed)
    DeleteObject(prop)
end)

function BlackoutOn()
    if not Config.UsevSync then
        SetArtificialLightsState(true)
    end
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
    end
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(false)
    end
    if Config.SendNotification then
        ESX.ShowAdvancedNotification(Config.BlackoutOnNotifyTitle, '', Config.BlackoutOnNotifyText, Config.NotifyImageBlackoutON, 5, false)
    end
end

function BlackoutOff()
    if not Config.UsevSync then
        SetArtificialLightsState(false)
    end
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "police_notification", "DLC_AS_VNT_Sounds", 1)
    end
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(true)
    end
    if Config.SendNotification then
        ESX.ShowAdvancedNotification(Config.BlackoutOffNotifyTitle, '', Config.BlackoutOffNotifyText, Config.NotifyImageBlackoutOFF, 5, false)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        BlackoutOff()
    end
end)
