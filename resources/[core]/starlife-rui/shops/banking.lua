ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
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

RMenu.Add('showcase', 'bank', RageUI.CreateMenu("Ma Banque", "Ma Banque"))
RMenu:Get('showcase', 'bank').EnableMouse = false

RageUI.CreateWhile(1.0, function()
    if RageUI.Visible(RMenu:Get('showcase', 'bank')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            local xPlayer = GetPlayerFromServerId(source)
            balance = xPlayer.getAccount('bank').money
            RageUI.Button("Mon Solde", "Voir Mon Solde", { RightLabel = balance }, true, function(Hovered, Active, Selected)
            end)

            RageUI.Button("---------------------------", "",  true, function(Hovered, Active, Selected)
            end)

            RageUI.Button("Retirer de l'Argent", "Retirer de l'Argent", true, function(Hovered, Active, Selected)

                if (Selected) then
                    amount = KeyboardInput("gneugneu","Somme d'Argent à Retirer :","",8)
                    money = tonumber(amount)
                    mymoney = xPlayer.getAccount('bank').money
                    if money == nil or money <= 0 or money > mymoney then
                        --erreur
                    else
                        xPlayer.removeAccountMoney('bank', money)
		                xPlayer.addMoney(money)
                    end
                end
            end)

            RageUI.Button("Déposer de l'Argent", "Déposer de l'Argent",  true, function(Hovered, Active, Selected)

                if (Selected) then
                    amount = KeyboardInput("gneugneu","Somme d'Argent à Déposer :","",8)
                    money = tonumber(amount)
                    mymoney = xPlayer.getAccount('bank').money
                    if money == nil or money <= 0 or money > mymoney then
                        --erreur
                    else
                        xPlayer.removeMoney(money)
		                xPlayer.addAccountMoney('bank', tonumber(money))
                    end
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
            for i = 1, #v.Banques, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Banques[i].x, v.Banques[i].y, v.Banques[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler au Banquier')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        RageUI.Visible(RMenu:Get('showcase', 'bank'), not RageUI.Visible(RMenu:Get('showcase', 'bank')))
                    end
                end
            end
        end
    end
end)