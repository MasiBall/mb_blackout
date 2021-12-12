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
local animdict = 'animdictinnimi' --animaation dictionary
local anim = 'animinnimi' --animaation nimi
RequestAnimDict(animdict) -- requestaa animaatio
while not HasAnimDictLoaded(animdict) do --varmista että animaatio on loadattu
    Citizen.Wait(0)
end
TaskPlayAnim(playerPed, animdict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
Citizen.wait(Config.HackingTime)
ClearPedTasksImmediatly(playerPed)
end)

function BlackoutOn()
    if Config.Soundeffect then
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
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
        PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
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
