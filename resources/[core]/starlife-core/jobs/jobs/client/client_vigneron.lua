local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsVigneron = {}
local JobBlipsVigneron = {}
local JobBlipsVigneron2 = {}
local Blips2Vigneron = {}
local JobBlips2Vigneron = {}


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
	CreateJobBlipsVigneron()
	CreateJobBlipsVigneron2()
	CreateJobBlips2Vigneron()
end)

function MessageVigneron()
	Citizen.CreateThread(function()
    while messagevigneronnotfinish do
    		Citizen.Wait(10)
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messagevigneronnotfinish = false
		        TriggerServerEvent('nwx_vigneron:annonceVigneron',result)   
		    end


		end
	end)
end

function OpenVigneronActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_vigneron'},
		{label = 'Tenue civile', value = 'cloakroom2_vigneron'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vigneron_actions',
		{
			css = 'vigneron',
			title = 'Vigneron',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_vigneron' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2_vigneron' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end


		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'vigneron_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenVigneronVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_vigneron_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vigneron_vehicles',
		{
			css = 'vigneron',
			title = 'Vigneron',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_vigneron_list' then
				local elements = {
					{label = 'Bison', value = 'bison3'}
				}

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = 'Jackal Ocelot', value = 'jackal'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_vigneron_vehicle',
					{
						css = 'vigneron',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones7.VehicleSpawnVigneronPoint.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 257.03, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "VIGN" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones7.VehicleSpawnVigneronPoint.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 257.03, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "VIGN" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'vigneron')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenVigneronVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'vigneron_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenVigneronHarvestMenu()

	local elements = {
		{label = 'Raisin', value = 'harvest_vigneron'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vigneron_harvest',
		{
			css = 'vigneron',
			title = 'Ramasser du Raisin',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_vigneron' then
				menu.close()
				TriggerServerEvent('nwx_vigneron:startHarvestVigneron')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'vigneron_harvest_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenVigneronCraftMenu()

	local elements = {
		{label = 'Jus de raisin', value = 'craft_jusraisin'},
		{label = 'Vin', value = 'craft_vin'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vigneron_craft',
		{
			css = 'vigneron',
			title = 'Distillation',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_jusraisin' then
				menu.close()
				TriggerServerEvent('nwx_vigneron:startCraftVigneron')
			elseif data.current.value == 'craft_vin' then
				menu.close()
				TriggerServerEvent('nwx_vigneron:startCraftVigneron2')
			end
			

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'vigneron_craft_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenMobileVigneronActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_vigneron_actions',
		{
			css = 'vigneron',
			title = 'Vigneron',
			elements = {
				{label = 'Facturation',    value = 'billing_vigneron'},
				{label = '----------------------------', value = nil},
				{label = 'Passer une annonce', value = 'announce_vigneron'},
			}
		},
		function(data, menu)

			if data.current.value == 'billing_vigneron' then
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'vigneron_billing',
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
								TriggerServerEvent('esx_biayyyzenlling:sendBill', GetPlayerServerId(closestPlayer), 'society_vigneron', 'vigneron', amount)
							end
						end
					end,
				function(data, menu)
					menu.close()
				end
				)
			end

			if data.current.value == 'announce_vigneron' then
			    messagevigneronnotfinish = true
				MessageVigneron()
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
	CreateJobBlipsVigneron()
	CreateJobBlipsVigneron2()
	CreateJobBlips2Vigneron()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	--DeleteJobBlipsVigneron()
	--DeleteJobBlipsVigneron2()
	CreateJobBlipsVigneron()
	CreateJobBlipsVigneron2()
    --DeleteJobBlips2Vigneron()
    CreateJobBlips2Vigneron()
end)

function IsJobTrueVigneron()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueVigneron = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'vigneron' then
		IsJobTrueVigneron = true
	  end
	  return IsJobTrueVigneron
	end
end
  
function CreateJobBlipsVigneron()
	if IsJobTrueVigneron() then               
	local blip = AddBlipForCoord(ConfigJob.Zones7.VigneronSellFarm.Pos.x, ConfigJob.Zones7.VigneronSellFarm.Pos.y, ConfigJob.Zones7.VigneronSellFarm.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente de jus raisin")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsVigneron, blip) 
	end 
end

function CreateJobBlipsVigneron2()
	if IsJobTrueVigneron() then               
	local blip = AddBlipForCoord(ConfigJob.Zones7.VigneronSellFarm2.Pos.x, ConfigJob.Zones7.VigneronSellFarm2.Pos.y, ConfigJob.Zones7.VigneronSellFarm2.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente de vin")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsVigneron2, blip) 
	end 
end

function DeleteJobBlipsVigneron()
	if JobBlipsVigneron[1] ~= nil then
		for i=1, #JobBlipsVigneron, 1 do
			RemoveBlip(JobBlipsVigneron[i])
			JobBlipsVigneron[i] = nil
		end
	end
end

function DeleteJobBlipsVigneron2()
	if JobBlipsVigneron2[1] ~= nil then
		for i=1, #JobBlipsVigneron2, 1 do
			RemoveBlip(JobBlipsVigneron2[i])
			JobBlipsVigneron2[i] = nil
		end
	end
end

function IsJobTrue2Vigneron()
  if ESX.PlayerData ~= nil then
    local IsJobTrue2Vigneron = false
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'vigneron' then
      IsJobTrue2Vigneron = true
    end
    return IsJobTrue2Vigneron
  end
end

function CreateJobBlips2Vigneron()
	if IsJobTrue2Vigneron() then               
	local blip2 = AddBlipForCoord(ConfigJob.Zones7.VigneronCraft.Pos.x, ConfigJob.Zones7.VigneronCraft.Pos.y, ConfigJob.Zones7.VigneronCraft.Pos.z)
		SetBlipSprite(blip2, 478)
		SetBlipDisplay(blip2, 4)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 0)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Distillerie")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips2Vigneron, blip2)
	end 
end

function DeleteJobBlips2Vigneron()
	if JobBlips2Vigneron[1] ~= nil then
		for i=1, #JobBlips2Vigneron, 1 do
			RemoveBlip(JobBlips2Vigneron[i])
			JobBlips2Vigneron[i] = nil
		end
	end
end

AddEventHandler('nwx_vigneron:hasEnteredMarkerVigneron', function(zone)

	if zone == 'VigneronActions' then
		CurrentAction = 'vigneron_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'HarvestVigneron' then
		CurrentAction = 'vigneron_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'HarvestVigneron2' then
		CurrentAction = 'vigneron_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'VigneronCraft' then
		CurrentAction = 'vigneron_craft_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'VigneronSellFarm' then
		CurrentAction = 'vigneron_sell_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'VigneronSellFarm2' then
		CurrentAction = 'vigneron_sell_menu2'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'VehicleSpawnVigneronMenu' then
		CurrentAction = 'vigneron_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleVigneronDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_vigneron_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	elseif zone == 'BossActionsVigneron' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_vigneron_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu patron.'
		CurrentActionData = {}
	end

end)

AddEventHandler('nwx_vigneron:hasExitedMarkerVigneron', function(zone)

	if zone == 'VigneronCraft' then
		TriggerServerEvent('nwx_vigneron:stopCraftVigneron')
		TriggerServerEvent('nwx_vigneron:stopCraftVigneron2')
	elseif zone == 'HarvestVigneron' then
		TriggerServerEvent('nwx_vigneron:stopHarvestVigneron')
	elseif zone == 'HarvestVigneron2' then
		TriggerServerEvent('nwx_vigneron:stopHarvestVigneron')
	elseif zone == 'VigneronSellFarm' then
		TriggerServerEvent('nwx_vigneron:stopSellVigneron')
	elseif zone == 'VigneronSellFarm2' then
		TriggerServerEvent('nwx_vigneron:stopSellVigneron2')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'vigneron' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones7) do
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
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'vigneron' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones7) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 2.5) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_vigneron:hasEnteredMarkerVigneron', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_vigneron:hasExitedMarkerVigneron', LastZone)
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
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'vigneron' then

                if CurrentAction == 'vigneron_actions_menu' then
                	OpenVigneronActionsMenu()
                elseif CurrentAction == 'vigneron_harvest_menu' then
                	OpenVigneronHarvestMenu()
				elseif CurrentAction == 'boss_vigneron_actions_menu' then
                	OpenBossVigneronActionsMenu()
                elseif CurrentAction == 'vigneron_craft_menu' then
					OpenVigneronCraftMenu()
				elseif CurrentAction == 'vigneron_sell_menu' then
					TriggerServerEvent('nwx_vigneron:startSellVigneron', CurrentActionData.zone)
				elseif CurrentAction == 'vigneron_sell_menu2' then
                	TriggerServerEvent('nwx_vigneron:startSellVigneron2', CurrentActionData.zone)
                elseif CurrentAction == 'vigneron_vehicles_menu' then
                	OpenVigneronVehiclesMenu()
                elseif CurrentAction == 'delete_vigneron_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('bison3') or
					hash == GetHashKey('jackal') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'vigneron')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules Vigneron~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end

        if IsControlJustReleased(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'vigneron' then
            OpenMobileVigneronActionsMenu()
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
						
		if (affichevigneronnews == true) then
			DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
			DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Vigneron ~d~", 255, 255, 255, 255, 1, 0)
			DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, textevigneronafiche, 255, 255, 255, 255, 7, 0)
			DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
		end                
	end
end)



RegisterNetEvent('nwx_vigneron:annonceVigneron')
AddEventHandler('nwx_vigneron:annonceVigneron', function(text)
	textevigneronafiche = text
	affichevigneronnews = true	
end) 


RegisterNetEvent('nwx_vigneron:annoncestopVigneron')
AddEventHandler('nwx_vigneron:annoncestopVigneron', function()
	affichevigneronnews = false	
end) 


function OpenBossVigneronActionsMenu()

	local elements = {
		{label = '---------------', value = nil},
		{label = 'Action Patron', value = 'boss_vigneron_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_vigneron',
		{
			css = 'vigneron',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_vigneron_actions' then
				TriggerEvent('esx_society:openBosayyyzensMenu', 'vigneron', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_vigneron_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end