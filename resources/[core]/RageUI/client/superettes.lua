Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RMenu.Add('showcase', 'shop', RageUI.CreateMenu("Epicerie", "Epicerie"))
RMenu:Get('showcase', 'shop').EnableMouse = false

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'shop')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Sandwich", "Acheter Un Sandwich", { RightLabel = "70$" }, true, function(Hovered, Active, Selected)

                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 70, "bread")
                end
            end)

            RageUI.Button("Bouteille d'Eau", "Acheter Une Bouteille d'Eau", { RightLabel = "50$" }, true, function(Hovered, Active, Selected)

                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 50, "water")
                end
            end)

            RageUI.Button("Téléphone", "Acheter Un Téléphone", { RightLabel = "1200$" }, true, function(Hovered, Active, Selected)

                if (Selected) then
                    TriggerServerEvent('ayzn-shops:buy', 1200, "phone")
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
    end
end)