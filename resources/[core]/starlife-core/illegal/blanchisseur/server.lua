local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

local function WhiteningMoney(source,percent)
	local source = source
		SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')
			local _percent		= ConfigBlanchiment.Percentage
			
			if blackMoney.money < ConfigBlanchiment.Slice then
				TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Vous n\'avez pas assez d\'argent à blanchir, minimum : $' .. ConfigBlanchiment.Slice)
			else
				local bonus = math.random(ConfigBlanchiment.Bonus.min, ConfigBlanchiment.Bonus.max)
				local washedMoney = math.floor(ConfigBlanchiment.Slice / 100 * (_percent + bonus))

				xPlayer.removeAccountMoney('black_money', ConfigBlanchiment.Slice)
				xPlayer.addMoney(washedMoney)
				WhiteningMoney(source,_percent)
				
				TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Vous avez reçu : ~r~$ ' .. washedMoney .. ' d\'argent propre')
			end
		end
	end)
end

RegisterServerEvent('esx_blanchisseur:washMoney')
AddEventHandler('esx_blanchisseur:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')
	local _percent		= ConfigBlanchiment.Percentage

	if amount > 0 and account.money >= amount then
		
		local bonus = math.random(ConfigBlanchiment.Bonus.min, ConfigBlanchiment.Bonus.max)
		local washedMoney = math.floor(amount / 100 * (_percent + bonus))	

		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)
		
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Vous avez reçu : ~r~$ ' .. washedMoney .. ' d\'argent propre')
		
	else
		TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Montant invalide')
	end

end)

RegisterServerEvent('esx_blanchisayyyzenseur:startWhitening')
AddEventHandler('esx_blanchisayyyzenseur:startWhitening', function(percent)
	PlayersWashing[source] = true
	TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Blanchiement en cours ...')
	WhiteningMoney(source,percent)
end)

RegisterServerEvent('esx_blanchisseur:Nothere')
AddEventHandler('esx_blanchisseur:Nothere', function()
	PlayersWashing[source] = false
	TriggerClientEvent("esx_blanchisseur:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Reviens plus tard ...')
end)


RegisterServerEvent('esx_blanchisseur:stopWhitening')
AddEventHandler('esx_blanchisseur:stopWhitening', function()
	PlayersWashing[source] = false
end)
