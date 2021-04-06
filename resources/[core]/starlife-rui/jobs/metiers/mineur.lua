InWork = false

local WorkerChillPos = {
    ped1 = {
        pos = vector3(2577.666, 2728.977, 41.81851),
        Heading = 354.7380065918,
    },
    ped2 = {
        pos = vector3(2575.421, 2721.184, 41.81066),
        Heading = 126.40444946289,
    },
    ped3 = {
        pos = vector3(2572.699, 2720.55, 41.84818),
        Heading = 255.41934204102,
    },
    ped4 = {
        pos = vector3(2577.479, 2730.421, 41.81313),
        Heading = 182.9189453125,
    },
}

Citizen.CreateThread(function()
    LoadModel("s_m_y_construct_01")
    local ped = CreatePed(2, GetHashKey("s_m_y_construct_01"), zones.mineur, 117.68974304199, 0, 0)
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

RMenu.Add('mine', 'main', RageUI.CreateMenu("Mine", " "))
RMenu:Get('mine', 'main'):SetSubtitle("~b~Chef de la Mine")

local vehicle = nil
RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zones.mineur, true)
    if distance <= 2.2 then
        alert("Appuyer sur ~b~E~w~ pour parler avec la personne.")
        if IsControlJustPressed(1, 51) then
            RageUI.Visible(RMenu:Get('mine', 'main'), not RageUI.Visible(RMenu:Get('mine', 'main')))
        end
    end
    if RageUI.Visible(RMenu:Get('mine', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            if not inWork then
                RageUI.Button("Demander un Travail A la Mine", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "Alors comme ça tu veux bosser à la ~g~mine~w~ hein ? Très bien, met un casque et prends tes outils ! Si tu es faible , dis le moi tout de suite !",
                        })
                        inWork = true
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
                        if not ESX.Game.IsSpawnPointClear(vector3(2843.071, 2784.613, 59.94376), 6.0) then
                            local veh = ESX.Game.GetClosestVehicle(vector3(2843.071, 2784.613, 59.94376))
                            TriggerEvent("LS_LSPD:RemoveVeh", veh)
                        end
                        ESX.Game.SpawnVehicle(GetHashKey("sadler"), vector3(2843.071, 2784.613, 59.94376), 59.144374847412, function(veh)
                            SetVehicleOnGroundProperly(veh)
                            vehicle = NetworkGetNetworkIdFromEntity(veh)
                        end)
                        DebutTravail("mineur")
                    end
                end)
            else
                RageUI.Button("Arreter De Travailler", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        RageUI.Popup({
                            message = "Ah ! Tu stop déja ? je savais que tu étais Faible , tiens prend ta paye",
                        })
                        inWork = false
                        FinTravail()
                        TriggerEvent("LS_LSPD:RemoveVeh", NetworkGetEntityFromNetworkId(vehicle))
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