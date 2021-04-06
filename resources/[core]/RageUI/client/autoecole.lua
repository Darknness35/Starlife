RMenu.Add('showcase', 'autoecole', RageUI.CreateMenu("Auto-Ecole", "Auto-Ecole"))
RMenu:Get('showcase', 'autoecole').EnableMouse = false

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'autoecole')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

            RageUI.Button("Permis Voiture", "Passer le Permis Voiture", { RightLabel = "10000$" }, true, function(Hovered, Active, Selected)

                if Selected then
                    TriggerServerEvent('ayzn_autoecole:addlicense', 10000, "drive")
                end
            end)

            RageUI.Button("Permis Moto", "Passer le Permis Moto", { RightLabel = "8000$" }, true, function(Hovered, Active, Selected)

                if Selected then
                    TriggerServerEvent('ayzn_autoecole:addlicense', 8000, "drive_bike")
                end
            end)

            RageUI.Button("Permis Camion", "Passer le Permis Camion", { RightLabel = "7500$" }, true, function(Hovered, Active, Selected)

                if Selected then
                    TriggerServerEvent('ayzn_autoecole:addlicense', 7500, "drive_truck")
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
            for i = 1, #v.AutoEcole, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.AutoEcole[i].x, v.AutoEcole[i].y, v.AutoEcole[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler à l\'Examinateur')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('showcase', 'autoecole'), not RageUI.Visible(RMenu:Get('showcase', 'autoecole')))
                    end
                end
            end
        end
    end
end)