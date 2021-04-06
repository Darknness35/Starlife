local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local OnJob = false
local BlipsTabac = {}
local JobBlipsTabac = {}
local JobBlipsTabac2 = {}
local Blips2Tabac = {}
local JobBlips2Tabac = {}


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
	CreateJobBlipsTabac()
	CreateJobBlipsTabac2()
	CreateJobBlips2Tabac()
end)

function MessageTabac()
	Citizen.CreateThread(function()
    while messagetabacnotfinish do
    		Citizen.Wait(10)
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messagetabacnotfinish = false
		        TriggerServerEvent('nwx_tabac:annonceTabac',result)   
		    end


		end
	end)
end

function OpenTabacActionsMenu()

	local elements = {
		{label = 'Tenue de travail', value = 'cloakroom_tabac'},
		{label = 'Tenue civile', value = 'cloakroom2_tabac'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'tabac_actions',
		{
			css = 'malborose',
			title = 'Malborose',
			elements = elements
		},
		function(data, menu)
			if data.current.value == 'cloakroom_tabac' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				if skin.sex == 0 then
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
    				else
        				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
    				end
				end)
			end

			if data.current.value == 'cloakroom2_tabac' then
				menu.close()
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    				TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end


		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'tabac_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenTabacVehiclesMenu()

	local elements = {
		{label = 'Sortir Véhicule', value = 'vehicle_tabac_list'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'tabac_vehicles',
		{
			css = 'malborose',
			title = 'Malborose',
			elements = elements
		},
		function(data, menu)
			local grade = ESX.PlayerData.job.grade_name
			if data.current.value == 'vehicle_tabac_list' then
				local elements = {
					{label = 'Rumpo', value = 'rumpo2'}
				}

				if ConfigJob.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
					table.insert(elements, {label = 'Mesa', value = 'mesa'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'spawn_tabac_vehicle',
					{
						css = 'malborose',
						title = 'Véhicule de service',
						elements = elements
					},
					function(data, menu)
						for i=1, #elements, 1 do							
							if ConfigJob.MaxInService == -1 then
								local playerPed = GetPlayerPed(-1)
								local coords = ConfigJob.Zones6.VehicleSpawnTabacPoint.Pos
								local platenum = math.random(100, 900)
								ESX.Game.SpawnVehicle(data.current.value, coords, 252.94, function(vehicle)
									SetVehicleNumberPlateText(vehicle, "MLBS" .. platenum)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									local plate = GetVehicleNumberPlateText(vehicle)
									TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
								end)
								break
							else
								ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
									if canTakeService then
										local playerPed = GetPlayerPed(-1)
										local coords = ConfigJob.Zones6.VehicleSpawnTabacPoint.Pos
										ESX.Game.SpawnVehicle(data.current.value, coords, 252.94, function(vehicle)
											SetVehicleNumberPlateText(vehicle, "MLBS" .. platenum)
											TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
											local plate = GetVehicleNumberPlateText(vehicle)
											TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
										end)
									else
										ESX.ShowNotification('Service complet : ' .. inServiceCount .. '/' .. maxInService)
									end
								end, 'tabac')
								break
							end
						end						
						menu.close()
					end,
					function(data, menu)
						menu.close()
						OpenTabacVehiclesMenu()
					end
				)
			end	

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'tabac_vehicles_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
			CurrentActionData = {}
		end
	)
end

function OpenTabacHarvestMenu()

	local elements = {
		{label = 'Feuille de tabac', value = 'harvest_tabac'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'tabac_harvest',
		{
			css = 'malborose',
			title = 'Feuille de tabac',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'harvest_tabac' then
				menu.close()
				TriggerServerEvent('nwx_tabac:startHarvestTabac')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'tabac_harvest_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end

function OpenTabacCraftMenu()

	local elements = {
		{label = 'Séchage', value = 'craft_tabac'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'tabac_craft',
		{
			css = 'malborose',
			title = 'Séchage',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_tabac' then
				menu.close()
				TriggerServerEvent('nwx_tabac:startCraftTabac')
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'tabac_craft_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au séchage.'
			CurrentActionData = {}
		end
	)
end

function OpenTabacCraft2Menu()

	local elements = {
		{label = 'Assembler Malborose', value = 'craft_malbora'},
		{label = 'Assembler Cigar', value = 'craft_cigar'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'tabac_craft2',
		{
			css = 'malborose',
			title = 'Assemblement',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'craft_malbora' then
				menu.close()
				TriggerServerEvent('nwx_tabac:startCraftTabac2')
			elseif data.current.value == 'craft_cigar' then
				menu.close()
				TriggerServerEvent('nwx_tabac:startCraftTabac3')
			end
		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'tabac_craft_menu2'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a l\'assemblement.'
			CurrentActionData = {}
		end
	)
end

function OpenMobileTabacActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_tabac_actions',
		{
			css = 'malborose',
			title = 'Malborose',
			elements = {
				{label = 'Facturation',    value = 'billing_tabac'},
				{label = '----------------------------', value = nil},
				{label = 'Passer une annonce', value = 'announce_tabac'},
			}
		},
		function(data, menu)

			if data.current.value == 'billing_tabac' then
				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'tabac_billing',
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
								TriggerServerEvent('esx_biayyyzenlling:sendBill', GetPlayerServerId(closestPlayer), 'society_tabac', 'tabac', amount)
							end
						end
					end,
				function(data, menu)
					menu.close()
				end
				)
			end

			if data.current.value == 'announce_tabac' then
			    messagetabacnotfinish = true
				MessageTabac()
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
	CreateJobBlipsTabac()
	CreateJobBlipsTabac2()
	CreateJobBlips2Tabac()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	--DeleteJobBlipsTabac()
	--DeleteJobBlipsTabac2()
	CreateJobBlipsTabac()
	CreateJobBlipsTabac2()
    --DeleteJobBlips2Tabac()
    CreateJobBlips2Tabac()
end)

function IsJobTrueTabac()
	if ESX.PlayerData ~= nil then
	  local IsJobTrueTabac = false
	  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'tabac' then
		IsJobTrueTabac = true
	  end
	  return IsJobTrueTabac
	end
end
  
function CreateJobBlipsTabac()
	if IsJobTrueTabac() then               
	local blip = AddBlipForCoord(ConfigJob.Zones6.TabacSellFarm.Pos.x, ConfigJob.Zones6.TabacSellFarm.Pos.y, ConfigJob.Zones6.TabacSellFarm.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente de cigarette")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsTabac, blip) 
	end 
end

function CreateJobBlipsTabac2()
	if IsJobTrueTabac() then               
	local blip = AddBlipForCoord(ConfigJob.Zones6.TabacSellFarm2.Pos.x, ConfigJob.Zones6.TabacSellFarm2.Pos.y, ConfigJob.Zones6.TabacSellFarm2.Pos.z)
		SetBlipSprite(blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Vente de cigar")
		EndTextCommandSetBlipName(blip)
		table.insert(JobBlipsTabac2, blip) 
	end 
end

function DeleteJobBlipsTabac()
	if JobBlipsTabac[1] ~= nil then
		for i=1, #JobBlipsTabac, 1 do
			RemoveBlip(JobBlipsTabac[i])
			JobBlipsTabac[i] = nil
		end
	end
end

function DeleteJobBlipsTabac2()
	if JobBlipsTabac2[1] ~= nil then
		for i=1, #JobBlipsTabac2, 1 do
			RemoveBlip(JobBlipsTabac2[i])
			JobBlipsTabac2[i] = nil
		end
	end
end

function IsJobTrue2Tabac()
  if ESX.PlayerData ~= nil then
    local IsJobTrue2Tabac = false
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'tabac' then
      IsJobTrue2Tabac = true
    end
    return IsJobTrue2Tabac
  end
end

function CreateJobBlips2Tabac()
	if IsJobTrue2Tabac() then               
	local blip2 = AddBlipForCoord(ConfigJob.Zones6.HarvestTabac.Pos.x, ConfigJob.Zones6.HarvestTabac.Pos.y, ConfigJob.Zones6.HarvestTabac.Pos.z)
		SetBlipSprite(blip2, 478)
		SetBlipDisplay(blip2, 4)
		SetBlipScale(blip2, 0.7)
		SetBlipColour(blip2, 0)
		SetBlipAsShortRange(blip2, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Récolte de Tabac")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips2Tabac, blip2)
	end 
end

function DeleteJobBlips2Tabac()
	if JobBlips2Tabac[1] ~= nil then
		for i=1, #JobBlips2Tabac, 1 do
			RemoveBlip(JobBlips2Tabac[i])
			JobBlips2Tabac[i] = nil
		end
	end
end

AddEventHandler('nwx_tabac:hasEnteredMarkerTabac', function(zone)

	if zone == 'TabacActions' then
		CurrentAction = 'tabac_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
		CurrentActionData = {}
	elseif zone == 'HarvestTabac' then
		CurrentAction = 'tabac_harvest_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la récolte.'
		CurrentActionData = {}
	elseif zone == 'TabacCraft' then
		CurrentAction = 'tabac_craft_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au séchage.'
		CurrentActionData = {}
	elseif zone == 'TabacCraft2' then
		CurrentAction = 'tabac_craft_menu2'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a l\'assemblage.'
		CurrentActionData = {}
	elseif zone == 'TabacSellFarm' then
		CurrentAction = 'tabac_sell_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'TabacSellFarm2' then
		CurrentAction = 'tabac_sell_menu2'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder a la vente.'
		CurrentActionData = {zone = zone}
	elseif zone == 'VehicleSpawnTabacMenu' then
		CurrentAction = 'tabac_vehicles_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.'
		CurrentActionData = {}
	elseif zone == 'VehicleTabacDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction = 'delete_tabac_vehicle'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
			CurrentActionData = {}
		end
	elseif zone == 'BossActionsTabac' and ESX.PlayerData.job.grade_name == 'boss' then
		CurrentAction = 'boss_tabac_actions_menu'
		CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu patron.'
		CurrentActionData = {}
	end

end)

AddEventHandler('nwx_tabac:hasExitedMarkerTabac', function(zone)

	if zone == 'TabacCraft' then
		TriggerServerEvent('nwx_tabac:stopCraftTabac')
	elseif zone == 'TabacCraft2' then
		TriggerServerEvent('nwx_tabac:stopCraftTabac2')
		TriggerServerEvent('nwx_tabac:stopCraftTabac3')
	elseif zone == 'HarvestTabac' then
		TriggerServerEvent('nwx_tabac:stopHarvestTabac')
	elseif zone == 'TabacSellFarm' then
		TriggerServerEvent('nwx_tabac:stopSellTabac')
	elseif zone == 'TabacSellFarm2' then
		TriggerServerEvent('nwx_tabac:stopSellTabac2')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Display markers
Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(5)		
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'tabac' then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(ConfigJob.Zones6) do
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
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'tabac' then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(ConfigJob.Zones6) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.z) then
					isInMarker = true
					currentZone = k
				end
			end
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('nwx_tabac:hasEnteredMarkerTabac', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('nwx_tabac:hasExitedMarkerTabac', LastZone)
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
            if IsControlJustReleased(0, 38) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'tabac' then

                if CurrentAction == 'tabac_actions_menu' then
                	OpenTabacActionsMenu()
                elseif CurrentAction == 'tabac_harvest_menu' then
                	OpenTabacHarvestMenu()
				elseif CurrentAction == 'boss_tabac_actions_menu' then
                	OpenBossTabacActionsMenu()
                elseif CurrentAction == 'tabac_craft_menu' then
					OpenTabacCraftMenu()
				elseif CurrentAction == 'tabac_craft_menu2' then
					OpenTabacCraft2Menu()
				elseif CurrentAction == 'tabac_sell_menu' then
					TriggerServerEvent('nwx_tabac:startSellTabac', CurrentActionData.zone)
				elseif CurrentAction == 'tabac_sell_menu2' then
                	TriggerServerEvent('nwx_tabac:startSellTabac2', CurrentActionData.zone)
                elseif CurrentAction == 'tabac_vehicles_menu' then
                	OpenTabacVehiclesMenu()
                elseif CurrentAction == 'delete_tabac_vehicle' then
                    local playerPed = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(playerPed,  false)
                    local hash = GetEntityModel(vehicle)
                    local plate = GetVehicleNumberPlateText(vehicle)
					if hash == GetHashKey('rumpo2') or
						hash == GetHashKey('mesa') then
                        if ConfigJob.MaxInService ~= -1 then
                          TriggerServerEvent('esx_service:disableService', 'tabac')
                        end
                        DeleteVehicle(vehicle)
                        	TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
                    else
                        ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules du Malborose~s~.')
                    end
				end
                CurrentAction = nil               
            end
        end

        if IsControlJustReleased(0, 167) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'tabac' then
            OpenMobileTabacActionsMenu()
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
						
		if (affichetabacnews == true) then
			DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
			DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Malborose ~d~", 255, 255, 255, 255, 1, 0)
			DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, textetabacafiche, 255, 255, 255, 255, 7, 0)
			DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
		end                
	end
end)



RegisterNetEvent('nwx_tabac:annonceTabac')
AddEventHandler('nwx_tabac:annonceTabac', function(text)
	textetabacafiche = text
	affichetabacnews = true	
end) 


RegisterNetEvent('nwx_tabac:annoncestopTabac')
AddEventHandler('nwx_tabac:annoncestopTabac', function()
	affichetabacnews = false	
end) 


function OpenBossTabacActionsMenu()

	local elements = {
		{label = '---------------', value = nil},
		{label = 'Action Patron', value = 'boss_tabac_actions'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss_actions_tabac',
		{
			css = 'malborose',
			title = 'Boss',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'boss_tabac_actions' then
				TriggerEvent('esx_society:openBosayyyzensMenu', 'tabac', function(data, menu)
					menu.close()
				end)
			end

		end,
		function(data, menu)
			menu.close()
			CurrentAction = 'boss_tabac_actions_menu'
			CurrentActionMsg = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
			CurrentActionData = {}
		end
	)
end