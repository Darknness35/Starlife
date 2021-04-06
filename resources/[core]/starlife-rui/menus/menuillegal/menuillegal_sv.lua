ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('esx_faction:getOtherPlayerData', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(target)
    local data = {
        name = GetPlayerName(target),
        job = xPlayer.job,
        inventory = xPlayer.inventory,
        accounts = xPlayer.accounts,
        weapons = xPlayer.loadout
    }
    cb(data)

end)

RegisterServerEvent('esx_faction:confiscatePlayerItem')
AddEventHandler('esx_faction:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local label = sourceXPlayer.getInventoryItem(itemName).label

        targetXPlayer.removeInventoryItem(itemName, amount)
        sourceXPlayer.addInventoryItem(itemName, amount)

        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'vous avez confisqué ~y~x' .. amount .. ' ' .. label .. '~s~ à ~b~' .. targetXPlayer.name)
        TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. '~s~ vous a confisqué ~y~x' .. amount .. ' ' .. label)
    end

    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney(itemName, amount)

        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'vous avez confisqué ~y~$' .. amount .. '~s~ vous a confisqué ~y~x' .. targetXPlayer.name)
        TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. '~s~ vous a confisqué ~y~$' .. amount)
    end

    if itemType == 'item_weapon' then
        targetXPlayer.removeWeapon(itemName)
        sourceXPlayer.addWeapon(itemName, amount)

        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'vous avez confisqué ~y~x1 ' .. ESX.GetWeaponLabel(itemName) .. '~s~ à ~b~' .. targetXPlayer.name)
        TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. '~s~ vous a confisqué ~y~x1 ' .. ESX.GetWeaponLabel(itemName))
    end

end)

RegisterServerEvent('esx_faction:handcuff')
AddEventHandler('esx_faction:handcuff', function(target)
  TriggerClientEvent('esx_faction:handcuff', target)
end)

RegisterServerEvent('esx_faction:drag')
AddEventHandler('esx_faction:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_faction:drag', target, _source)
end)


RegisterServerEvent('esx_faction:putInVehicle')
AddEventHandler('esx_faction:putInVehicle', function(target)
  TriggerClientEvent('esx_faction:putInVehicle', target)
end)


RegisterServerEvent('esx_faction:OutVehicle')
AddEventHandler('esx_faction:OutVehicle', function(target)
    TriggerClientEvent('esx_faction:OutVehicle', target)
end)