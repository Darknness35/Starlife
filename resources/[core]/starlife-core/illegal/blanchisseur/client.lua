ESX = nil
local GUI, CurrentActionData = {}, {}
local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
GUI.Time = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_blanchisseur:notify")
AddEventHandler("esx_blanchisseur:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
		Wait(1)
		SetNotificationTextEntry("STRING");
		AddTextComponentString(text);
		SetNotificationMessage(icon, icon, true, type, sender, title, text);
		DrawNotification(false, true);
    end)
end)

function OpenBlanchisseurMenu()
  local elements = { }
	  table.insert(elements, {label = 'Blanchir votre argent sale',    value = 'wash_money'})

	ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'whitening', {
        title    ='Blanchisseur',
        align    = 'top-left',
        elements = elements,
        }, function(data, menu)
		
		if data.current.value == 'wash_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'wash_money_amount_', {
					title = 'Montant à blanchir'
				}, function(data, menu)

					local amount = tonumber(data.value)

					if amount == nil then
						TriggerEvent("esx_blanchisseur:notify", "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Montant invalide')
						ESX.UI.Menu.CloseAll()
					else
						menu.close()
						TriggerServerEvent('esx_blanchisseur:washMoney', amount)
						ESX.UI.Menu.CloseAll()
					end
				end, function(data, menu)
					menu.close()
				end)
			end
    end, function(data, menu)

      menu.close()

      CurrentAction     = 'whitening'
      CurrentActionData = { }
    end)
end

AddEventHandler('esx_blanchisseur:hasEnteredMarker', function(zone)
	CurrentAction     = 'whitening'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_blanchisseur:hasExitedMarker', function(zone)
	CurrentAction = nil
	TriggerServerEvent('esx_blanchisseur:stopWhitening')
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(ConfigBlanchiment.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < ConfigBlanchiment.MarkerSize.x / 2) then
				isInMarker  = true
				currentZone = k
				percent     = v.percent
			end
		end
		
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_blanchisseur:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_blanchisseur:hasExitedMarker', LastZone)
		end
	end
end)

-- Create Blips
if ConfigBlanchiment.Blip then
	Citizen.CreateThread(function ()
		for k,v in ipairs(ConfigBlanchiment.Zones)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, 134)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipColour (blip, 5)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(_U('blanchisseurblip'))
			EndTextCommandSetBlipName(blip)
		end
	end)
end

-- Key Controls
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0, 38) and (GetGameTimer() - GUI.Time) > 1000 then
		heure		= tonumber(GetClockHours())
		GUI.Time 	= GetGameTimer()
		
        if CurrentAction == 'whitening' then
			if ConfigBlanchiment.Hours then
				if heure > ConfigBlanchiment.openHours and heure < ConfigBlanchiment.closeHours then
					if ConfigBlanchiment.Menu then	
						OpenBlanchisseurMenu()
					else
						TriggerServerEvent('esx_blanchisayyyzenseur:startWhitening', percent)
					end					
				else
					TriggerServerEvent('esx_blanchisseur:Nothere')
				end
			else
				if ConfigBlanchiment.Menu then	
					OpenBlanchisseurMenu()
				else
					TriggerServerEvent('esx_blanchisayyyzenseur:startWhitening', percent)
				end					
			end
        end

        CurrentAction = nil
      end
    end
  end
end)
