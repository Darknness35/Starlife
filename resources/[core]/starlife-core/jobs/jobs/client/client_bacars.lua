local PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction = nil, nil
local CurrentActionMsg = ''
local CurrentActionData = {}

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

function MessageBacars()
	Citizen.CreateThread(function()
    while messagebacarsnotfinish do
    		Citizen.Wait(10)
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messagebacarsnotfinish = false
		        TriggerServerEvent('nwx_bacars:annonceBacars',result)   
		    end
		end
	end)
end


function OpenBacarsActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom'},
		{label = 'Tenue civile', value = 'cloakroom2'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bacars_actions',
		{
			css = 'bacars',
			title = 'Bacars',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bacars_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenBacarsVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_list_bacars'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'bacars_vehicles',
		{
			css = 'bacars',
			title = 'Bacars',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_list_bacars' then
				local elements = {
					{label = 'Moonbeam Rider', value = 'moonbeam2'}
				}

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'chef' then
					table.insert(elements, {label = 'Sabre GT Custom', value = 'sabregt2'})
				end

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'gerant' then
					table.insert(elements, {label = 'Sabre GT Custom', value = 'sabregt2'})
					table.insert(elements, {label = 'Massacro', value = 'massacro'})
				end

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = 'Sabre GT Custom', value = 'sabregt2'})
					table.insert(elements, {label = 'Massacro', value = 'massacro'})
					table.insert(elements, {label = 'Elegy Retro', value = 'elegy'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_bacars_vehicle',
					{
						css = 'bacars',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones10.VehicleSpawnPointBacars.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 351.567, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "BACA" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
              						plate = string.gsub(plate, " ", "")
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones10.VehicleSpawnPointBacars.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 351.567, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "BACA" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
              								plate = string.gsub(plate, " ", "")
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'bacars')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenBacarsVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'bacars_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenMobileBacarsActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_bacars_actions',
		{
			css = 'bacars',
			title = 'Bacars',
			elements = {
				{label = 'Facturation',    value = 'billing'},
				{label = '----------------------------', value = nil},
				{label = 'Passer une annonce', value = 'announceBacars'},
			}
		},
		function(data, menu)

			if data.current.value == 'billing' then
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'billing',
					{
						title = 'Montant de la facture'
					},
					function(data, menu)
						local amount = tonumber(data.value)
						if amount == nil then
							ESX.ShowNotification('Montant invalide')
						else							
							menu.close()							
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification('Aucun joueur à proximité')
							else
								TriggerServerEvent('esx_biayyyzenlling:sendBill', GetPlayerServerId(closestPlayer), 'society_bacars', 'Bacars', amount)
							end
						end
					end,
				function(data, menu)
					menu.close()
				end
				)
			end

			if data.current.value == 'announceBacars' then
			    messagebacarsnotfinish = true
				MessageBacars()
			end

		end,
	function(data, menu)
		menu.close()
	end
	)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('nwx_bacars:hasEnteredMarker', function(zone)

	if zone == 'BacarsActions' then
		CurrentAction = 'bacars_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'VehicleSpawnBacarsMenu' then
		CurrentAction = 'bacars_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleDeleterBacars' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_bacars_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	elseif zone == 'BossActionsBacars' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_actions_bacars_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu patron.'
		CurrentActionData = {}
	end

end)

AddEventHandler('nwx_bacars:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bacars' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones10) do
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
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bacars' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones10) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_bacars:hasEnteredMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_bacars:hasExitedMarker', LastZone)
			end
		end
	end
end)



-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bacars' then

                if CurrentAction == 'bacars_actions_menu' then
                	OpenBacarsActionsMenu()
				elseif CurrentAction == 'boss_actions_bacars_menu' then
                	OpenBossActionsBacarsMenu()
                elseif CurrentAction == 'bacars_vehicles_menu' then
                	OpenBacarsVehiclesMenu()
                elseif CurrentAction == 'delete_bacars_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('moonbeam2') or
					hash == GetHashKey('sabregt2') or
					hash == GetHashKey('massacro') or
					hash == GetHashKey('elegy') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'bacars')
                        end
                        DeleteVehicle(vehicle)
                        TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules Bacars~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end

        if IsControlJustReleased(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bacars' then
            OpenMobileBacarsActionsMenu()
		end
		
    end
end)

function DrawAdvancedTextCNN (x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end


 Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)    
						
		if (affichebacarsnews == true) then
			DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
			DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Bacars ~d~", 255, 255, 255, 255, 1, 0)
			DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, textebacarsafiche, 255, 255, 255, 255, 7, 0)
			DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
		end 

	end
end)



RegisterNetEvent('nwx_bacars:annonceBacars')
AddEventHandler('nwx_bacars:annonceBacars', function(text)
	textebacarsafiche = text
	affichebacarsnews = true	
end) 


RegisterNetEvent('nwx_bacars:annonceBacarsstop')
AddEventHandler('nwx_bacars:annonceBacarsstop', function()
	affichebacarsnews = false	
end) 


function OpenBossActionsBacarsMenu()

	local elements = {
		{label = '----------------', value = nil},
		{label = 'Action Patron', value = 'boss_actions'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions',
		{
			css = 'bacars',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_actions' then
				TriggerEvent('esx_society:openBosayyyzensMenu', 'bacars', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_actions_bacars_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

-- TELEPORTERS
AddEventHandler('esx_bacars:teleportMarkersBacars', function(position)
  SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
end)

-- Show top left hint
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if hintIsShowed == true then
      SetTextComponentFormat("STRING")
      AddTextComponentString(hintToDisplay)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    end
  end
end)

-- Display teleport markers
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    --if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bacars' then
      local coords = GetEntityCoords(GetPlayerPed(-1))

      for k,v in pairs(ConfigJob.TeleportZonesBacars) do
        if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ConfigJob.DrawDistance) then
          DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end

    --end

  end
end)

-- Activate teleport marker
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local position = nil
    local zone = nil

    --if  ESX.PlayerData.job ~= nil and  ESX.PlayerData.job.name == 'bacars' then

      for k,v in pairs(ConfigJob.TeleportZonesBacars) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInPublicMarker = true
          position = v.Teleport
          zone = v
          break
        else
          isInPublicMarker = false
        end
      end

      if IsControlJustReleased(0, 38) and isInPublicMarker then
        TriggerEvent('esx_bacars:teleportMarkersBacars', position)
      end

      -- hide or show top left zone hints
      if isInPublicMarker then
        hintToDisplay = zone.Hint
        hintIsShowed = true
      else
        if not isInMarker then
          hintToDisplay = "no hint to display"
          hintIsShowed = false
        end
      end

    --end

  end
end)