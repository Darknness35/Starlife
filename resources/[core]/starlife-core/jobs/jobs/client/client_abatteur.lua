local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsAbatteur = {}
local JobBlipsAbatteur = {}
local JobBlipsAbatteur2 = {}
local Blips2Abatteur = {}
local JobBlips2Abatteur = {}


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
end)


function OpenAbatteurActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_abatteur'},
		{label = 'Tenue civile', value = 'cloakroom2_abatteur'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'abatteur_actions',
		{
			css = 'entreprise',
			title = 'Abatteur',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_abatteur' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2_abatteur' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'abatteur_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenAbatteurVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_abatteur_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'abatteur_vehicles',
		{
			css = 'vehicle',
			title = 'Abatteur',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_abatteur_list' then
				local elements = {
					{label = 'Mule', value = 'mule3'}
				}

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_abatteur_vehicle',
					{
						css = 'vehicle',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones9.VehicleSpawnAbatteurPoint.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 8.67, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "ABATT" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones9.VehicleSpawnAbatteurPoint.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 8.67, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "ABATT" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'abatteur')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenAbatteurVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'abatteur_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenAbatteurHarvestMenu()

	local elements = {
		{label = 'Poulet', value = 'harvest_abatteur'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'abatteur_harvest',
		{
			title = 'Poulet',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_abatteur' then
				menu.close()
				TriggerServerEvent('nwx_abatteur:startHarvestAbatteur')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'abatteur_harvest_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenAbatteurCraftMenu()

	local elements = {
		{label = 'Mettre en barquette', value = 'craft_abatteur'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'abatteur_craft',
		{
			css = 'entreprise',
			title = 'Mettre en barquette',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_abatteur' then
				menu.close()
				TriggerServerEvent('nwx_abatteur:startCraftAbatteur')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'abatteur_craft_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la coupe.'
			CurrentActionData = {}
		end
	)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	CreateJobBlipsAbatteur()
	CreateJobBlipsAbatteur2()
	CreateJobBlips2Abatteur()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	DeleteJobBlipsAbatteur()
	DeleteJobBlipsAbatteur2()
	CreateJobBlipsAbatteur()
	CreateJobBlipsAbatteur2()
    DeleteJobBlips2Abatteur()
    CreateJobBlips2Abatteur()
end)

function IsJobTrueAbatteur()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueAbatteur = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'abatteur' then
		IsJobTrueAbatteur = true
	  end
	  return IsJobTrueAbatteur
	end
end
  
function CreateJobBlipsAbatteur()
	if IsJobTrueAbatteur() then               
	local blip = AddBlipForCoord(ConfigJob.Zones15.AbatteurSellFarm.Pos.x, ConConfigJobnes15.AbatteurSellFarm.Pos.y, ConfigConfigJob15.AbatteurSellFarm.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente de barquettes")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsAbatteur, blip) 
	end 
end

function CreateJobBlipsAbatteur2()
	if IsJobTrueAbatteur() then               
	local blip = AddBlipForCoord(ConfigJob.Zones15.HarvestAbatteur.Pos.x, ConConfigJobnes15.HarvestAbatteur.Pos.y, ConfigConfigJob15.HarvestAbatteur.Pos.z)
		SetBlipSprite(blip, 237)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 10)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Abbatoir")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsAbatteur2, blip) 
	end 
end

function DeleteJobBlipsAbatteur()
	if JobBlipsAbatteur[1] ~= nil then
		for i=1, #JobBlipsAbatteur, 1 do
			RemoveBlip(JobBlipsAbatteur[i])
			JobBlipsAbatteur[i] = nil
		end
	end
end

function DeleteJobBlipsAbatteur2()
	if JobBlipsAbatteur2[1] ~= nil then
		for i=1, #JobBlipsAbatteur2, 1 do
			RemoveBlip(JobBlipsAbatteur2[i])
			JobBlipsAbatteur2[i] = nil
		end
	end
end

function IsJobTrue2Abatteur()
  if ESX.PlayerData ~= nil then
    local IsJobTrue2Abatteur = false
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'abatteur' then
      IsJobTrue2Abatteur = true
    end
    return IsJobTrue2Abatteur
  end
end

function CreateJobBlips2Abatteur()
	if IsJobTrue2Abatteur() then               
	local blip2 = AddBlipForCoord(ConfigJob.Zones15.AbatteurCraft.Pos.x, ConConfigJobnes15.AbatteurCraft.Pos.y, ConfigConfigJob15.AbatteurCraft.Pos.z)
		SetBlipSprite(blip2, 478)
		SetBlipDisplay(blip2, 4)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 10)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Mise en barquette")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips2Abatteur, blip2)
	end 
end

function DeleteJobBlips2Abatteur()
	if JobBlips2Abatteur[1] ~= nil then
		for i=1, #JobBlips2Abatteur, 1 do
			RemoveBlip(JobBlips2Abatteur[i])
			JobBlips2Abatteur[i] = nil
		end
	end
end

AddEventHandler('nwx_abatteur:hasEnteredMarkerAbatteur', function(zone)

	if zone == 'AbatteurActions' then
		CurrentAction = 'abatteur_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'HarvestAbatteur' then
		CurrentAction = 'abatteur_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'AbatteurCraft' then
		CurrentAction = 'abatteur_craft_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a a la coupe.'
		CurrentActionData = {}
	elseif zone == 'AbatteurSellFarm' then
		CurrentAction = 'abatteur_sell_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'VehicleSpawnAbatteurMenu' then
		CurrentAction = 'abatteur_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleAbatteurDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_abatteur_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	end

end)

AddEventHandler('nwx_abatteur:hasExitedMarkerAbatteur', function(zone)

	if zone == 'AbatteurCraft' then
		TriggerServerEvent('nwx_abatteur:stopCraftAbatteur')
	elseif zone == 'AbatteurCraft2' then
		TriggerServerEvent('nwx_abatteur:stopCraftAbatteur2')
		TriggerServerEvent('nwx_abatteur:stopCraftAbatteur3')
	elseif zone == 'HarvestAbatteur' then
		TriggerServerEvent('nwx_abatteur:stopHarvestAbatteur')
	elseif zone == 'AbatteurSellFarm' then
		TriggerServerEvent('nwx_abatteur:stopSellAbatteur')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'abatteur' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones15) do
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
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'abatteur' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones15) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_abatteur:hasEnteredMarkerAbatteur', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_abatteur:hasExitedMarkerAbatteur', LastZone)
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
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'abatteur' then

                if CurrentAction == 'abatteur_actions_menu' then
                	OpenAbatteurActionsMenu()
                elseif CurrentAction == 'abatteur_harvest_menu' then
                	OpenAbatteurHarvestMenu()
                elseif CurrentAction == 'abatteur_craft_menu' then
					OpenAbatteurCraftMenu()
				elseif CurrentAction == 'abatteur_sell_menu' then
					TriggerServerEvent('nwx_abatteur:startSellAbatteur', CurrentActionData.zone)
				elseif CurrentAction == 'abatteur_sell_menu2' then
                	TriggerServerEvent('nwx_abatteur:startSellAbatteur2', CurrentActionData.zone)
                elseif CurrentAction == 'abatteur_vehicles_menu' then
                	OpenAbatteurVehiclesMenu()
                elseif CurrentAction == 'delete_abatteur_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('mule3') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'abatteur')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules Abatteur~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end
		
    end
end)
