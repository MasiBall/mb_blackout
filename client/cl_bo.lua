ESX = ESX
local blackoutState = false

if Config.UseOldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj)
        ESX = obj
    end)
end

function AlertSound()
    PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
end

RegisterNetEvent('mb_blackout:triggerblackout')
AddEventHandler('mb_blackout:triggerblackout', function()
    BlackoutOn()
    Citizen.Wait(Config.BlackoutDuration *1000)
    BlackoutOff()
end)

function BlackoutOn()
    SetArtificialLightsState(true)
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(false)
    end
    ESX.ShowAdvancedNotification('HACKED', '', 'Time to fear the greatness of Masi', Config.NotifyBlackoutON, 5, false)
end

function BlackoutOff()
    SetArtificialLightsState(false)
    if Config.ShowVehicleLights then
        SetArtificialLightsStateAffectsVehicles(true)
    end
    ESX.ShowAdvancedNotification('GOVERNMENT', '', 'Power management system has been restored', Config.NotifyBlackoutOFF, 5, false)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        BlackoutOff()
    end
end)