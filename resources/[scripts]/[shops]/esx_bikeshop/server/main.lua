local Categories = {}
local Vehicles = {}

ESX = nil
TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'bikedealer', _U('dealer_customers'), false, false)
TriggerEvent('esx_society:registerSociety', 'bikedealer', _U('car_dealer'), 'society_bikedealer', 'society_bikedealer', 'society_bikedealer', {type = 'private'})

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('esx_bikeshop: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

MySQL.ready(function()
	Categories = MySQL.Sync.fetchAll('SELECT * FROM bike_categories')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM bikes')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	-- send information after db has loaded, making sure everyone gets vehicle information
	TriggerClientEvent('esx_bikeshop:sendCategories', -1, Categories)
	TriggerClientEvent('esx_bikeshop:sendVehicles', -1, Vehicles)
end)

RegisterServerEvent('esx_bikeshop:setVehicleOwned')
AddEventHandler('esx_bikeshop:setVehicleOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
	{
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@job'] = "empty"
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, _U('vehicle_belongs', vehicleProps.plate))
	end)
end)

RegisterServerEvent('esx_bikeshop:setVehicleOwnedPlayerId')
AddEventHandler('esx_bikeshop:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
	{
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@job'] = "empty"
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, _U('vehicle_belongs', vehicleProps.plate))
	end)
end)

RegisterServerEvent('esx_bikeshop:setVehicleOwnedSociety')
AddEventHandler('esx_bikeshop:setVehicleOwnedSociety', function (society, vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner'] = 'society:' .. society,
		['@plate'] = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
	}, function (rowsChanged)

	end)
end)

RegisterServerEvent('esx_bikeshop:sellVehicle')
AddEventHandler('esx_bikeshop:sellVehicle', function (vehicle)
	MySQL.Async.fetchAll('SELECT * FROM bikedealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
		['@vehicle'] = vehicle
	}, function (result)
		local id = result[1].id

		MySQL.Async.execute('DELETE FROM bikedealer_vehicles WHERE id = @id', {
			['@id'] = id
		})
	end)
end)

RegisterServerEvent('esx_bikeshop:addToList')
AddEventHandler('esx_bikeshop:addToList', function(target, model, plate)
	local xPlayer, xTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)
	local dateNow = os.date('%Y-%m-%d %H:%M')

	if xPlayer.job.name ~= 'bikedealer' then
		print(('esx_bikeshop: %s attempted to add a sold bike to list!'):format(xPlayer.identifier))
		return
	end

	MySQL.Async.execute('INSERT INTO bike_sold (client, model, plate, soldby, date) VALUES (@client, @model, @plate, @soldby, @date)', {
		['@client'] = xTarget.getName(),
		['@model'] = model,
		['@plate'] = plate,
		['@soldby'] = xPlayer.getName(),
		['@date'] = dateNow
	})
end)

ESX.RegisterServerCallback('esx_bikeshop:getSoldVehicles', function (source, cb)

	MySQL.Async.fetchAll('SELECT * FROM bike_sold', {}, function(result)
		cb(result)
	end)
end)

--[[ RegisterServerEvent('esx_bikeshop:rentVehicle')
AddEventHandler('esx_bikeshop:rentVehicle', function (vehicle, plate, playerName, basePrice, rentPrice, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM bikedealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
		['@vehicle'] = vehicle
	}, function (result)
		local id = result[1].id
		local price = result[1].price
		local owner = xPlayer.identifier

		MySQL.Async.execute('DELETE FROM bikedealer_vehicles WHERE id = @id', {
			['@id'] = id
		})

		MySQL.Async.execute('INSERT INTO rented_bikes (vehicle, plate, player_name, base_price, rent_price, owner) VALUES (@vehicle, @plate, @player_name, @base_price, @rent_price, @owner)',
		{
			['@vehicle'] = vehicle,
			['@plate'] = plate,
			['@player_name'] = playerName,
			['@base_price'] = basePrice,
			['@rent_price'] = rentPrice,
			['@owner'] = owner
		})
	end)
end) ]]

RegisterServerEvent('esx_bikeshop:getStockItem')
AddEventHandler('esx_bikeshop:getStockItem', function (itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bikedealer', function (inventory)
		local item = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_society'))
		end
	end)
end)

RegisterServerEvent('esx_bikeshop:putStockItems')
AddEventHandler('esx_bikeshop:putStockItems', function (itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bikedealer', function (inventory)
		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, _U('have_deposited', count, item.label))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_bikeshop:getCategories', function (source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_bikeshop:getVehicles', function (source, cb)
	cb(Vehicles)
end)

ESX.RegisterServerCallback('esx_bikeshop:buyVehicle', function (source, cb, vehicleModel)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicleData = nil

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	if xPlayer.getMoney() >= vehicleData.price then
		xPlayer.removeMoney(vehicleData.price)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_bikeshop:buyVehicleSociety', function (source, cb, society, vehicleModel)
	local vehicleData = nil

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function (account)
		if account.money >= vehicleData.price then
			account.removeMoney(vehicleData.price)

			MySQL.Async.execute('INSERT INTO bikedealer_vehicles (vehicle, price) VALUES (@vehicle, @price)', {
				['@vehicle'] = vehicleData.model,
				['@price'] = vehicleData.price
			}, function(rowsChanged)
				cb(true)
			end)

		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_bikeshop:getCommercialVehicles', function (source, cb)
	MySQL.Async.fetchAll('SELECT * FROM bikedealer_vehicles ORDER BY vehicle ASC', {}, function (result)
		local vehicles = {}

		for i=1, #result, 1 do
			table.insert(vehicles, {
				name = result[i].vehicle,
				price = result[i].price
			})
		end

		cb(vehicles)
	end)
end)


--[[ RegisterServerEvent('esx_bikeshop:returnProvider')
AddEventHandler('esx_bikeshop:returnProvider', function(vehicleModel)
	local _source = source

	MySQL.Async.fetchAll('SELECT * FROM bikedealer_vehicles WHERE vehicle = @vehicle LIMIT 1', {
		['@vehicle'] = vehicleModel
	}, function (result)

		if result[1] then
			local id = result[1].id
			local price = ESX.Math.Round(result[1].price * 0.75)

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer', function(account)
				account.addMoney(price)
			end)

			MySQL.Async.execute('DELETE FROM bikedealer_vehicles WHERE id = @id', {
				['@id'] = id
			})

			TriggerClientEvent('esx:showNotification', _source, _U('vehicle_sold_for', vehicleModel, ESX.Math.GroupDigits(price)))
		else

			print(('esx_bikeshop: %s attempted selling an invalid vehicle!'):format(GetPlayerIdentifiers(_source)[1]))
		end

	end)
end) ]]

--[[ ESX.RegisterServerCallback('esx_bikeshop:getRentedVehicles', function (source, cb)
	MySQL.Async.fetchAll('SELECT * FROM rented_bikes ORDER BY player_name ASC', {}, function (result)
		local vehicles = {}

		for i=1, #result, 1 do
			table.insert(vehicles, {
				name = result[i].vehicle,
				plate = result[i].plate,
				playerName = result[i].player_name
			})
		end

		cb(vehicles)
	end)
end) ]]

--[[ ESX.RegisterServerCallback('esx_bikeshop:giveBackVehicle', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM rented_bikes WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		if result[1] ~= nil then
			local vehicle = result[1].vehicle
			local basePrice = result[1].base_price

			MySQL.Async.execute('INSERT INTO bikedealer_vehicles (vehicle, price) VALUES (@vehicle, @price)', {
				['@vehicle'] = vehicle,
				['@price'] = basePrice
			})

			MySQL.Async.execute('DELETE FROM rented_bikes WHERE plate = @plate', {
				['@plate'] = plate
			})

			RemoveOwnedVehicle(plate)
			cb(true)
		else
			cb(false)
		end
	end)
end) ]]

--[[ ESX.RegisterServerCallback('esx_bikeshop:resellVehicle', function (source, cb, plate, model)
	local resellPrice = 0

	-- calculate the resell price
	for i=1, #Vehicles, 1 do
		if GetHashKey(Vehicles[i].model) == model then
			resellPrice = ESX.Math.Round(Vehicles[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if resellPrice == 0 then
		print(('esx_bikeshop: %s attempted to sell an unknown bike!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	else
		MySQL.Async.fetchAll('SELECT * FROM rented_bikes WHERE plate = @plate', {
			['@plate'] = plate
		}, function (result)
			if result[1] then -- is it a rented vehicle?
				cb(false) -- it is, don't let the player sell it since he doesn't own it
			else
				local xPlayer = ESX.GetPlayerFromId(source)

				MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
					['@owner'] = xPlayer.identifier,
					['@plate'] = plate
				}, function (result)
					if result[1] then -- does the owner match?
						local vehicle = json.decode(result[1].vehicle)

						if vehicle.model == model then
							if vehicle.plate == plate then
								xPlayer.addMoney(resellPrice)
								RemoveOwnedVehicle(plate)
								cb(true)
							else
								print(('esx_bikeshop: %s attempted to sell an bike with plate mismatch!'):format(xPlayer.identifier))
								cb(false)
							end
						else
							print(('esx_bikeshop: %s attempted to sell an bike with model mismatch!'):format(xPlayer.identifier))
							cb(false)
						end
					else
						if xPlayer.job.grade_name == 'boss' then
							MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
								['@owner'] = 'society:' .. xPlayer.job.name,
								['@plate'] = plate
							}, function (result)
								if result[1] then
									local vehicle = json.decode(result[1].vehicle)

									if vehicle.model == model then
										if vehicle.plate == plate then
											xPlayer.addMoney(resellPrice)
											RemoveOwnedVehicle(plate)
											cb(true)
										else
											print(('esx_bikeshop: %s attempted to sell an bike with plate mismatch!'):format(xPlayer.identifier))
											cb(false)
										end
									else
										print(('esx_bikeshop: %s attempted to sell an bike with model mismatch!'):format(xPlayer.identifier))
										cb(false)
									end
								else
									cb(false)
								end
							end)
						else
							cb(false)
						end
					end
				end)
			end
		end)
	end
end) ]]

ESX.RegisterServerCallback('esx_bikeshop:getStockItems', function (source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_bikedealer', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_bikeshop:getPlayerInventory', function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_bikeshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_bikeshop:retrieveJobVehicles', function (source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function (result)
		cb(result)
	end)
end)

RegisterServerEvent('esx_bikeshop:setJobVehicleState')
AddEventHandler('esx_bikeshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_bikeshop: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

--[[ function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM rented_bikes', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer ~= nil then
				xPlayer.removeAccountMoney('bank', result[i].rent_price)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_rental', ESX.Math.GroupDigits(result[i].rent_price)))
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier',
				{
					['@bank'] = result[i].rent_price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_bikedealer', function(account)
				account.addMoney(result[i].rent_price)
			end)
		end
	end)
end

TriggerEvent('cron:runAt', 23, 00, PayRent) ]]