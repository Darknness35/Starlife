--============== BLIPS SUPERETTE ==============--
Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Superettes, 1 do
            local blip = AddBlipForCoord(v.Superettes[i].x, v.Superettes[i].y, v.Superettes[i].z)

            SetBlipSprite (blip, 52)
            SetBlipScale  (blip, 0.8)
            SetBlipColour (blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Superette')
            EndTextCommandSetBlipName(blip)
         end
     end
end)

--============== BLIPS ARMURERIE ==============--
Citizen.CreateThread(function()
    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Armureries, 1 do
            local blip = AddBlipForCoord(v.Armureries[i].x, v.Armureries[i].y, v.Armureries[i].z)

            SetBlipSprite (blip, 110)
            SetBlipScale  (blip, 0.8)
            SetBlipColour (blip, 1)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Armurerie')
            EndTextCommandSetBlipName(blip)
        end
    end
end)

--============== BLIPS LOCATIONS ==============--
Citizen.CreateThread(function()

    for k,v in pairs(Config.Zones) do
        for i = 1, #v.Locations, 1 do
            local blip = AddBlipForCoord(v.Locations[i].x ,v.Locations[i].y, v.Locations[i].z)
            SetBlipSprite(blip, 315)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Location Véhicule")
            EndTextCommandSetBlipName(blip)
        end
    end
end)