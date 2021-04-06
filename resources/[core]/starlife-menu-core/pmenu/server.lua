ESX = nil

TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

RegisterServerEvent('RiZie_ShOps:buy')
AddEventHandler('RiZie_ShOps:buy', function(price, item, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(item, 1)
    	--ESX.ShowNotification('Vous avez acheté 1 ' .. label .. " pour ~g~" .. price .. "$ !")

    --else
    	--ESX.ShowNotification('Vous n\'avez pas assez d\'argent sur vous !')
    end
end)

RegisterServerEvent('RiZie_Ammu:buyweapon')
AddEventHandler('RiZie_Ammu:buyweapon', function(price, weapon, label, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.hasWeapon(weapon) then
		ESX.ShowNotification('Vous avez déjà cette arme sur vous !')
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
	    	xPlayer.addWeapon(weapon, 42) -- 42 = le nombre de balles donnés
	    	--ESX.ShowNotification('Vous avez acheté 1 ' .. label .. " pour ~g~" .. price .. "$ !")
	    	xPlayer.PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
	    --else
	    	--ESX.ShowNotification('Vous n\'avez pas assez d\'argent sur vous !')
	    end
	end
end)

RegisterServerEvent('ayzn_pe:setjob')
AddEventHandler('ayzn_pe:setjob', function(jobb)

	local _source = source

	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.setJob(jobb, 0)	
	--ESX.ShowNotification("Vous venez d'être embauché en tant que "..jobb)

end)


RegisterServerEvent('ayzn_autoecole:addlicense')
AddEventHandler('ayzn_autoecole:addlicense', function(price, license)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		TriggerEvent('esx_license:addLicense', _source, license)
-- A faire : si il possed deja la license bah que ca dit qu'il la déja 
    --else
    	--ESX.ShowNotification('Vous n\'avez pas assez d\'argent sur vous !')
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
