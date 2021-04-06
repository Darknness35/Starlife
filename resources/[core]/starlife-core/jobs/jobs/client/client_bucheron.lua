local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsBucheron = {}
local JobBlipsBucheron = {}
local JobBlipsBucheron2 = {}
local Blips2Bucheron = {}
local JobBlips2Bucheron = {}


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	CreateJobBlipsBucheron()
	CreateJobBlipsBucheron2()
	CreateJobBlips2Bucheron()
end)


function OpenBucheronActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_bucheron'},
		{label = 'Tenue civile', value = 'cloakroom2_bucheron'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bucheron_actions',
		{
			css = 'entreprise',
			title = 'Bucheron',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_bucheron' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2_bucheron' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bucheron_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenBucheronVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_bucheron_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bucheron_vehicles',
		{
			css = 'vehicle',
			title = 'Bucheron',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_bucheron_list' then
				local elements = {
					{label = 'Mule', value = 'mule3'}
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_bucheron_vehicle',
					{
						css = 'vehicle',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones9.VehicleSpawnBucheronPoint.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 8.67, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "BUCH" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones9.VehicleSpawnBucheronPoint.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 8.67, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "BUCH" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'bucheron')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenBucheronVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bucheron_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenBucheronHarvestMenu()

	local elements = {
		{label = 'Bois', value = 'harvest_bucheron'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bucheron_harvest',
		{
			title = 'Bois',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_bucheron' then
				menu.close()
				TriggerServerEvent('nwx_bucheron:startHarvestBucheron')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bucheron_harvest_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenBucheronCraftMenu()

	local elements = {
		{label = 'Couper bois', value = 'craft_bucheron'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bucheron_craft',
		{
			css = 'entreprise',
			title = 'Couper bois',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_bucheron' then
				menu.close()
				TriggerServerEvent('nwx_bucheron:startCraftBucheron')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bucheron_craft_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la coupe.'
			CurrentActionData = {}
		end
	)
end

function OpenBucheronCraft2Menu()

	local elements = {
		{label = 'Paquet de planches', value = 'craft_paquetplanche'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bucheron_craft2',
		{
			css = 'entreprise',
			title = 'Paquet de planches',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_paquetplanche' then
				menu.close()
				TriggerServerEvent('nwx_bucheron:startCraftBucheron2')
			end
		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bucheron_craft_menu2'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a l\'assemblement.'
			CurrentActionData = {}
		end
	)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	CreateJobBlipsBucheron()
	CreateJobBlipsBucheron2()
	CreateJobBlips2Bucheron()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	--DeleteJobBlipsBucheron()
	--DeleteJobBlipsBucheron2()
	CreateJobBlipsBucheron()
	CreateJobBlipsBucheron2()
    --DeleteJobBlips2Bucheron()
    CreateJobBlips2Bucheron()
end)

function IsJobTrueBucheron()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueBucheron = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bucheron' then
		IsJobTrueBucheron = true
	  end
	  return IsJobTrueBucheron
	end
end
  
function CreateJobBlipsBucheron()
	if IsJobTrueBucheron() then               
	local blip = AddBlipForCoord(ConfigJob.Zones9.BucheronSellFarm.Pos.x, ConfigJob.Zones9.BucheronSellFarm.Pos.y, ConfigJob.Zones9.BucheronSellFarm.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente paquet planches")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsBucheron, blip) 
	end 
end

function CreateJobBlipsBucheron2()
	if IsJobTrueBucheron() then               
	local blip = AddBlipForCoord(ConfigJob.Zones9.HarvestBucheron.Pos.x, ConfigJob.Zones9.HarvestBucheron.Pos.y, ConfigJob.Zones9.HarvestBucheron.Pos.z)
		SetBlipSprite(blip, 237)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 10)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Récolte bois")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsBucheron2, blip) 
	end 
end

function DeleteJobBlipsBucheron()
	if JobBlipsBucheron[1] ~= nil then
		for i=1, #JobBlipsBucheron, 1 do
			RemoveBlip(JobBlipsBucheron[i])
			JobBlipsBucheron[i] = nil
		end
	end
end

function DeleteJobBlipsBucheron2()
	if JobBlipsBucheron2[1] ~= nil then
		for i=1, #JobBlipsBucheron2, 1 do
			RemoveBlip(JobBlipsBucheron2[i])
			JobBlipsBucheron2[i] = nil
		end
	end
end

function IsJobTrue2Bucheron()
  if ESX.PlayerData ~= nil then
    local IsJobTrue2Bucheron = false
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bucheron' then
      IsJobTrue2Bucheron = true
    end
    return IsJobTrue2Bucheron
  end
end

function CreateJobBlips2Bucheron()
	if IsJobTrue2Bucheron() then               
	local blip2 = AddBlipForCoord(ConfigJob.Zones9.BucheronCraft2.Pos.x, ConfigJob.Zones9.BucheronCraft2.Pos.y, ConfigJob.Zones9.BucheronCraft2.Pos.z)
		SetBlipSprite(blip2, 478)
		SetBlipDisplay(blip2, 4)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 10)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Assemblement paquet")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips2Bucheron, blip2)
	end 
end

function DeleteJobBlips2Bucheron()
	if JobBlips2Bucheron[1] ~= nil then
		for i=1, #JobBlips2Bucheron, 1 do
			RemoveBlip(JobBlips2Bucheron[i])
			JobBlips2Bucheron[i] = nil
		end
	end
end

AddEventHandler('nwx_bucheron:hasEnteredMarkerBucheron', function(zone)

	if zone == 'BucheronActions' then
		CurrentAction = 'bucheron_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'HarvestBucheron' then
		CurrentAction = 'bucheron_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'BucheronCraft' then
		CurrentAction = 'bucheron_craft_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a a la coupe.'
		CurrentActionData = {}
	elseif zone == 'BucheronCraft2' then
		CurrentAction = 'bucheron_craft_menu2'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a l\'assemblage.'
		CurrentActionData = {}
	elseif zone == 'BucheronSellFarm' then
		CurrentAction = 'bucheron_sell_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'VehicleSpawnBucheronMenu' then
		CurrentAction = 'bucheron_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleBucheronDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_bucheron_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	end

end)

AddEventHandler('nwx_bucheron:hasExitedMarkerBucheron', function(zone)

	if zone == 'BucheronCraft' then
		TriggerServerEvent('nwx_bucheron:stopCraftBucheron')
	elseif zone == 'BucheronCraft2' then
		TriggerServerEvent('nwx_bucheron:stopCraftBucheron2')
		TriggerServerEvent('nwx_bucheron:stopCraftBucheron3')
	elseif zone == 'HarvestBucheron' then
		TriggerServerEvent('nwx_bucheron:stopHarvestBucheron')
	elseif zone == 'BucheronSellFarm' then
		TriggerServerEvent('nwx_bucheron:stopSellBucheron')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bucheron' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones9) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ConfigJob.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bucheron' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones9) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_bucheron:hasEnteredMarkerBucheron', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_bucheron:hasExitedMarkerBucheron', LastZone)
			end
		end
	end
end)



-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bucheron' then

                if CurrentAction == 'bucheron_actions_menu' then
                	OpenBucheronActionsMenu()
                elseif CurrentAction == 'bucheron_harvest_menu' then
                	OpenBucheronHarvestMenu()
                elseif CurrentAction == 'bucheron_craft_menu' then
					OpenBucheronCraftMenu()
				elseif CurrentAction == 'bucheron_craft_menu2' then
					OpenBucheronCraft2Menu()
				elseif CurrentAction == 'bucheron_sell_menu' then
					TriggerServerEvent('nwx_bucheron:startSellBucheron', CurrentActionData.zone)
				elseif CurrentAction == 'bucheron_sell_menu2' then
                	TriggerServerEvent('nwx_bucheron:startSellBucheron2', CurrentActionData.zone)
                elseif CurrentAction == 'bucheron_vehicles_menu' then
                	OpenBucheronVehiclesMenu()
                elseif CurrentAction == 'delete_bucheron_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('mule3') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'bucheron')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules bucheron~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end
		
    end
end)
