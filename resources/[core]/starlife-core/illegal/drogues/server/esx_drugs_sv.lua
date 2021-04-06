ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingCoke    = {}
local PlayersTransformingCoke  = {}
local PlayersSellingCoke       = {}
local PlayersHarvestingMeth    = {}
local PlayersTransformingMeth  = {}
local PlayersSellingMeth       = {}
local PlayersHarvestingWeed    = {}
local PlayersTransformingWeed  = {}
local PlayersSellingWeed       = {}
local PlayersHarvestingOpium   = {}
local PlayersTransformingOpium = {}
local PlayersSellingOpium      = {}

TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(5000, CountCops)

end

CountCops()

--coke
local function HarvestCoke(source)

	if CopsConnected < ConfigDrogues.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsCoke)
		return
	end

	SetTimeout(5000, function()

		if PlayersHarvestingCoke[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local coke = xPlayer.getInventoryItem('coke')

			if coke.limit ~= -1 and coke.count >= coke.limit then
				TriggerClientEvent('esx:showNotification', source, 'vous ne pouvez plus ramasser de Cocaine, votre inventaire est ~r~plein~s~')
			else
				xPlayer.addInventoryItem('coke', 1)
				HarvestCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestayyyzenCoke')
AddEventHandler('esx_drugs:startHarvestayyyzenCoke', function()

	local _source = source

	PlayersHarvestingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Ramassage en cours~s~...')

	HarvestCoke(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvayyyzenestCoke')
AddEventHandler('esx_drugs:stopHarvayyyzenestCoke', function()

	local _source = source

	PlayersHarvestingCoke[_source] = false

end)

local function TransformCoke(source)

	if CopsConnected < ConfigDrogues.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsCoke)
		return
	end

	SetTimeout(10000, function()

		if PlayersTransformingCoke[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local cokeQuantity = xPlayer.getInventoryItem('coke').count
			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, 'vous avez trop de pochons')
			elseif cokeQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez de feuille de coca à ~r~conditionner~s~')
			else
				xPlayer.removeInventoryItem('coke', 5)
				xPlayer.addInventoryItem('coke_pooch', 1)
			
				TransformCoke(source)
			end
		end
	end)
end

RegisterServerEvent('esx_drugs:startTransayyyzenformCoke')
AddEventHandler('esx_drugs:startTransayyyzenformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Conditonnement en cours~s~...')

	TransformCoke(_source)

end)

RegisterServerEvent('esx_drugs:stopTranayyyzensformCoke')
AddEventHandler('esx_drugs:stopTranayyyzensformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = false

end)

local function SellCoke(source)

	if CopsConnected < ConfigDrogues.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsCoke)
		return
	end

	SetTimeout(7500, function()

		if PlayersSellingCoke[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez plus de pochons à ~r~vendre~s~')
			else
				xPlayer.removeInventoryItem('coke_pooch', 1)
				if CopsConnected == 0 then
                    xPlayer.addAccountMoney('black_money', 1000)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de coke~s~')
                elseif CopsConnected == 1 then
                    xPlayer.addAccountMoney('black_money', 1100)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de coke~s~')
                elseif CopsConnected == 2 then
                    xPlayer.addAccountMoney('black_money', 1200)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de coke~s~')
                elseif CopsConnected == 3 then
                    xPlayer.addAccountMoney('black_money', 1300)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de coke~s~')
                elseif CopsConnected == 4 then
                    xPlayer.addAccountMoney('black_money', 1300)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de coke~s~')
                elseif CopsConnected >= 5 then
                    xPlayer.addAccountMoney('black_money', 1400)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de coke~s~')
                end
				
				SellCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellCayyyzenoke')
AddEventHandler('esx_drugs:startSellCayyyzenoke', function()

	local _source = source

	PlayersSellingCoke[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours~s~...')

	SellCoke(_source)

end)

RegisterServerEvent('esx_drugs:stopSellayyyzenCoke')
AddEventHandler('esx_drugs:stopSellayyyzenCoke', function()

	local _source = source

	PlayersSellingCoke[_source] = false

end)

--meth
local function HarvestMeth(source)

	if CopsConnected < ConfigDrogues.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsMeth)
		return
	end
	
	SetTimeout(5000, function()

		if PlayersHarvestingMeth[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local meth = xPlayer.getInventoryItem('meth')

			if meth.limit ~= -1 and meth.count >= meth.limit then
				TriggerClientEvent('esx:showNotification', source, 'vous ne pouvez plus ramasser de Meth, votre inventaire est ~r~plein~s~')
			else
				xPlayer.addInventoryItem('meth', 1)
				HarvestMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarayyyzenvestMeth')
AddEventHandler('esx_drugs:startHarayyyzenvestMeth', function()

	local _source = source

	PlayersHarvestingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Ramassage en cours~s~...')

	HarvestMeth(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvesayyyzentMeth')
AddEventHandler('esx_drugs:stopHarvesayyyzentMeth', function()

	local _source = source

	PlayersHarvestingMeth[_source] = false

end)

local function TransformMeth(source)

	if CopsConnected < ConfigDrogues.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsMeth)
		return
	end

	SetTimeout(12000, function()

		if PlayersTransformingMeth[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local methQuantity = xPlayer.getInventoryItem('meth').count
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, 'vous avez trop de pochons')
			elseif methQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez de Meth à ~r~conditionner~s~')
			else
				xPlayer.removeInventoryItem('meth', 5)
				xPlayer.addInventoryItem('meth_pooch', 1)
				
				TransformMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTayyyzenransformMeth')
AddEventHandler('esx_drugs:startTayyyzenransformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Conditonnement en cours~s~...')

	TransformMeth(_source)

end)

RegisterServerEvent('esx_drugs:stopTranayyyzensformMeth')
AddEventHandler('esx_drugs:stopTranayyyzensformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = false

end)

local function SellMeth(source)

	if CopsConnected < ConfigDrogues.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsMeth)
		return
	end

	SetTimeout(7500, function()

		if PlayersSellingMeth[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez plus de pochons à ~r~vendre~s~')
			else
				xPlayer.removeInventoryItem('meth_pooch', 1)
				if CopsConnected == 0 then
                    xPlayer.addAccountMoney('black_money', 1200)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                elseif CopsConnected == 1 then
                    xPlayer.addAccountMoney('black_money', 1300)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                elseif CopsConnected == 2 then
                    xPlayer.addAccountMoney('black_money', 1400)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                elseif CopsConnected == 3 then
                    xPlayer.addAccountMoney('black_money', 1400)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                elseif CopsConnected == 4 then
                    xPlayer.addAccountMoney('black_money', 1500)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                elseif CopsConnected == 5 then
                    xPlayer.addAccountMoney('black_money', 1500)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                elseif CopsConnected >= 6 then
                    xPlayer.addAccountMoney('black_money', 1500)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de meth~s~')
                end
				
				SellMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellMayyyzeneth')
AddEventHandler('esx_drugs:startSellMayyyzeneth', function()

	local _source = source

	PlayersSellingMeth[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours~s~...')

	SellMeth(_source)

end)

RegisterServerEvent('esx_drugs:stopSellMayyyzeneth')
AddEventHandler('esx_drugs:stopSellMayyyzeneth', function()

	local _source = source

	PlayersSellingMeth[_source] = false

end)

--weed
local function HarvestWeed(source)

	if CopsConnected < ConfigDrogues.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsWeed)
		return
	end

	SetTimeout(5000, function()

		if PlayersHarvestingWeed[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local weed = xPlayer.getInventoryItem('weed')

			if weed.limit ~= -1 and weed.count >= weed.limit then
				TriggerClientEvent('esx:showNotification', source, 'vous ne pouvez plus ramasser de weed, votre inventaire est ~r~plein~s~')
			else
				xPlayer.addInventoryItem('weed', 1)
				HarvestWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHarvestWayyyzeneed')
AddEventHandler('esx_drugs:startHarvestWayyyzeneed', function()

	local _source = source

	PlayersHarvestingWeed[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Ramassage en cours~s~...')

	HarvestWeed(_source)

end)

RegisterServerEvent('esx_drugs:stopHarayyyzenvestWeed')
AddEventHandler('esx_drugs:stopHarayyyzenvestWeed', function()

	local _source = source

	PlayersHarvestingWeed[_source] = false

end)

local function TransformWeed(source)

	if CopsConnected < ConfigDrogues.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsWeed)
		return
	end

	SetTimeout(7500, function()

		if PlayersTransformingWeed[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local weedQuantity = xPlayer.getInventoryItem('weed').count
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, 'vous avez trop de pochons')
			elseif weedQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez de weed à ~r~conditionner~s~')
			else
				xPlayer.removeInventoryItem('weed', 5)
				xPlayer.addInventoryItem('weed_pooch', 1)
				
				TransformWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransfoayyyzenrmWeed')
AddEventHandler('esx_drugs:startTransfoayyyzenrmWeed', function()

	local _source = source

	PlayersTransformingWeed[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Conditonnement en cours~s~...')

	TransformWeed(_source)

end)

RegisterServerEvent('esx_drugs:stopTayyyzenransformWeed')
AddEventHandler('esx_drugs:stopTayyyzenransformWeed', function()

	local _source = source

	PlayersTransformingWeed[_source] = false

end)

local function SellWeed(source)

	if CopsConnected < ConfigDrogues.RequiredCopsWeed then
		TriggerClientEvent('esx_weedjob:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsWeed)
		return
	end

	SetTimeout(7500, function()

		if PlayersSellingWeed[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez plus de pochons à ~r~vendre~s~')
			else
				xPlayer.removeInventoryItem('weed_pooch', 1)
                if CopsConnected == 0 then
                    xPlayer.addAccountMoney('black_money', 1400)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de weed~s~')
                elseif CopsConnected == 1 then
                    xPlayer.addAccountMoney('black_money', 1500)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de weed~s~')
                elseif CopsConnected == 2 then
                    xPlayer.addAccountMoney('black_money', 1600)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de weed~s~')
                elseif CopsConnected == 3 then
                    xPlayer.addAccountMoney('black_money', 1600)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de weed~s~')
                elseif CopsConnected >= 4 then
                    xPlayer.addAccountMoney('black_money', 1700)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de weed~s~')
                end
				
				SellWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellWeayyyzened')
AddEventHandler('esx_drugs:startSellWeayyyzened', function()

	local _source = source

	PlayersSellingWeed[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours~s~...')

	SellWeed(_source)

end)

RegisterServerEvent('esx_drugs:stopSellWayyyzeneed')
AddEventHandler('esx_drugs:stopSellWayyyzeneed', function()

	local _source = source

	PlayersSellingWeed[_source] = false

end)


--opium

local function HarvestOpium(source)

	if CopsConnected < ConfigDrogues.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsOpium)
		return
	end

	SetTimeout(5000, function()

		if PlayersHarvestingOpium[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local opium = xPlayer.getInventoryItem('opium')

			if opium.limit ~= -1 and opium.count >= opium.limit then
				TriggerClientEvent('esx:showNotification', source, 'vous ne pouvez plus ramasser de weed, votre inventaire est ~r~plein~s~')
			else
				xPlayer.addInventoryItem('opium', 1)
				HarvestOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startHayyyzenarvestOpium')
AddEventHandler('esx_drugs:startHayyyzenarvestOpium', function()

	local _source = source

	PlayersHarvestingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Ramassage en cours~s~...')

	HarvestOpium(_source)

end)

RegisterServerEvent('esx_drugs:stopHarvestayyyzenOpium')
AddEventHandler('esx_drugs:stopHarvestayyyzenOpium', function()

	local _source = source

	PlayersHarvestingOpium[_source] = false

end)

local function TransformOpium(source)

	if CopsConnected < ConfigDrogues.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsOpium)
		return
	end

	SetTimeout(10000, function()

		if PlayersTransformingOpium[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local opiumQuantity = xPlayer.getInventoryItem('opium').count
			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity > 35 then
				TriggerClientEvent('esx:showNotification', source, 'vous avez trop de pochons')
			elseif opiumQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez pas assez de opium à ~r~conditionner~s~')
			else
				xPlayer.removeInventoryItem('opium', 5)
				xPlayer.addInventoryItem('opium_pooch', 1)
			
				TransformOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:starayyyzentTransformOpium')
AddEventHandler('esx_drugs:starayyyzentTransformOpium', function()

	local _source = source

	PlayersTransformingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~y~Conditonnement en cours~s~...')

	TransformOpium(_source)

end)

RegisterServerEvent('esx_drugs:stopTransayyyzenformOpium')
AddEventHandler('esx_drugs:stopTransayyyzenformOpium', function()

	local _source = source

	PlayersTransformingOpium[_source] = false

end)

local function SellOpium(source)

	if CopsConnected < ConfigDrogues.RequiredCopsOpium then
		TriggerClientEvent('esx:showNotification', source, 'action ~r~impossible~s~, ~b~policiers~s~: ' .. CopsConnected .. '/' .. ConfigDrogues.RequiredCopsOpium)
		return
	end

	SetTimeout(7500, function()

		if PlayersSellingOpium[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			local poochQuantity = xPlayer.getInventoryItem('opium_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, 'vous n\'avez plus de pochons à ~r~vendre~s~')
			else
				xPlayer.removeInventoryItem('opium_pooch', 1)
				if CopsConnected == 0 then
                    xPlayer.addAccountMoney('black_money', 1800)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de opium~s~')
                elseif CopsConnected == 1 then
                    xPlayer.addAccountMoney('black_money', 1900)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de opium~s~')
                elseif CopsConnected == 2 then
                    xPlayer.addAccountMoney('black_money', 2000)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de opium~s~')
                elseif CopsConnected == 3 then
                    xPlayer.addAccountMoney('black_money', 2100)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de opium~s~')
                elseif CopsConnected == 4 then
                    xPlayer.addAccountMoney('black_money', 2100)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de opium~s~')
                elseif CopsConnected >= 5 then
                    xPlayer.addAccountMoney('black_money', 2200)
                    TriggerClientEvent('esx:showNotification', source, 'vous avez vendu ~g~x1 Pochon de opium~s~')
                end
				
				SellOpium(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellayyyzenOpium')
AddEventHandler('esx_drugs:startSellayyyzenOpium', function()

	local _source = source

	PlayersSellingOpium[_source] = true

	TriggerClientEvent('esx:showNotification', _source, '~g~Vente en cours~s~...')

	SellOpium(_source)

end)

RegisterServerEvent('esx_drugs:stopSellOpiuayyyzenm')
AddEventHandler('esx_drugs:stopSellOpiuayyyzenm', function()

	local _source = source

	PlayersSellingOpium[_source] = false

end)


-- RETURN INVENTORY TO CLIENT
RegisterServerEvent('esx_drugs:GetUserInventory')
AddEventHandler('esx_drugs:GetUserInventory', function(currentZone)
	local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_drugs:ReturnInventory', 
    	_source, 
    	xPlayer.getInventoryItem('coke').count, 
		xPlayer.getInventoryItem('coke_pooch').count,
		xPlayer.getInventoryItem('meth').count, 
		xPlayer.getInventoryItem('meth_pooch').count, 
		xPlayer.getInventoryItem('weed').count, 
		xPlayer.getInventoryItem('weed_pooch').count, 
		xPlayer.getInventoryItem('opium').count, 
		xPlayer.getInventoryItem('opium_pooch').count,
		xPlayer.job.name, 
		currentZone
    )
end)

ESX.RegisterUsableItem('weed', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx_drugeffects:onWeed', source)
end)

ESX.RegisterUsableItem('opium', function(source)
       
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('esx_drugeffects:onOpium', source)
end)

ESX.RegisterUsableItem('meth', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('esx_drugeffects:onMeth', source)
end)

ESX.RegisterUsableItem('coke', function(source)
        
        local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('esx_drugeffects:onCoke', source)
end)

