RMenu.Add('showcase', 'shop', RageUI.CreateMenu("Epicerie", "Epicerie"))
RMenu:Get('showcase', 'shop').EnableMouse = false

local quantity = 1
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(Config.Zones) do
            for i = 1, #v.Superettes, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Superettes[i].x, v.Superettes[i].y, v.Superettes[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler à Apu')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('showcase', 'shop'), not RageUI.Visible(RMenu:Get('showcase', 'shop')))
                    end
                end
            end
        end

        if RageUI.Visible(RMenu:Get('showcase', 'shop')) then

            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
    
                RageUI.Button("Sandwich", "Acheter Un Sandwich", { RightLabel = "70$" }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        quantity = KeyboardInput("Salut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 70, "bread",quantity)
                            ShowNotification("Vous avez acheté "..quantity.." ~y~Sandwich")
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
    
                RageUI.Button("Bouteille d'Eau", "Acheter Une Bouteille d'Eau", { RightLabel = "50$" }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        quantity = KeyboardInput("Salut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 50, "water",quantity)
                            ShowNotification("Vous avez acheté "..quantity.." ~y~Bouteille d'Eau")
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        else
                            ShowNotification("Veuillez rentrer une Quantité Valide")
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
    
                RageUI.Button("Téléphone", "Acheter Un Téléphone", { RightLabel = "1200$" }, true, function(Hovered, Active, Selected)
    
                    if (Selected) then
                        quantity = KeyboardInput("Salut","Quantité","",5)
                        if tonumber(quantity) then
                            TriggerServerEvent('ayzn-shops:buy', 1200, "phone",quantity)
                            ShowNotification("Vous avez acheté "..quantity.." ~y~Téléphone")
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
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