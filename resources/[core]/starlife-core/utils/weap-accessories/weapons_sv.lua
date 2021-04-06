
ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

------------------------------------------------
--================= JUMELLES =================--
------------------------------------------------
ESX.RegisterUsableItem('jumelles', function(source) -- Consider the item as usable
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('jumelles:Active', source) --Trigger the event when the player is using the item
end)

------------------------------------------------
--================= CHARGEURS ================--
------------------------------------------------
RegisterServerEvent('esx_weashop:remove')
AddEventHandler('esx_weashop:remove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('esx_weashop:clip', source)
end)
------------------------------------------------
--================ SILENCIEUX ================--
------------------------------------------------
ESX.RegisterUsableItem('silencieux', function( source )
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('eden_accesories:use', source, 'suppressor')
	xPlayer.removeInventoryItem('silencieux', 1)
end)
------------------------------------------------
--================== AUTRES ==================--
------------------------------------------------
ESX.RegisterUsableItem('flashlight', function( source )
    TriggerClientEvent('eden_accesories:use', source, 'flashlight')
end)
 
ESX.RegisterUsableItem('grip', function( source )
    TriggerClientEvent('eden_accesories:use', source, 'grip')
end)
 
ESX.RegisterUsableItem('yusuf', function( source )
    TriggerClientEvent('eden_accesories:use', source, 'skin')
end)
