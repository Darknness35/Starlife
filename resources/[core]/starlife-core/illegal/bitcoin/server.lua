ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingKoda    = {}
local PlayersTransformingKoda  = {}
local PlayersSellingKoda       = {}

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

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

--kodeina
local function HarvestKoda(source)

	SetTimeout(ConfigBitcoin.TimeToFarm, function()
		if PlayersHarvestingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local koda = xPlayer.getInventoryItem('bitcoin')

			if koda.limit ~= -1 and koda.count >= koda.limit then
				TriggerClientEvent('esx:showNotification', source, "Vous porter trop de bitcoin sur vous")
			else
				xPlayer.addInventoryItem('bitcoin', 1)
				HarvestKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_bitcoin:startHarvestKoda')
AddEventHandler('esx_bitcoin:startHarvestKoda', function()
	local _source = source

	if not PlayersHarvestingKoda[_source] then
		PlayersHarvestingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, '~y~En train de Miner Du Bitcoin~s~...')
		HarvestKoda(_source)
	else
		print(('esx_bitcoin: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_bitcoin:stopHarvestKoda')
AddEventHandler('esx_bitcoin:stopHarvestKoda', function()
	local _source = source

	PlayersHarvestingKoda[_source] = false
end)

local function TransformKoda(source)

	SetTimeout(ConfigBitcoin.TimeToProcess, function()
		if PlayersTransformingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local kodaQuantity = xPlayer.getInventoryItem('bitcoin').count
			local pooch = xPlayer.getInventoryItem('bitcoin')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', source, 'Vous n avez pas assez de ~r~Bitcoin~s~')
			elseif kodaQuantity < 2 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n avez pas assez de ~r~Bicoin~s~')
			else
				xPlayer.removeInventoryItem('bitcoin', 2)
				xPlayer.addInventoryItem('bitcoin', 1)

				TransformKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_bitcoin:stopTransformKoda')
AddEventHandler('esx_bitcoin:stopTransformKoda', function()
	local _source = source

	PlayersTransformingKoda[_source] = false
end)

local function SellKoda(source)

	SetTimeout(ConfigBitcoin.TimeToSell, function()
		if PlayersSellingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local poochQuantity = xPlayer.getInventoryItem('bitcoin').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, 'Vous n avez pas assez de ~r~Bitcoin~s~')
			else
				xPlayer.removeInventoryItem('bitcoin', 1)
				if CopsConnected >= 0 then
					xPlayer.addAccountMoney('bank', 43)
					TriggerClientEvent('esx:showNotification', source, 'Vendre ~y~x1~s~ ~y~Bitcoin~s~')
				end

				SellKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_bitcoin:startSellKoda')
AddEventHandler('esx_bitcoin:startSellKoda', function()
	local _source = source

	if not PlayersSellingKoda[_source] then
		PlayersSellingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, '~g~Pour vendre des Bitcoin~s~...')
		SellKoda(_source)
	else
		print(('esx_bitcoin: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_bitcoin:stopSellKoda')
AddEventHandler('esx_bitcoin:stopSellKoda', function()
	local _source = source

	PlayersSellingKoda[_source] = false
end)

RegisterServerEvent('esx_bitcoin:GetUserInventory')
AddEventHandler('esx_bitcoin:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_bitcoin:ReturnInventory',
		_source,
		xPlayer.getInventoryItem('bitcoin').count,
		xPlayer.getInventoryItem('bitcoin').count,
		xPlayer.job.name,
		currentZone
	)
end)