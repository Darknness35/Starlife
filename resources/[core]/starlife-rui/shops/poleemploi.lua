RMenu.Add('rageui', 'emploi', RageUI.CreateMenu("Pole-Emploi", "Pole-Emploi"))
RMenu:Get('rageui', 'emploi').EnableMouse = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Emplois, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Emplois[i].x, v.Emplois[i].y, v.Emplois[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler au Recruteur')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('rageui', 'emploi'), not RageUI.Visible(RMenu:Get('rageui', 'emploi')))
                    end
                end
            end
        end

        if RageUI.Visible(RMenu:Get('rageui', 'emploi')) then

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
                RageUI.Button("Abatteur", "Devenir Abatteur", { RightBadge = RageUI.BadgeStyle.Star }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:setjob', "abatteur")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowNotification("Vous venez d'être embaucher en tant qu'~y~ Abatteur !")
                    end
                end)
    
                RageUI.Button("Bucheron", "Devenir Bucheron", { RightBadge = RageUI.BadgeStyle.Star }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:setjob',"bucheron")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowNotification("Vous venez d'être embaucher en tant que~y~ Bucheron !")
                    end
                end)
    
               --[[  RageUI.Button("Livreur de Pizza", "Devenir Livreur de Pizzas", { RightBadge = RageUI.BadgeStyle.Star }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:setjob',"pizza")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowNotification("Vous venez d'être embaucher en tant que~y~ Livreur de Pizzas !")
                    end
                end)
    
                RageUI.Button("Facteur", "Devenir Facteur", { RightBadge = RageUI.BadgeStyle.Star }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:setjob',"gopostal")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowNotification("Vous venez d'être embaucher en tant que~y~ Facteur !")
                    end
                end)
    
                RageUI.Button("Star Record's", "Devenir Musicien", { RightBadge = RageUI.BadgeStyle.Star }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        TriggerServerEvent('ayzn:setjob',"daymson")
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowNotification("Vous venez d'être embaucher en tant que~y~ Vendeur de CD !")
                    end
                end) ]]
    
            end, function()
            end)
        end
    end
end)