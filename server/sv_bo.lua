-- Configuration
local blackoutCommand = 'hackbo'
local blackoutItem = 'laptop'
local discordwebhook = 'INSERT_WEBHOOK_HERE'

if Config.UseOldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if Config.UseCommand then
    RegisterCommand(blackoutCommand, function(source, args, rawCommand)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        local itemCount = xPlayer.getInventoryItem(blackoutItem).count
        if itemCount >= 1 then
            xPlayer.removeInventoryItem(blackoutItem, 1)
            TriggerClientEvent('mb_blackout:triggeranim')
            Citizen.Wait(Config.HackingTime)
            TriggerEvent('mb_blackout:server:triggerblackout', source)
        end
    end, false)
end

if Config.UsableItem then
    ESX.RegisterUsableItem(blackoutItem, function(source)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem(blackoutItem, 1)
        TriggerClientEvent('mb_blackout:triggeranim')
        Citizen.Wait(Config.HackingTime)
        TriggerEvent('mb_blackout:server:triggerblackout', source)
    end)
end

RegisterServerEvent('mb_blackout:server:triggerblackout')
AddEventHandler('mb_blackout:server:triggerblackout', function(source)
	local source = source
        if Config.DiscordLog then
            sendToDiscordLogsEmbed(3158326, '`💀` | Blackout',' Player: `' ..GetPlayerName(source).. '` - `'..GetPlayerIdentifier(source, 0)..'` triggered blackout')
        end
		TriggerClientEvent('mb_blackout:triggerblackout', -1)
	end
end)

function sendToDiscordLogsEmbed(color, name, message, footer)
    local footer = 'Made By MasiBall - '..os.date("%d/%m/%Y - %X")
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**"..name.."**",
              ["description"] = message,
              ["footer"] = {
              ["text"] = footer,
              },
          }
      }
  
    PerformHttpRequest(discordwebhook, function(err, text, headers) end, 'POST', json.encode({username = 'Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
