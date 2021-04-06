function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function ShowNotification(msg)
	AddTextEntry('esxNotification', msg)
	SetNotificationTextEntry('esxNotification')
	DrawNotification(false, true)
end

function ShowAdvancedNotification(title, subject, msg, icon, iconType)
	AddTextEntry('esxAdvancedNotification', msg)
	SetNotificationTextEntry('esxAdvancedNotification')
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(10)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
		blockinput = false
        return result
    else
        Citizen.Wait(500)
		blockinput = false
        return nil
    end
end

NpcConfig = {
    { model = "s_m_m_security_01", pos = { x = -246.6787, y = -339.6397, z =29.3 }, heading = 1.0, name = "" },
    { model = "a_f_y_business_01", pos = { x = -268.93, y = -956.245, z = 31.3 }, heading = 214.91, name = "" },
}

Citizen.CreateThread(function()
    for i = 1, #NpcConfig, 1 do
        ped55 = NpcConfig[i].model
        LoadModel(ped55)
        while not HasModelLoaded(ped55) do
            Wait(1)
        end

        pedcs = CreatePed(2, ped55, NpcConfig[i].pos.x, NpcConfig[i].pos.y, NpcConfig[i].pos.z - 1, NpcConfig[i].heading, false, true)
        SetBlockingOfNonTemporaryEvents(pedcs, true)
        TaskStartScenarioInPlace(pedcs, "WORLD_HUMAN_CLIPBOARD", 0, false)
        SetEntityInvincible(pedcs, true)
        FreezeEntityPosition(pedcs, true)
        SetEntityAsMissionEntity(pedcs, true)


    end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		
        for i = 1, #v.Superettes, 1 do
            local blip = AddBlipForCoord(v.Superettes[i].x, v.Superettes[i].y, v.Superettes[i].z)

            SetBlipSprite(blip, 52)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Superette')
            EndTextCommandSetBlipName(blip)
		end

		for i = 1, #v.Armureries, 1 do
            local blip = AddBlipForCoord(v.Armureries[i].x, v.Armureries[i].y, v.Armureries[i].z)

            SetBlipSprite(blip, 110)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Armurerie')
            EndTextCommandSetBlipName(blip)
		end
		
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
		
		--[[ for i = 1, #v.Banques, 1 do
            local blip = AddBlipForCoord(v.Banques[i].x, v.Banques[i].y, v.Banques[i].z)

            SetBlipSprite (blip, 207)
            SetBlipScale  (blip, 0.5)
            SetBlipColour (blip, 2)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Banques')
            EndTextCommandSetBlipName(blip)
		end ]]
		
		for i = 1, #v.Emplois, 1 do
            local blip = AddBlipForCoord(v.Emplois[i].x ,v.Emplois[i].y, v.Emplois[i].z)
            SetBlipSprite(blip, 407)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 27)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Centre d'Interim")
            EndTextCommandSetBlipName(blip)
		end

		for i = 1, #v.AutoEcole, 1 do
            local blip = AddBlipForCoord(v.AutoEcole[i].x ,v.AutoEcole[i].y, v.AutoEcole[i].z)
            SetBlipSprite(blip, 408)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 5)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Centre de Conduite")
            EndTextCommandSetBlipName(blip)
		end

		--[[for i = 1, #v.Garages, 1 do
            local blip = AddBlipForCoord(v.Garages[i].x ,v.Garages[i].y, v.Garages[i].z)
            SetBlipSprite(blip, 290)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 38)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Garages")
            EndTextCommandSetBlipName(blip)
		end

		for i = 1, #v.Fourrieres, 1 do
            local blip = AddBlipForCoord(v.Fourrieres[i].x ,v.Fourrieres[i].y, v.Fourrieres[i].z)
            SetBlipSprite(blip, 67)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.7)
            SetBlipColour(blip, 64)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Fourrières")
            EndTextCommandSetBlipName(blip)
		end ]]
		
    end
end)