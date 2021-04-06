local PlayerData = {}
local Factions = {}

ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('esx_faction:getOtherPlayerData', function(source, cb, target)

    if Config.EnableESXIdentity then

        local xPlayer = ESX.GetPlayerFromId(target)

        local identifier = GetPlayerIdentifiers(target)[1]

        local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
            ['@identifier'] = identifier
        })

        local user = result[1]
        local firstname = user['firstname']
        local lastname = user['lastname']
        local sex = user['sex']
        local dob = user['dateofbirth']
        local height = user['height'] .. " Inches"

        local data = {
            name = GetPlayerName(target),
            job = xPlayer.job,
            inventory = xPlayer.inventory,
            accounts = xPlayer.accounts,
            weapons = xPlayer.loadout,
            firstname = firstname,
            lastname = lastname,
            sex = sex,
            dob = dob,
            height = height
        }

    else

        local xPlayer = ESX.GetPlayerFromId(target)

        local data = {
            name = GetPlayerName(target),
            job = xPlayer.job,
            inventory = xPlayer.inventory,
            accounts = xPlayer.accounts,
            weapons = xPlayer.loadout
        }

        cb(data)

    end

end)

ESX.RegisterServerCallback('esx_faction:getPlayerInventory2', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = xPlayer.getAccount('black_money').money

    cb({
        blackMoney = blackMoney
    })
end)

--Gestion Menu
RegisterServerEvent('esx_faction:giveWeapon')
AddEventHandler('esx_faction:giveWeapon', function(weapon, ammo)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon(weapon, ammo)
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

ESX.RegisterServerCallback('esx_faction:getPlayerInventory', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local items = xPlayer.inventory

    cb({
        items = items
    })
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

--Vagos
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'vagos', 'Vagos', 'society_vagos', 'society_vagos', 'society_vagos', {type = 'private'})

ESX.RegisterServerCallback('esx_vagos:getStockItemsVagos', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_vagos:getStockItemsVagos')
AddEventHandler('esx_vagos:getStockItemsVagos', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_vagos:putStockItemsVagos', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_vagos:putStockItemsVagos')
AddEventHandler('esx_vagos:putStockItemsVagos', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vagos', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes Vagos
ESX.RegisterServerCallback('esx_vagos:getVagosWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_vagos', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_vagos:addVagosWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_vagos', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_vagos:removeVagosWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_vagos', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)
--[[ 
ESX.RegisterServerCallback('esx_vagos:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vagos_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_vagos:getBlackMoney')
AddEventHandler('esx_vagos:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vagos_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_vagos:getPutMoney')
AddEventHandler('esx_vagos:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vagos_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]

--Ballas
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'ballas', 'Ballas', 'society_ballas', 'society_ballas', 'society_ballas', {type = 'private'})

ESX.RegisterServerCallback('esx_ballas:getStockItemsBallas', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ballas', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_ballas:getStockItemsBallas')
AddEventHandler('esx_ballas:getStockItemsBallas', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ballas', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_ballas:putStockItemsBallas', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ballas', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_ballas:putStockItemsBallas')
AddEventHandler('esx_ballas:putStockItemsBallas', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ballas', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes Ballas
ESX.RegisterServerCallback('esx_ballas:getBallasWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_ballas', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_ballas:addBallasWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_ballas', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_ballas:removeBallasWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_ballas', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

--[[ ESX.RegisterServerCallback('esx_ballas:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ballas_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_ballas:getBlackMoney')
AddEventHandler('esx_ballas:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ballas_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_ballas:getPutMoney')
AddEventHandler('esx_ballas:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ballas_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]

--[[ --SantaCruz
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'santacruz', 'SantaCruz', 'society_santacruz', 'society_santacruz', 'society_santacruz', {type = 'private'})

ESX.RegisterServerCallback('esx_santacruz:getStockItemsSantaCruz', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_santacruz', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_santacruz:getStockItemsSantaCruz')
AddEventHandler('esx_santacruz:getStockItemsSantaCruz', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_santacruz', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_santacruz:putStockItemsSantaCruz', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_santacruz', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_santacruz:putStockItemsSantaCruz')
AddEventHandler('esx_santacruz:putStockItemsSantaCruz', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_santacruz', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes santacruz
ESX.RegisterServerCallback('esx_santacruz:getSantaCruzWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_santacruz', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_santacruz:addSantaCruzWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_santacruz', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_santacruz:removeSantaCruzWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_santacruz', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_santacruz:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_santacruz_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_santacruz:getBlackMoney')
AddEventHandler('esx_santacruz:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_santacruz_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_santacruz:getPutMoney')
AddEventHandler('esx_santacruz:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_santacruz_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]

--WeaponDealer
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'weapondealer', 'WeaponDealer', 'society_weapondealer', 'society_weapondealer', 'society_weapondealer', { type = 'private' })

ESX.RegisterServerCallback('esx_weapondealer:getStockItemsweapondealer', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weapondealer', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_weapondealer:getStockItemsweapondealer')
AddEventHandler('esx_weapondealer:getStockItemsweapondealer', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weapondealer', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_weapondealer:putStockItemsweapondealer', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weapondealer', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_weapondealer:putStockItemsweapondealer')
AddEventHandler('esx_weapondealer:putStockItemsweapondealer', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_weapondealer', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes weapondealer
ESX.RegisterServerCallback('esx_weapondealer:getweapondealerWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_weapondealer', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_weapondealer:addweapondealerWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_weapondealer', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_weapondealer:removeweapondealerWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_weapondealer', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_weapondealer:getArmoryWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapondealer', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_weapondealer:removeArmoryWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapondealer', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

local AuthorizedWeapons = {
    boss = {
        {weapon = 'WEAPON_MICROSMG', price = 130000},
        {weapon = 'WEAPON_MINISMG', price = 140000},
        {weapon = 'WEAPON_SMG', price = 220000},
        {weapon = 'WEAPON_COMPACTRIFLE', price = 140000},
        {weapon = 'WEAPON_ASSAULTRIFLE', price = 250000},
        {weapon = 'WEAPON_PISTOL50', price = 45000},
        {weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 115000},
        {weapon = 'WEAPON_BULLPUPSHOTGUN', price = 180000},
        {weapon = 'WEAPON_SNIPERRIFLE', price = 300000},
        {weapon = 'WEAPON_SWITCHBLADE', price = 25000},
        {weapon = 'WEAPON_MOLOTOV', price = 230000}
    }
}

ESX.RegisterServerCallback('esx_weapondealer:buyWeapon', function(source, cb, weaponName, type, componentNum)
    local xPlayer = ESX.GetPlayerFromId(source)
    local authorizedWeapons, selectedWeapon = AuthorizedWeapons['boss']

    for k, v in ipairs(authorizedWeapons) do
        if v.weapon == weaponName then
            selectedWeapon = v
            break
        end
    end

    if not selectedWeapon then
        print(('esx_weapondealer: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
        cb(false)
    else
        --Weapon
        if type == 1 then
            if xPlayer.getMoney() >= selectedWeapon.price then
                xPlayer.removeMoney(selectedWeapon.price)
                xPlayer.addWeapon(weaponName, 450)

                cb(true)
            else
                cb(false)
            end

            --Weapon Component
        elseif type == 2 then
            local price = selectedWeapon.components[componentNum]
            local weaponNum, weapon = ESX.GetWeapon(weaponName)

            local component = weapon.components[componentNum]

            if component then
                if xPlayer.getMoney() >= price then
                    xPlayer.removeMoney(price)
                    xPlayer.addWeaponComponent(weaponName, component.name)

                    cb(true)
                else
                    cb(false)
                end
            else
                print(('esx_weapondealer: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
                cb(false)
            end
        end
    end
end)

--[[ ESX.RegisterServerCallback('esx_weapondealer:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_weapondealer_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_weapondealer:getBlackMoney')
AddEventHandler('esx_weapondealer:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_weapondealer_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_weapondealer:getPutMoney')
AddEventHandler('esx_weapondealer:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_weapondealer_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]

--Mafia
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'mafia', 'Mafia', 'society_mafia', 'society_mafia', 'society_mafia', {type = 'private'})

ESX.RegisterServerCallback('esx_mafia:getStockItemsMafia', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_mafia:getStockItemsMafia')
AddEventHandler('esx_mafia:getStockItemsMafia', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_mafia:putStockItemsMafia', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_mafia:putStockItemsMafia')
AddEventHandler('esx_mafia:putStockItemsMafia', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes Mafia
ESX.RegisterServerCallback('esx_mafia:getMafiaWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_mafia', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_mafia:addMafiaWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_mafia', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_mafia:removeMafiaWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_mafia', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)


--Bkc
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'bkc', 'Bkc', 'society_bkc', 'society_bkc', 'society_bkc', {type = 'private'})

ESX.RegisterServerCallback('esx_bkc:getStockItemsBkc', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bkc', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_bkc:getStockItemsBkc')
AddEventHandler('esx_bkc:getStockItemsBkc', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bkc', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_bkc:putStockItemsBkc', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bkc', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_bkc:putStockItemsBkc')
AddEventHandler('esx_bkc:putStockItemsBkc', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bkc', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes Bkc
ESX.RegisterServerCallback('esx_bkc:getBkcWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_bkc', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_bkc:addBkcWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_bkc', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_bkc:removeBkcWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_bkc', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

--Madrazo
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'madrazo', 'Madrazo', 'society_madrazo', 'society_madrazo', 'society_madrazo', {type = 'private'})

ESX.RegisterServerCallback('esx_madrazo:getStockItemsMadrazo', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_madrazo', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_madrazo:getStockItemsMadrazo')
AddEventHandler('esx_madrazo:getStockItemsMadrazo', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_madrazo', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_madrazo:putStockItemsMadrazo', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_madrazo', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_madrazo:putStockItemsMadrazo')
AddEventHandler('esx_madrazo:putStockItemsMadrazo', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_madrazo', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes Madrazo
ESX.RegisterServerCallback('esx_madrazo:getMadrazoWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_madrazo', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_madrazo:addMadrazoWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_madrazo', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_madrazo:removeMadrazoWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_madrazo', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)


--Locura
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'Locura', 'Locura', 'society_Locura', 'society_Locura', 'society_Locura', {type = 'private'})

ESX.RegisterServerCallback('esx_Locura:getStockItemsLocura', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Locura', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_Locura:getStockItemsLocura')
AddEventHandler('esx_Locura:getStockItemsLocura', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Locura', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_Locura:putStockItemsLocura', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Locura', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_Locura:putStockItemsLocura')
AddEventHandler('esx_Locura:putStockItemsLocura', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_Locura', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes Locura
ESX.RegisterServerCallback('esx_Locura:getLocuraWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_Locura', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_Locura:addLocuraWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_Locura', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_Locura:removeLocuraWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_Locura', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)


--locura
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'locura', 'Locura', 'society_locura', 'society_locura', 'society_locura', {type = 'private'})

ESX.RegisterServerCallback('esx_locura:getStockItemsLocura', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_locura', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_locura:getStockItemsLocura')
AddEventHandler('esx_locura:getStockItemsLocura', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_locura', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_locura:putStockItemsLocura', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_locura', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_locura:putStockItemsLocura')
AddEventHandler('esx_locura:putStockItemsLocura', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_locura', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes locura
ESX.RegisterServerCallback('esx_locura:getLocuraWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_locura', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_locura:addLocuraWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_locura', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_locura:removeLocuraWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_locura', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

--Families
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'families', 'Families', 'society_families', 'society_families', 'society_families', {type = 'private'})

ESX.RegisterServerCallback('esx_families:getStockItemsFamilies', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_families', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_families:getStockItemsFamilies')
AddEventHandler('esx_families:getStockItemsFamilies', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_families', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_families:putStockItemsFamilies', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_families', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_families:putStockItemsFamilies')
AddEventHandler('esx_families:putStockItemsFamilies', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_families', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes Families
ESX.RegisterServerCallback('esx_families:getFamiliesWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_families', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_families:addFamiliesWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_families', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_families:removeFamiliesWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_families', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

--[[ ESX.RegisterServerCallback('esx_families:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_families_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_families:getBlackMoney')
AddEventHandler('esx_families:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_families_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_families:getPutMoney')
AddEventHandler('esx_families:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_families_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]

--[[ --sinaloa
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'sinaloa', 'Sinaloa', 'society_sinaloa', 'society_sinaloa', 'society_sinaloa', {type = 'private'})

ESX.RegisterServerCallback('esx_sinaloa:getStockItemsSinaloa', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sinaloa', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_sinaloa:getStockItemsSinaloa')
AddEventHandler('esx_sinaloa:getStockItemsSinaloa', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sinaloa', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_sinaloa:putStockItemsSinaloa', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sinaloa', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_sinaloa:putStockItemsSinaloa')
AddEventHandler('esx_sinaloa:putStockItemsSinaloa', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sinaloa', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

-- Stock Armes sinaloa
ESX.RegisterServerCallback('esx_sinaloa:getSinaloaWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_sinaloa', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_sinaloa:addSinaloaWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_sinaloa', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_sinaloa:removeSinaloaWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_sinaloa', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_sinaloa:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_sinaloa_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_sinaloa:getBlackMoney')
AddEventHandler('esx_sinaloa:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_sinaloa_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_sinaloa:getPutMoney')
AddEventHandler('esx_sinaloa:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_sinaloa_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]

--Camorra
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'camorra', 'Camorra', 'society_camorra', 'society_camorra', 'society_camorra', {type = 'private'})

ESX.RegisterServerCallback('esx_camorra:getStockItemsCamorra', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_camorra', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_camorra:getStockItemsCamorra')
AddEventHandler('esx_camorra:getStockItemsCamorra', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_camorra', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_camorra:putStockItemsCamorra', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_camorra', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_camorra:putStockItemsCamorra')
AddEventHandler('esx_camorra:putStockItemsCamorra', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_camorra', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes Camorra
ESX.RegisterServerCallback('esx_camorra:getCamorraWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_camorra', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_camorra:addCamorraWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_camorra', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_camorra:removeCamorraWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_camorra', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)


--Yakuza
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'yakuza', 'Yakuza', 'society_yakuza', 'society_yakuza', 'society_yakuza', {type = 'private'})

ESX.RegisterServerCallback('esx_yakuza:getStockItemsYakuza', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_yakuza:getStockItemsYakuza')
AddEventHandler('esx_yakuza:getStockItemsYakuza', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_yakuza:putStockItemsYakuza', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_yakuza:putStockItemsYakuza')
AddEventHandler('esx_yakuza:putStockItemsYakuza', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_yakuza', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes Yakuza
ESX.RegisterServerCallback('esx_yakuza:getYakuzaWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_yakuza', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_yakuza:addYakuzaWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_yakuza', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_yakuza:removeYakuzaWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_yakuza', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

--Bratva
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'bratva', 'Bratva', 'society_bratva', 'society_bratva', 'society_bratva', {type = 'private'})

ESX.RegisterServerCallback('esx_bratva:getStockItemsBratva', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bratva', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_bratva:getStockItemsBratva')
AddEventHandler('esx_bratva:getStockItemsBratva', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bratva', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_bratva:putStockItemsBratva', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bratva', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_bratva:putStockItemsBratva')
AddEventHandler('esx_bratva:putStockItemsBratva', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bratva', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes Bratva
ESX.RegisterServerCallback('esx_bratva:getBratvaWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_bratva', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_bratva:addBratvaWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_bratva', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_bratva:removeBratvaWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_bratva', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)


--[[ --OSM
TriggerEvent('esx_societyfaction:registerSocietyFaction', 'osm', 'OSM', 'society_osm', 'society_osm', 'society_osm', {type = 'private'})

ESX.RegisterServerCallback('esx_osm:getStockItemsOSM', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_osm', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_osm:getStockItemsOSM')
AddEventHandler('esx_osm:getStockItemsOSM', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_osm', function(inventory)
        local item = inventory.getItem(itemName)
        local sourceItem = xPlayer.getInventoryItem(itemName)

        --is there enough in the society?
        if count > 0 and item.count >= count then

            --can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous n\'avez pas assez de places')
            else
                inventory.removeItem(itemName, count)
                xPlayer.addInventoryItem(itemName, count)
                TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ', count, item.label)
            end
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end
    end)
end)

ESX.RegisterServerCallback('esx_osm:putStockItemsOSM', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_osm', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('esx_osm:putStockItemsOSM')
AddEventHandler('esx_osm:putStockItemsOSM', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_osm', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantité invalide')
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ', count, item.label)
    end)
end)

--Stock Armes OSM
ESX.RegisterServerCallback('esx_osm:getOSMweapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_osm', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_osm:addOSMWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_osm', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_osm:removeOSMWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_weapons_osm', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_osm:getBlackMoney', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = 0
  
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_osm_black', function(account)
      blackMoney = account.money
    end)
  
    cb({
      blackMoney = blackMoney
    })
  
  end)

RegisterServerEvent('esx_osm:getBlackMoney')
AddEventHandler('esx_osm:getBlackMoney', function(type, item, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if type == 'item_account' then
    local playerAccountMoney = xPlayer.getAccount(item).money

    if playerAccountMoney >= count then
      xPlayer.removeAccountMoney(item, count)
      TriggerEvent('esx_addonaccount:getSharedAccount', 'society_osm_black', function(account)
        account.addMoney(count)
      end)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
    end
  end

end)

RegisterServerEvent('esx_osm:getPutMoney')
AddEventHandler('esx_osm:getPutMoney', function(type, item, count)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_osm_black', function(account)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local roomAccountMoney = account.money

        if roomAccountMoney >= count then
        account.removeMoney(count)
        xPlayer.addAccountMoney(item, count)
        else
        TriggerClientEvent('esx:showNotification', _source, 'Montant invalide')
        end

    end)
end) ]]