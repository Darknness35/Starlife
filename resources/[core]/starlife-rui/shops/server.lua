ESX = nil

TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

RegisterServerEvent('ayzn-shops:buy')
AddEventHandler('ayzn-shops:buy', function(price, item,quantity)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price*quantity then
		xPlayer.removeMoney(price*quantity)
    	xPlayer.addInventoryItem(item, quantity)
    end
end)

RegisterServerEvent('ayzn:buyweapon')
AddEventHandler('ayzn:buyweapon', function(price, weapon, label, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.hasWeapon(weapon) then
		ESX.ShowNotification('Vous avez déjà cette arme sur vous !')
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
	    	xPlayer.addWeapon(weapon, 42)
	    end
	end
end)

RegisterServerEvent('ayzn:setjob')
AddEventHandler('ayzn:setjob', function(jobb)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.setJob(jobb, 0)

end)


RegisterServerEvent('ayzn:addlicense')
AddEventHandler('ayzn:addlicense', function(price, license)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		TriggerEvent('esx_license:addLicense', _source, license)
    end
end)

RegisterServerEvent('ayzn:buycar')
AddEventHandler('ayzn:buycar', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
    end
end)


RegisterServerEvent('ayzn:pay')
AddEventHandler('ayzn:pay', function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(money)
end)