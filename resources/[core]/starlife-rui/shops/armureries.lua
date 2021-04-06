
RMenu.Add('armory', 'main', RageUI.CreateMenu("Armurerie", "Armurerie"))

RMenu.Add('armory', 'whitewp', RageUI.CreateSubMenu(RMenu:Get('armory', 'main'), "Armes Blanches","Armes Blanches" ))
RMenu.Add('armory', 'letalwp', RageUI.CreateSubMenu(RMenu:Get('armory', 'main'), "Armes Létales","Armes Létales"   ))
RMenu.Add('armory', 'accesories', RageUI.CreateSubMenu(RMenu:Get('armory', 'main'), "Accessoires","Accessoires" ))

local quantity = 1

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

        if RageUI.Visible(RMenu:Get('armory', 'main')) then

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
                RageUI.Button("Armes Blanches", "Armes Blanches", { RightBadge = RageUI.BadgeStyle.Gun }, true, function(Hovered, Active, Selected)
                end, RMenu:Get('armory', 'whitewp'))
    
                RageUI.Button("Armes Létales", "Armes Létales", { RightBadge = RageUI.BadgeStyle.Gun }, true, function(Hovered, Active, Selected)
                end, RMenu:Get('armory', 'letalwp'))
                
                RageUI.Button("Accessoires", "Accessoires", { RightBadge = RageUI.BadgeStyle.Mask }, true, function(Hovered, Active, Selected)
                end, RMenu:Get('armory', 'accesories'))
    
            end, function()
            end)
        end
    
        if RageUI.Visible(RMenu:Get('armory', 'whitewp')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
                RageUI.Button("Couteau", "Couteau", { RightLabel = "~g~260000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Couteau", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 260000, "WEAPON_KNIFE", "Couteau")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
                
                RageUI.Button("Batte de Baseball", "Batte de Baseball", { RightLabel = "~g~280000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander une ~b~Batte", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 280000, "WEAPON_BAT", "Batte")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
     
                RageUI.Button("Bouteille en Verre", "Bouteille en Verre", { RightLabel = "~g~240000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander une ~b~Bouteille En Verre", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 240000, "WEAPON_BOTTLE", "Bouteille")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
                
                RageUI.Button("Poing Américain", "Poing Américain", { RightLabel = "~g~250000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Poing Américain", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 250000, "WEAPON_KNUCKLE", "Poing Américain")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
    
                RageUI.Button("Hachette", "Hachette", { RightLabel = "~g~250000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander une ~b~Hachette", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 250000, "WEAPON_HATCHET", "Hachette")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
                
    
            end, function()
            end)
        end

        if RageUI.Visible(RMenu:Get('armory', 'letalwp')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
                RageUI.Button("Pistolet", "Pistolet", { RightLabel = "~g~555000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Pistolet", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 555000, "WEAPON_PISTOL", "Pistolet")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
    
                RageUI.Button("Pistolet Calibre 50", "Pistolet Calibre 50", { RightLabel = "~g~635000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Calibre 50", "Je vous le prépare...", "CHAR_AMMUNATION", 1)        
                        Wait(5000)   
                        TriggerServerEvent('ayzn:buyweapon', 635000, "WEAPON_PISTOL50", "Pistolet Calibre 50")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
    
                RageUI.Button("Pétoire", "Pétoire", { RightLabel = "~g~570000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Pétoire", "Je vous le prépare...", "CHAR_AMMUNATION", 1)       
                        Wait(5000)  
                        TriggerServerEvent('ayzn:buyweapon', 570000, "WEAPON_SNSPISTOL", "Pétoire")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
    
                RageUI.Button("Pistolet Vintage", "Pistolet Vintage", { RightLabel = "~g~600000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)                    
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Pistolet Vintage", "Je vous le prépare...", "CHAR_AMMUNATION", 1)
                        Wait(5000)
                        TriggerServerEvent('ayzn:buyweapon', 600000, "WEAPON_VINTAGEPISTOL", "Pistolet Vintage")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
    
                RageUI.Button("Pistolet Lourd", "Pistolet Lourd", { RightLabel = "~g~666000$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)  
                        ShowAdvancedNotification("Armurerie", "Vous avez commander un ~b~Pistolet Loud", "Je vous le prépare...", "CHAR_AMMUNATION", 1)         
                        Wait(5000)       
                        TriggerServerEvent('ayzn:buyweapon', 666000, "WEAPON_HEAVYPISTOL", "Pistolet Lourd")
                        ShowAdvancedNotification("Armurerie", "Livraison", "Tenez votre Arme", "CHAR_AMMUNATION", 1)
                    end
                end)
    
            end, function()
            end)
        end
    
        if RageUI.Visible(RMenu:Get('armory', 'accesories')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
        
                RageUI.Button("Chargeurs", "Chargeurs", { RightLabel = "~g~2500$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        quantity = KeyboardInput("Saluut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 2500, "clip",quantity)                 
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                            ShowAdvancedNotification("Armurerie", "Vous avez commander "..quantity.." ~b~Chargeur", "", "CHAR_AMMUNATION", 1)
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
    
                RageUI.Button("Jumelles", "Jumelles", { RightLabel = "~g~6500$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        quantity = KeyboardInput("Saluut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 6500, "jumelles",quantity)                 
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                            ShowAdvancedNotification("Armurerie", "Vous avez commander "..quantity.." ~b~Jumelles", "", "CHAR_AMMUNATION", 1)
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
        
                RageUI.Button("Silencieux", "Silencieux", { RightLabel = "~g~3750$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        quantity = KeyboardInput("Saluut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 3750, "silencieux",quantity)             
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                            ShowAdvancedNotification("Armurerie", "Vous avez commander "..quantity.." ~b~Silencieux", "", "CHAR_AMMUNATION", 1)    
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end 
                    end
                end)
        
                RageUI.Button("Lampe", "Lampe", { RightLabel = "~g~3750$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        quantity = KeyboardInput("Saluut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 3750, "flashlight",quantity)                  
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                            ShowAdvancedNotification("Armurerie", "Vous avez commander "..quantity.." ~b~Lampe", "", "CHAR_AMMUNATION", 1)  
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
        
                RageUI.Button("Poignée", "Poignée", { RightLabel = "~g~3750$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        quantity = KeyboardInput("Saluut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 3750, "grip",quantity)                   
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                            ShowAdvancedNotification("Armurerie", "Vous avez commander "..quantity.." ~b~Poignée", "", "CHAR_AMMUNATION", 1)
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
        
                RageUI.Button("Skin OR", "Skin OR", { RightLabel = "~g~12500$" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        quantity = KeyboardInput("Saluut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 12500, "yusuf",quantity)                
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                            ShowAdvancedNotification("Armurerie", "Vous avez commander "..quantity.." ~b~Skin d'Arme", "", "CHAR_AMMUNATION", 1) 
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
    
            end, function()
            end)
        end
    end
end)