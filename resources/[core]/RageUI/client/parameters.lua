local hasMinimap = false
function toggleMinimap()
    hasMinimap = not hasMinimap
        if hasMinimap == true then
            DisplayRadar(false)
        else
            DisplayRadar(true)
        end
end

RMenu.Add('rageui', 'parameters', RageUI.CreateMenu("Parametres", "Parametres"))
RMenu.Add('rageui', 'affichage', RageUI.CreateSubMenu(RMenu:Get('rageui', 'parameters'), "Affichage"))
RMenu.Add('rageui', 'autres', RageUI.CreateSubMenu(RMenu:Get('rageui', 'parameters'), "Autres"))
RMenu:Get('rageui', 'parameters').EnableMouse = false
RMenu:Get('rageui', 'affichage').EnableMouse = false
RMenu:Get('rageui', 'autres').EnableMouse = false

RageUI.CreateWhile(1.0, function()

    --crée les submenus a partir du menu principal
    if RageUI.Visible(RMenu:Get('rageui', 'parameters')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Affichage", "Affichage", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
            --print("nourriture")
                end
            end, RMenu:Get('rageui', 'affichage'))

            RageUI.Button("Autres", "Autres", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
            --print("nourriture")
                end
            end, RMenu:Get('rageui', 'autres'))


        end, function()
        end)
    end

    --créé les bouttons des submenus
    if RageUI.Visible(RMenu:Get('rageui', 'affichage')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            --[[ RageUI.Button("Afficher HUD", "Afficher HUD", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    --print("2")
                end
            end) ]]

            RageUI.Button("Afficher Map", "Afficher Map", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    toggleMinimap()
                end
            end)

            RageUI.Button("-------------------", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end)

            RageUI.Button("Couleurs Normales", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    SetTimecycleModifier('')
                end
            end)

            RageUI.Button("Couleurs Améliorées", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    SetTimecycleModifier('tunnel')
                end
            end)

            RageUI.Button("Couleurs Amplifiées", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    SetTimecycleModifier('rply_saturation')
                end
            end)

            RageUI.Button("Couleurs Noirs & Blanc", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    SetTimecycleModifier('rply_saturation_neg')
                end
            end)


        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('rageui', 'autres')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()


            --[[ RageUI.Button("Sauvegarder Mon Personnage", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    toggleMinimap()
                end
            end) ]]

            RageUI.Button("Synchroniser Mon Personnage", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerEvent('skinchanger:modelLoaded')
                end
            end)

            RageUI.Button("Optimisation FPS", "", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    DoScreenFadeIn(2000)
                    LoadingPrompt("Optimisation en cours...", 3)
                    DoScreenFadeOut(2000)
                    Citizen.Wait(2000)
                    DoScreenFadeIn(1500)
                    ClearAllBrokenGlass()
                    ClearAllHelpMessages()
                    LeaderboardsReadClearAll()
                    ClearBrief()
                    ClearGpsFlags()
                    ClearPrints()
                    ClearSmallPrints()
                    ClearReplayStats()
                    LeaderboardsClearCacheData()
                    ClearFocus()
                    ClearHdArea()
                    ClearHelp()
                    ClearNotificationsPos()
                    ClearPedInPauseMenu()
                    ClearFloatingHelp()
                    ClearGpsPlayerWaypoint()
                    ClearGpsRaceTrack()
                    ClearReminderMessage()
                    ClearThisPrint()
        
                    Citizen.Wait(2090)
                    RemoveLoadingPrompt()
                    Citizen.Wait(100)
                    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                end
            end)

        end, function()
        end)
    end


end, 1)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsDisabledControlJustReleased(0, 57) then
            RageUI.Visible(RMenu:Get('rageui', 'parameters'), not RageUI.Visible(RMenu:Get('rageui', 'parameters')))
        end 
    end
end)