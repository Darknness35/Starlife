local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsDaymson = {}
local JobBlipsDaymson = {}
local Blips2Daymson = {}
local JobBlips2Daymson = {}
local Blips3Daymson = {}
local JobBlips3Daymson = {}


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
	CreateJobBlipsDaymson()
	CreateJobBlips2Daymson()
	CreateJobBlips3Daymson()
end)

function MessageDaymson()
	Citizen.CreateThread(function()
    while messagedaymsonnotfinish do
    		Citizen.Wait(10)
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messagedaymsonnotfinish = false
		        TriggerServerEvent('nwx_daymson:annonceDaymson',result)   
		    end


		end
	end)
end

function OpenDaymsonActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_daymson'},
		{label = 'Tenue civile', value = 'cloakroom2_daymson'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'daymson_actions',
		{
			css = 'daymson',
			title = 'Daymson',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_daymson' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2_daymson' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'daymson_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenDaymsonVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_daymson_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'daymson_vehicles',
		{
			css = 'daymson',
			title = 'Daymson',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_daymson_list' then
				local elements = {
					{label = 'Rumpo', value = 'rumpo'}
				}

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'manager' then
					table.insert(elements, {label = 'Toros', value = 'toros'})
				end

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'gerant'then
					table.insert(elements, {label = 'Toros', value = 'toros'})
					table.insert(elements, {label = 'Schafter v12', value = 'schafter3'})
					table.insert(elements, {label = 'Patriot', value = 'patriot'})
					table.insert(elements, {label = 'Limousine Patriot', value = 'patriot2'})
				end

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = 'Toros', value = 'toros'})
					table.insert(elements, {label = 'Schafter v12', value = 'schafter3'})
					table.insert(elements, {label = 'Patriot', value = 'patriot'})
					table.insert(elements, {label = 'Limousine Patriot', value = 'patriot2'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_daymson_vehicle',
					{
						css = 'daymson',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones5.VehicleSpawnDaymsonPoint.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 172.734, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "DAYM" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones5.VehicleSpawnDaymsonPoint.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 172.734, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "DAYM" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'daymson')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenDaymsonVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'daymson_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenDaymsonHarvestMenu()

	local elements = {
		{label = 'CD vierge', value = 'cdvierge'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'daymson_harvest',
		{
			css = 'daymson',
			title = 'Récupérer CD vierge',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'cdvierge' then
				menu.close()
				TriggerServerEvent('nwx_daymson:startHarvestDaymson')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'daymson_harvest_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenDaymsonCraftMenu()

	local elements = {
		{label = 'CD scellé', value = 'cdscelle'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'daymson_craft',
		{
			css = 'daymson',
			title = 'Assemblement',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'cdscelle' then
				menu.close()
				TriggerServerEvent('nwx_daymson:startCraftDaymson')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'daymson_craft_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la gravure des cd.'
			CurrentActionData = {}
		end
	)
end

function OpenMobileDaymsonActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_daymson_actions',
		{
			css = 'daymson',
			title = 'Daymson',
			elements = {
				{label = 'Facturation',    value = 'billing_daymson'},
				{label = '----------------------------', value = nil},
				{label = 'Passer une annonce', value = 'announce_daymson'},
			}
		},
		function(data, menu)

			if data.current.value == 'billing_daymson' then
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'daymson_billing',
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
								TriggerServerEvent('esx_biayyyzenlling:sendBill', GetPlayerServerId(closestPlayer), 'society_daymson', 'Daymson', amount)
							end
						end
					end,
				function(data, menu)
					menu.close()
				end
				)
			end

			if data.current.value == 'announce_daymson' then
			    messagedaymsonnotfinish = true
				MessageDaymson()
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
	CreateJobBlipsDaymson()
	CreateJobBlips2Daymson()
	CreateJobBlips3Daymson()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	--DeleteJobBlipsDaymson()
    CreateJobBlipsDaymson()
    --DeleteJobBlips2Daymson()
	CreateJobBlips2Daymson()
	CreateJobBlips3Daymson()
end)

function IsJobTrueDaymson()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueDaymson = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then
		IsJobTrueDaymson = true
	  end
	  return IsJobTrueDaymson
	end
end
  
function CreateJobBlipsDaymson()
	if IsJobTrueDaymson() then               
	local blip = AddBlipForCoord(ConfigJob.Zones5.DaymsonSellFarm.Pos.x, ConfigJob.Zones5.DaymsonSellFarm.Pos.y, ConfigJob.Zones5.DaymsonSellFarm.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente de CD")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsDaymson, blip) 
	end 
end

function DeleteJobBlipsDaymson()
	if JobBlipsDaymson[1] ~= nil then
		for i=1, #JobBlipsDaymson, 1 do
			RemoveBlip(JobBlipsDaymson[i])
			JobBlipsDaymson[i] = nil
		end
	end
end

function IsJobTrue2Daymson()
  if ESX.PlayerData ~= nil then
    local IsJobTrue2Daymson = false
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then
      IsJobTrue2Daymson = true
    end
    return IsJobTrue2Daymson
  end
end

function CreateJobBlips2Daymson()
	if IsJobTrue2Daymson() then               
	local blip2 = AddBlipForCoord(ConfigJob.Zones5.HarvestDaymson.Pos.x, ConfigJob.Zones5.HarvestDaymson.Pos.y, ConfigJob.Zones5.HarvestDaymson.Pos.z)
		SetBlipSprite(blip2, 614)
		SetBlipDisplay(blip2, 4)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 0)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Récolte de CD")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips2Daymson, blip2)
	end 
end

function DeleteJobBlips2Daymson()
	if JobBlips2Daymson[1] ~= nil then
		for i=1, #JobBlips2Daymson, 1 do
			RemoveBlip(JobBlips2Daymson[i])
			JobBlips2Daymson[i] = nil
		end
	end
end

function IsJobTrue3Daymson()
	if ESX.PlayerData ~= nil then
	  local IsJobTrue3Daymson = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then
		IsJobTrue3Daymson = true
	  end
	  return IsJobTrue3Daymson
	end
  end

function CreateJobBlips3Daymson()
	if IsJobTrue3Daymson() then               
	local blip3 = AddBlipForCoord(ConfigJob.Zones5.DaymsonCraft.Pos.x, ConfigJob.Zones5.DaymsonCraft.Pos.y, ConfigJob.Zones5.DaymsonCraft.Pos.z)
		SetBlipSprite(blip3, 614)
		SetBlipDisplay(blip3, 4)
		SetBlipScale(blip3, 0.7)
		SetBlipColour(blip3, 0)
		SetBlipAsShortRange(blip3, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Gravure de CD")
		EndTextCommandSetBlipName(blip3)
		table.insert(JobBlips3Daymson, blip3)
	end 
end

function DeleteJobBlips3Daymson()
	if JobBlips3Daymson[1] ~= nil then
		for i=1, #JobBlips3Daymson, 1 do
			RemoveBlip(JobBlips3Daymson[i])
			JobBlips3Daymson[i] = nil
		end
	end
end

AddEventHandler('nwx_daymson:hasEnteredMarkerDaymson', function(zone)

	if zone == 'DaymsonActions' then
		CurrentAction = 'daymson_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'HarvestDaymson' then
		CurrentAction = 'daymson_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'DaymsonCraft' then
		CurrentAction = 'daymson_craft_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au traitement.'
		CurrentActionData = {}
	elseif zone == 'DaymsonSellFarm' then
		CurrentAction = 'daymson_sell_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'VehicleSpawnDaymsonMenu' then
		CurrentAction = 'daymson_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleDaymsonDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_daymson_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	elseif zone == 'BossActionsDaymson' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_daymson_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu patron.'
		CurrentActionData = {}
	end

end)

AddEventHandler('nwx_daymson:hasExitedMarkerDaymson', function(zone)

	if zone == 'DaymsonCraft' then
		TriggerServerEvent('nwx_daymson:stopCraftDaymson')
	elseif zone == 'HarvestDaymson' then
		TriggerServerEvent('nwx_daymson:stopHarvestDaymson')
	elseif zone == 'DaymsonSellFarm' then
		TriggerServerEvent('nwx_daymson:stopSellDaymson')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones5) do
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
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones5) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_daymson:hasEnteredMarkerDaymson', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_daymson:hasExitedMarkerDaymson', LastZone)
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
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then

                if CurrentAction == 'daymson_actions_menu' then
                	OpenDaymsonActionsMenu()
                elseif CurrentAction == 'daymson_harvest_menu' then
                	OpenDaymsonHarvestMenu()
								elseif CurrentAction == 'boss_daymson_actions_menu' then
                	OpenBossDaymsonActionsMenu()
                elseif CurrentAction == 'daymson_craft_menu' then
                  	OpenDaymsonCraftMenu()
								elseif CurrentAction == 'daymson_sell_menu' then
                	TriggerServerEvent('nwx_daymson:startSellDaymson', CurrentActionData.zone)
                elseif CurrentAction == 'daymson_vehicles_menu' then
                	OpenDaymsonVehiclesMenu()
                elseif CurrentAction == 'delete_daymson_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    if hash == GetHashKey('rumpo') or hash == GetHashKey('patriot') or hash == GetHashKey('patriot2') or hash == GetHashKey('toros') or hash == GetHashKey('schafter3') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'daymson')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules Daymson Record~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end

        if IsControlJustReleased(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'daymson' then
            OpenMobileDaymsonActionsMenu()
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
						
		if (affichedaymsonnews == true) then
			DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
			DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Daymson Records~d~", 255, 255, 255, 255, 1, 0)
			DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, textedaymsonafiche, 255, 255, 255, 255, 7, 0)
			DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
		end                
	end
end)



RegisterNetEvent('nwx_daymson:annonceDaymson')
AddEventHandler('nwx_daymson:annonceDaymson', function(text)
	textedaymsonafiche = text
	affichedaymsonnews = true	
end) 


RegisterNetEvent('nwx_daymson:annoncestopDaymson')
AddEventHandler('nwx_daymson:annoncestopDaymson', function()
	affichedaymsonnews = false	
end) 


function OpenBossDaymsonActionsMenu()

	local elements = {
		{label = '---------------', value = nil},
		{label = 'Action Patron', value = 'boss_daymson_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_daymson',
		{
			css = 'daymson',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_daymson_actions' then
				TriggerEvent('esx_society:openBosayyyzensMenu', 'daymson', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_daymson_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end