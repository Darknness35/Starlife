local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsUnicorn = {}
local JobBlipsUnicorn = {}
local JobBlipsUnicorn2 = {}
local Blips2Unicorn = {}
local JobBlips2Unicorn = {}


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
	CreateJobBlipsUnicorn()
	CreateJobBlipsUnicorn2()
	CreateJobBlips2Unicorn()
end)

function MessageUnicorn()
	Citizen.CreateThread(function()
    while messageunicornnotfinish do
    		Citizen.Wait(10)
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messageunicornnotfinish = false
		        TriggerServerEvent('nwx_unicorn:annonceUnicorn',result)   
		    end


		end
	end)
end

function OpenUnicornActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_unicorn'},
		{label = 'Tenue civile', value = 'cloakroom2_unicorn'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_actions',
		{
			css = 'unicorn',
			title = 'Unicorn',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_unicorn' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2_unicorn' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenUnicornVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_unicorn_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_vehicles',
		{
			css = 'unicorn',
			title = 'Unicorn',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_unicorn_list' then
				local elements = {
					{label = 'Burrito livraison', value = 'burrito3'},
					{label = 'Brioso', value = 'brioso'}
				}

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = 'Cognoscenti', value = 'cognoscenti'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_unicorn_vehicle',
					{
						css = 'unicorn',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones8.VehicleSpawnUnicornPoint.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 300.149, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "UNIC" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones8.VehicleSpawnUnicornPoint.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 300.149, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "UNIC" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'unicorn')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenUnicornVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenUnicornHarvestMenu()

	local elements = {
		{label = 'Houblon', value = 'harvest_houblon'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_harvest',
		{
			css = 'unicorn',
			title = 'Ramasser du Houblon',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_houblon' then
				menu.close()
				TriggerServerEvent('nwx_unicorn:startHarvestUnicorn')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_harvest_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenUnicornHarvestMenu2()

	local elements = {
		{label = 'Malt', value = 'harvest_malt'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_harvest2',
		{
			css = 'unicorn',
			title = 'Ramasser du malt',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_malt' then
				menu.close()
				TriggerServerEvent('nwx_unicorn:startHarvestUnicorn2')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_harvest_menu2'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenUnicornCraftMenu()

	local elements = {
		{label = 'Bière', value = 'craft_biere'},
		{label = 'Cocktail', value = 'craft_cocktail'},
		{label = 'Mojito', value = 'craft_mojito'},
		{label = 'Rhum', value = 'craft_rhum'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'unicorn_craft',
		{
			css = 'unicorn',
			title = 'Distillation',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_biere' then
				menu.close()
				TriggerServerEvent('nwx_unicorn:startCraftUnicorn')
			elseif data.current.value == 'craft_cocktail' then
				menu.close()
				TriggerServerEvent('nwx_unicorn:startCraftUnicorn2')
			elseif data.current.value == 'craft_mojito' then
				menu.close()
				TriggerServerEvent('nwx_unicorn:startCraftUnicorn3')
			elseif data.current.value == 'craft_rhum' then
				menu.close()
				TriggerServerEvent('nwx_unicorn:startCraftUnicorn4')
			end
			
		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'unicorn_craft_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenMobileUnicornActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_unicorn_actions',
		{
			css = 'unicorn',
			title = 'Unicorn',
			elements = {
				{label = 'Facturation',    value = 'billing_unicorn'},
				{label = '----------------------------', value = nil},
				{label = 'Passer une annonce', value = 'announce_unicorn'},
			}
		},
		function(data, menu)

			if data.current.value == 'billing_unicorn' then
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'unicorn_billing',
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
								TriggerServerEvent('esx_biayyyzenlling:sendBill', GetPlayerServerId(closestPlayer), 'society_unicorn', 'unicorn', amount)
							end
						end
					end,
				function(data, menu)
					menu.close()
				end
				)
			end

			if data.current.value == 'announce_unicorn' then
			    messageunicornnotfinish = true
				MessageUnicorn()
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
	CreateJobBlipsUnicorn()
	CreateJobBlipsUnicorn2()
	CreateJobBlips2Unicorn()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	--DeleteJobBlipsUnicorn()
	--DeleteJobBlipsUnicorn2()
	CreateJobBlipsUnicorn()
	CreateJobBlipsUnicorn2()
    --DeleteJobBlips2Unicorn()
    CreateJobBlips2Unicorn()
end)

function IsJobTrueUnicorn()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueUnicorn = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
		IsJobTrueUnicorn = true
	  end
	  return IsJobTrueUnicorn
	end
end
  
function CreateJobBlipsUnicorn()
	if IsJobTrueUnicorn() then               
	local blip = AddBlipForCoord(ConfigJob.Zones8.HarvestUnicorn.Pos.x, ConfigJob.Zones8.HarvestUnicorn.Pos.y, ConfigJob.Zones8.HarvestUnicorn.Pos.z)
		SetBlipSprite(blip, 478)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Récolte houblon")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsUnicorn, blip) 
	end 
end

function CreateJobBlipsUnicorn2()
	if IsJobTrueUnicorn() then               
	local blip = AddBlipForCoord(ConfigJob.Zones8.HarvestUnicorn2.Pos.x, ConfigJob.Zones8.HarvestUnicorn2.Pos.y, ConfigJob.Zones8.HarvestUnicorn2.Pos.z)
		SetBlipSprite(blip, 478)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Récolte Malt")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsUnicorn2, blip) 
	end 
end

function DeleteJobBlipsUnicorn()
	if JobBlipsUnicorn[1] ~= nil then
		for i=1, #JobBlipsUnicorn, 1 do
			RemoveBlip(JobBlipsUnicorn[i])
			JobBlipsUnicorn[i] = nil
		end
	end
end

function DeleteJobBlipsUnicorn2()
	if JobBlipsUnicorn2[1] ~= nil then
		for i=1, #JobBlipsUnicorn2, 1 do
			RemoveBlip(JobBlipsUnicorn2[i])
			JobBlipsUnicorn2[i] = nil
		end
	end
end

function IsJobTrue2Unicorn()
  if ESX.PlayerData ~= nil then
    local IsJobTrue2Unicorn = false
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
      IsJobTrue2Unicorn = true
    end
    return IsJobTrue2Unicorn
  end
end

function CreateJobBlips2Unicorn()
	if IsJobTrue2Unicorn() then               
	local blip2 = AddBlipForCoord(ConfigJob.Zones8.UnicornCraft.Pos.x, ConfigJob.Zones8.UnicornCraft.Pos.y, ConfigJob.Zones8.UnicornCraft.Pos.z)
		SetBlipSprite(blip2, 478)
		SetBlipDisplay(blip2, 4)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 0)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Distillerie")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips2Unicorn, blip2)
	end 
end

function DeleteJobBlips2Unicorn()
	if JobBlips2Unicorn[1] ~= nil then
		for i=1, #JobBlips2Unicorn, 1 do
			RemoveBlip(JobBlips2Unicorn[i])
			JobBlips2Unicorn[i] = nil
		end
	end
end

AddEventHandler('nwx_unicorn:hasEnteredMarkerUnicorn', function(zone)

	if zone == 'UnicornActions' then
		CurrentAction = 'unicorn_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'HarvestUnicorn' then
		CurrentAction = 'unicorn_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'HarvestUnicorn2' then
		CurrentAction = 'unicorn_harvest_menu2'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'UnicornCraft' then
		CurrentAction = 'unicorn_craft_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'VehicleSpawnUnicornMenu' then
		CurrentAction = 'unicorn_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleUnicornDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_unicorn_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	elseif zone == 'BossActionsUnicorn' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_unicorn_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu patron.'
		CurrentActionData = {}
	end

end)

AddEventHandler('nwx_unicorn:hasExitedMarkerUnicorn', function(zone)

	if zone == 'UnicornCraft' then
		TriggerServerEvent('nwx_unicorn:stopCraftUnicorn')
		TriggerServerEvent('nwx_unicorn:stopCraftUnicorn2')
		TriggerServerEvent('nwx_unicorn:stopCraftUnicorn3')
		TriggerServerEvent('nwx_unicorn:stopCraftUnicorn4')
	elseif zone == 'HarvestUnicorn' then
		TriggerServerEvent('nwx_unicorn:stopHarvestUnicorn')
	elseif zone == 'HarvestUnicorn2' then
		TriggerServerEvent('nwx_unicorn:stopHarvestUnicorn2')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones8) do
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
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones8) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_unicorn:hasEnteredMarkerUnicorn', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_unicorn:hasExitedMarkerUnicorn', LastZone)
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
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then

                if CurrentAction == 'unicorn_actions_menu' then
                	OpenUnicornActionsMenu()
                elseif CurrentAction == 'unicorn_harvest_menu' then
					OpenUnicornHarvestMenu()
				elseif CurrentAction == 'unicorn_harvest_menu2' then
                	OpenUnicornHarvestMenu2()
				elseif CurrentAction == 'boss_unicorn_actions_menu' then
                	OpenBossUnicornActionsMenu()
                elseif CurrentAction == 'unicorn_craft_menu' then
					OpenUnicornCraftMenu()
                elseif CurrentAction == 'unicorn_vehicles_menu' then
                	OpenUnicornVehiclesMenu()
                elseif CurrentAction == 'delete_unicorn_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('burrito3') or
					hash == GetHashKey('brioso') or
					hash == GetHashKey('cognoscenti') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'unicorn')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules de L\'Unicorn~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end

        if IsControlJustReleased(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
            OpenMobileUnicornActionsMenu()
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
						
		if (afficheunicornnews == true) then
			DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
			DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Unicorn ~d~", 255, 255, 255, 255, 1, 0)
			DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteunicornafiche, 255, 255, 255, 255, 7, 0)
			DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
		end                
	end
end)



RegisterNetEvent('nwx_unicorn:annonceUnicorn')
AddEventHandler('nwx_unicorn:annonceUnicorn', function(text)
	texteunicornafiche = text
	afficheunicornnews = true	
end) 


RegisterNetEvent('nwx_unicorn:annoncestopUnicorn')
AddEventHandler('nwx_unicorn:annoncestopUnicorn', function()
	afficheunicornnews = false	
end) 


function OpenBossUnicornActionsMenu()

	local elements = {
		{label = '---------------', value = nil},
		{label = 'Action Patron', value = 'boss_unicorn_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_unicorn',
		{
			css = 'unicorn',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_unicorn_actions' then
				TriggerEvent('esx_society:openBosayyyzensMenu', 'unicorn', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_unicorn_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

-- TELEPORTERS
AddEventHandler('esx_unicorn:teleportMarkersUnicorn', function(position)
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
  
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unicorn' then
		local coords = GetEntityCoords(GetPlayerPed(-1))
  
		for k,v in pairs(ConfigJob.TeleportZonesUnicorn) do
		  if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ConfigJob.DrawDistance) then
			DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
		  end
		end
  
	  end
  
	end
  end)
  
  -- Activate teleport marker
  Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  local coords = GetEntityCoords(GetPlayerPed(-1))
	  local position = nil
	  local zone = nil
  
	  if  ESX.PlayerData.job ~= nil and  ESX.PlayerData.job.name == 'unicorn' then
  
		for k,v in pairs(ConfigJob.TeleportZonesUnicorn) do
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
		  TriggerEvent('esx_unicorn:teleportMarkersUnicorn', position)
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
  
	  end
  
	end
  end)