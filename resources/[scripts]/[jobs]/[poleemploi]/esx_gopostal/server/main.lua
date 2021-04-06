ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

RegisterServerEvent('esx_goayyyzenpostaljob:pay')
AddEventHandler('esx_goayyyzenpostaljob:pay', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(tonumber(amount))
end)
