local WorkerChillPos = {
    ped1 = {
        pos = vector3(-557.8373, 5362.547, 69.21445),
        Heading = 11.653322219849,
    },
    ped2 = {
        pos = vector3(-556.9439, 5364.371, 69.24194),
        Heading = 156.03028869629,
    },
}

Citizen.CreateThread(function()
    LoadModel("s_m_y_construct_01")
    local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), zones.bucheron, 289.134, 0, 0)
    FreezeEntityPosition(ped, 1)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    SetEntityInvincible(ped, true)
    SetEntityAsMissionEntity(ped, 1, 1)
    SetBlockingOfNonTemporaryEvents(ped, 1)

    for _,v in pairs(WorkerChillPos) do
        local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), v.pos, v.Heading, 0, 0)
        FreezeEntityPosition(ped, 1)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_COFFEE", 0, true)
        SetEntityInvincible(ped, true)
        SetEntityAsMissionEntity(ped, 1, 1)
        SetBlockingOfNonTemporaryEvents(ped, 1)
    end
end)

RMenu.Add('bucheron', 'main', RageUI.CreateMenu("Bucheron", " "))
RMenu:Get('bucheron', 'main'):SetSubtitle("~b~Chef de la Scierie")

local vehicle = nil
RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zones.bucheron, true)
    if distance <= 2.2 then
        alert("Appuyer sur ~b~E~w~ pour parler avec la personne.")
        if IsControlJustPressed(1, 51) and distance <= 3.0 then
            RageUI.Visible(RMenu:Get('bucheron', 'main'), not RageUI.Visible(RMenu:Get('bucheron', 'main')))
            CreateCamera()
        end
    end
    if RageUI.Visible(RMenu:Get('bucheron', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            if not InWork then
                RageUI.Button("Demander Un Travail à la Scierie", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "Alors comme ça tu veux bosser pour les ~g~Bucherons~w~ hein ? Très bien, met un casque et prends tees outils ! Si tu es faible , dis le moi tout de suite !",
                        })
                        InWork = true
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            local clothesSkin = {
                                ['bags_1'] = 0, ['bags_2'] = 0,
                                ['tshirt_1'] = 89, ['tshirt_2'] = 0,
                                ['torso_1'] = 73, ['torso_2'] = 0,
                                ['arms'] = 0,
                                ['pants_1'] = 98, ['pants_2'] = 1,
                                ['shoes_1'] = 24, ['shoes_2'] = 0,
                                ['mask_1'] = 0, ['mask_2'] = 0,
                                ['bproof_1'] = 3, ['bproof_2'] = 1,
                                ['helmet_1'] = 60, ['helmet_2'] = 4,
                            }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        end)
                        DebutTravail("bucheron")
                    end
                end)
            else
                RageUI.Button("Arreter De Travailler", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "Ah ! Tu stop déja ? je savais que tu étais Faible , tiens prend ta paye",
                        })
                        InWork = false
                        FinTravail()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local isMale = skin.sex == 0
                            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)
                            end)
                        end)
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end
end, 1)