
RMenu.Add('armory', 'main', RageUI.CreateMenu("Armurerie", "Armurerie"))

RMenu.Add('armory', 'whitewp', RageUI.CreateSubMenu(RMenu:Get('armory', 'main'), "Armes Blanches","Armes Blanches" ))
RMenu.Add('armory', 'letalwp', RageUI.CreateSubMenu(RMenu:Get('armory', 'main'), "Armes Létales","Armes Létales"   ))
RMenu.Add('armory', 'accesories', RageUI.CreateSubMenu(RMenu:Get('armory', 'main'), "Accessoires","Accessoires" ))

RMenu:Get('armory', 'main').EnableMouse = false
RMenu:Get('armory', 'letalwp').EnableMouse = false
RMenu:Get('armory', 'whitewp').EnableMouse = false
RMenu:Get('armory', 'accesories').EnableMouse = false

RageUI.CreateWhile(1.0, function()

    
    if RageUI.Visible(RMenu:Get('armory', 'main')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Armes Blanches", "Armes Blanches", { RightBadge = RageUI.BadgeStyle.Gun }, true, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, RMenu:Get('armory', 'whitewp'))

            RageUI.Button("Armes Létales", "Armes Létales", { RightBadge = RageUI.BadgeStyle.Gun }, true, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, RMenu:Get('armory', 'letalwp'))
            
            RageUI.Button("Accessoires", "Accessoires", { RightBadge = RageUI.BadgeStyle.Mask }, true, function(Hovered, Active, Selected)
                if (Selected) then
                end
            end, RMenu:Get('armory', 'accesories'))

        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('armory', 'whitewp')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Couteau", "Couteau", { RightLabel = "~g~260000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 260000, "WEAPON_KNIFE", "Couteau")
                end
            end)
            
            RageUI.Button("Batte de Baseball", "Batte de Baseball", { RightLabel = "~g~280000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 280000, "WEAPON_BAT", "Batte")
                end
            end)
 
            RageUI.Button("Bouteille en Verre", "Bouteille en Verre", { RightLabel = "~g~240000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 240000, "WEAPON_BOTTLE", "Bouteille")
                end
            end)
            
            RageUI.Button("Poing Américain", "Poing Américain", { RightLabel = "~g~250000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 250000, "WEAPON_KNUCKLE", "Poing Américain")
                end
            end)

            RageUI.Button("Hachette", "Hachette", { RightLabel = "~g~250000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 250000, "WEAPON_HATCHET", "Hachette")
                end
            end)
            

        end, function()
        end)
    end



    if RageUI.Visible(RMenu:Get('armory', 'letalwp')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Pistolet", "Pistolet", { RightLabel = "~g~555000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 555000, "WEAPON_PISTOL", "Pistolet")
                end
            end)

            RageUI.Button("Pistolet Calibre 50", "Pistolet Calibre 50", { RightLabel = "~g~635000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 635000, "WEAPON_PISTOL50", "Pistolet Calibre 50")                    
                end
            end)

            RageUI.Button("Pétoire", "Pétoire", { RightLabel = "~g~570000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 570000, "WEAPON_SNSPISTOL", "Pétoire")                    
                end
            end)

            RageUI.Button("Pistolet Vintage", "Pistolet Vintage", { RightLabel = "~g~600000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 600000, "WEAPON_SNSPISTOL", "Pistolet Vintage")                    
                end
            end)

            RageUI.Button("Pistolet Lourd", "Pistolet Lourd", { RightLabel = "~g~666000$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn:buyweapon', 666000, "WEAPON_SNSPISTOL", "Pistolet Lourd")                    
                end
            end)

        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('armory', 'accesories')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
            RageUI.Button("Chargeurs", "Chargeurs", { RightLabel = "~g~2500$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 2500, "clip", "Chargeur")                 
                end
            end)

            RageUI.Button("Jumelles", "Jumelles", { RightLabel = "~g~6500$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 6500, "jumelles", "Jumelles")                   
                end
            end)
    
            RageUI.Button("Silencieux", "Silencieux", { RightLabel = "~g~3750$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 3750, "silencieux", "Silencieux")                   
                end
            end)
    
            RageUI.Button("Lampe", "Lampe", { RightLabel = "~g~3750$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 3750, "flashlight", "Lampe")                    
                end
            end)
    
            RageUI.Button("Poignée", "Poignée", { RightLabel = "~g~3750$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 3750, "grip", "Poignée")                   
                end
            end)
    
            RageUI.Button("Skin OR", "Skin OR", { RightLabel = "~g~12500$" }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 12500, "yusuf", "Skin d'arme")                 
                end
            end)

        end, function()
        end)
    end
        
        

end, 1)


function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Armureries, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Armureries[i].x, v.Armureries[i].y, v.Armureries[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler au Vendeur')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('armory', 'main'), not RageUI.Visible(RMenu:Get('armory', 'main')))
                    end
                end
            end
        end
    end
end)
