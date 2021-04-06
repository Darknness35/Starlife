ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

RegisterServerEvent('esx_pizza:payyyzenayyyzenayyyzenayyyzenayyyzenayyyzenayyyzenay')
AddEventHandler('esx_pizza:payyyzenayyyzenayyyzenayyyzenayyyzenayyyzenayyyzenay', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(tonumber(amount))
end)
