RMenu.Add('rageui', 'location', RageUI.CreateMenu("Location Véhicule", "Location Véhicule"))
RMenu:Get('rageui', 'location').EnableMouse = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Locations, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour Louer un vehicule')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('rageui', 'location'), not RageUI.Visible(RMenu:Get('rageui', 'location')))
                    end
                end
            end
        end

        if RageUI.Visible(RMenu:Get('rageui', 'location')) then

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
                RageUI.Button("Blista", "Louer Une Voiture", { RightLabel = "3000$" }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:buycar',3000)
                        spawnCar("blista")
                        ShowNotification("Bonne Route !")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        Citizen.Wait(5000)
                        RageUI.CloseAll()
                    end
                end)
    
                RageUI.Button("Faggio", "Louer un Scooter", { RightLabel = "1500$" }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:buycar',1500)
                        spawnCar("faggio")
                        ShowNotification("Bonne Route !")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        Citizen.Wait(5000)
                        RageUI.CloseAll()
                    end
                end)
    
                RageUI.Button("BMX", "Louer Un Vélo", { RightLabel = "750$" }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:buycar',750)
                        spawnCar("bmx")
                        ShowNotification("Bonne Route !")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        Citizen.Wait(5000)
                        RageUI.CloseAll()
                    end
                end)
    
            end, function()
            end)
        end
    end
end)

spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(10)
    end

    local vehicle = CreateVehicle(car, -255.038, -339.3356, 28.801, 0.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LOCATION")

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
end