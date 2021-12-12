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
    Citizen.Wait(Config.BlackoutDuration *1000)
    BlackoutOff()
end)

RegisterNetEvent('mb_blackout:triggeranim')
AddEventHandler('mb_blackout:triggeranim', function()
    local playerPed = PlayerPedId()
    local pedCoords = GetEntityCoords(playerPed)
    local tabletProp = GetHashKey('prop_cs_tablet')
    local animdict = 'idle_a'
    local anim = 'amb@code_human_in_bus_passenger_idles@female@tablet@idle_a'
    local pedX, pedY, pedZ = table.unpack(pedCoords)
    local prop = CreateObject(tabletProp, pedX, pedY, pedZ + 0.2, true, true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true) -- Thanks to Dullpear_dev since the prop placement is taken from dpEmotes
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, animdict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
    Citizen.wait(Config.HackingTime *1000)
    ClearPedSecondaryTask(ped)
    DeleteObject(prop)
end)

function BlackoutOn()
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "emp_activate", "DLC_CH_HEIST_FINALE_SOUNDS", 1)
        PlaySoundFrontend(-1, "EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 1)
    end
    SetArtificialLightsState(true)
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(false)
    end
    if Config.SendNotification then
        ESX.ShowAdvancedNotification('HACKED', '', 'Time to fear the greatness of Masi', Config.NotifyBlackoutON, 5, false)
    end
end

function BlackoutOff()
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "police_notification", "DLC_AS_VNT_Sounds", 1)
    end
    SetArtificialLightsState(false)
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(true)
    end
    if Config.SendNotification then
        ESX.ShowAdvancedNotification('GOVERNMENT', '', 'Power management system has been restored', Config.NotifyBlackoutOFF, 5, false)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        BlackoutOff()
    end
end)
