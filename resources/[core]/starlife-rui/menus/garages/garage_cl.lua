local this_Garage = {}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

for k,v in pairs(Config.CarGarages) do
    for i = 1, #v.GaragePoint, 1 do
        zoneped = vector3(v.GaragePoint[i].x, v.GaragePoint[i].y, v.GaragePoint[i].z)
        pedHash = "s_m_m_security_01"
        Heading = 162.36462402344
        Ped = nil
    end
end

Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zoneped, Heading, 0, 0)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, "WORLD_HUMAN_CLIPBOARD", 0, false)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end)

RMenu.Add('showcase', 'garage', RageUI.CreateMenu("Mon Garage", "Mon Garage"))
RMenu.Add('showcase', 'fourriere', RageUI.CreateMenu("Ma Fourrière", "Ma Fourrière"))

Citizen.CreateThread(function()
    while true do

        for k,v in pairs(Config.CarGarages) do
            for i = 1, #v.GaragePoint, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.GaragePoint[i].x, v.GaragePoint[i].y, v.GaragePoint[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~y~[E] pour ouvrir votre Garage')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('showcase', 'garage'), not RageUI.Visible(RMenu:Get('showcase', 'garage')))
                    end
                end
            end

            for i = 1, #v.DeletePoint, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.DeletePoint[i].x, v.DeletePoint[i].y, v.DeletePoint[i].z, true)
                if distance < 10.0 then
                    DrawMarker(26, v.DeletePoint[i].x, v.DeletePoint[i].y, v.DeletePoint[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 0, 0, 120, 0, 0, 2, 0, nil, nil, 0)
                    if distance < 2.2 then
                        alert('Appuyez sur ~y~[E] pour Ranger votre Véhicule')
                        if IsControlJustPressed(1,51) then  -- 51 = E
                            StoreOwnedCarsMenu()
                        end
                    end
                end
            end

            for i = 1, #v.PoundPoint, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.PoundPoint[i].x, v.PoundPoint[i].y, v.PoundPoint[i].z, true)
                if distance < 10.0 then
                    DrawMarker(26, v.PoundPoint[i].x, v.PoundPoint[i].y, v.PoundPoint[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 0, 0, 120, 0, 0, 2, 0, nil, nil, 0)
                    if distance < 2.2 then
                        alert('Appuyez sur ~y~[E] pour accéder à la Fourrière')
                        if IsControlJustPressed(1,51) then  -- 51 = E
                            RageUI.Visible(RMenu:Get('showcase', 'fourriere'), not RageUI.Visible(RMenu:Get('showcase', 'fourriere')))
                        end
                    end
                end
            end
        end

        if RageUI.Visible(RMenu:Get('showcase', 'garage')) then

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()                   
                ESX.TriggerServerCallback('ayzn:getVehicles', function(ownedCars)
                    if #ownedCars == 0 then
                        RageUI.Button("Aucun véhicule", nil, {}, true, function(Hovered, Active, Selected)
                        end)
                    else
                        for _,v in pairs(ownedCars) do
                            local hashVehicule = v.vehicle.model
					        local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
					        local plate        = v.plate
                            local labelvehicle = '| '..plate..' | '..vehicleName..' |'


                            RageUI.Button(labelvehicle, nil, {}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if v.stored then
                                        SpawnVehicle(v.vehicle, v.plate)
                                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                        ShowAdvancedNotification("Garage", "~b~Mon Garage", "Votre Véhicule est Sorti !\nPlaque: ~g~"..v.plate, "CHAR_PEGASUS_DELIVERY", 8)
                                    else
                                        ShowAdvancedNotification("Garage", "~b~Mon Garage", "Votre Véhicule ne se trouve pas ici !\nAllez Voir à la Fourrière !", "CHAR_PEGASUS_DELIVERY", 8)
                                        PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                    end

                                    local blip = AddBlipForEntity(v.vehicle)
                                    SetBlipSprite(blip, 326)
                                    SetBlipDisplay(blip, 2)
                                    SetBlipScale(blip, 0.4)
                                    SetBlipColour(blip, 2)
                                    SetBlipCategory(blip, 11)
                                    SetBlipAsShortRange(blip, true)
                                    BeginTextCommandSetBlipName('STRING')
                                    AddTextComponentString("~g~"..vehicleName)
                                    EndTextCommandSetBlipName(blip)
                                end
                            end)
                        end
                    end
                
                
                
                
                end)


            end, function()
            end)

        end

        if RageUI.Visible(RMenu:Get('showcase', 'fourriere')) then

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
                ESX.TriggerServerCallback('ayzn:getOutOwnedCars', function(ownedCars)
                    for _,v in pairs(ownedCars) do
                        local hashVehicule = v.model
                        local vehicleName  = GetDisplayNameFromVehicleModel(hashVehicule)
                        local plate        = v.plate
                        local labelvehicle
            
                        labelvehicle = plate..' | '..vehicleName
            
                        RageUI.Button(labelvehicle, nil, { RightLabel = "~y~Récuperer"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                ESX.TriggerServerCallback('ayzn:checkMoneyCars', function(hasEnoughMoney)
                                    if hasEnoughMoney then
                                        TriggerServerEvent('ayzn:payCar')
                                        SpawnPoundedVehicle(v.vehicle, v.plate)
                                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                        ShowAdvancedNotification("Fourrière", "~b~Ma Fourrière", "Votre Véhicule est Sorti !\nFaites Attention la prochaine fois !", "CHAR_PEGASUS_DELIVERY", 8)
                                    else
                                        ShowAdvancedNotification("Fourrière", "~b~Ma Fourrière", "Vous n'avez pas assez d'Argent\nAllez en retirer !", "CHAR_PEGASUS_DELIVERY", 8)
                                        PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                    end
                                end)
                            end
                        end)
                    end
                end)          
            end, function()
            end)

        end

        Citizen.Wait(5)

    end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local playerPed  = PlayerPedId()
        local coords     = GetEntityCoords(playerPed)
        
		for k,v in pairs(Config.CarGarages) do
			if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < 3.0) then
				this_Garage = v
			end

			if(GetDistanceBetweenCoords(coords, v.DeletePoint.x, v.DeletePoint.y, v.DeletePoint.z, true) < 3.0) then
				this_Garage = v
			end

			if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < 3.0) then
				this_Garage = v
            end
		end
	end
end)

function SpawnVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPoint.x,
		y = this_Garage.SpawnPoint.y,
		z = this_Garage.SpawnPoint.z + 1
	}, this_Garage.SpawnPoint.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    
    local NotNear = true
    while NotNear do
        Citizen.Wait(1)
        local pVehC = GetEntityCoords(vehicle)
        local pCoords = GetEntityCoords(GetPlayerPed(-1))
        local dst = GetDistanceBetweenCoords(pVehC, pCoords, true)
        if dst >= 3.0 then
            DrawMarker(0, pVehC.x, pVehC.y, pVehC.z+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 245, 224, 0, 220, 1, 0, 2, 0, nil, nil, 0)
        else
            NotNear = false
        end
    end

	TriggerServerEvent('ayzn:setVehicleState', plate, false)
end

function SpawnPoundedVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPoint.x,
		y = this_Garage.SpawnPoint.y,
		z = this_Garage.SpawnPoint.z + 1
	}, this_Garage.SpawnPoint.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		--SetVehicleEngineHealth(callback_vehicle, 1000) -- Might not be needed
		--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)

    local NotNear = true
    while NotNear do
        Citizen.Wait(1)
        local pVehC = GetEntityCoords(vehicle)
        local pCoords = GetEntityCoords(GetPlayerPed(-1))
        local dst = GetDistanceBetweenCoords(pVehC, pCoords, true)
        if dst >= 3.0 then
            DrawMarker(0, pVehC.x, pVehC.y, pVehC.z+0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 245, 224, 0, 220, 1, 0, 2, 0, nil, nil, 0)
        else
            NotNear = false
        end
    end
    
	TriggerServerEvent('ayzn:setVehicleState', plate, false)
end

function StoreOwnedCarsMenu()
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed    = GetPlayerPed(-1)
		local coords       = GetEntityCoords(playerPed)
		local vehicle      = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local plate        = vehicleProps.plate

		ESX.TriggerServerCallback('ayzn:storeVehicle', function(valid)
			if valid then
				ESX.Game.DeleteVehicle(vehicle)
	            TriggerServerEvent('ayzn:setVehicleState', vehicleProps.plate, true)
                ShowAdvancedNotification("Garage", "~b~Mon Garage", "Votre Véhicule est Rentré !\nPlaque: ~g~"..plate, "CHAR_PEGASUS_DELIVERY", 8)
                PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
			else
                ShowAdvancedNotification("Garage", "~b~Mon Garage", "Ce n'est pas votre Véhicule !\nJ'appelle la police...", "CHAR_PEGASUS_DELIVERY", 8)
                PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
			end
		end, vehicleProps)
	else
        ShowAdvancedNotification("Garage", "~b~Mon Garage", "Vous devez être dans un Véhicule !", "CHAR_PEGASUS_DELIVERY", 8)
        PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
	end
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

RegisterCommand("garage", function()
	RageUI.Visible(RMenu:Get('showcase', 'garage'), not RageUI.Visible(RMenu:Get('showcase', 'garage')))
end)