local kmh = 1.9
local mph = 1.33693629
local carspeed = 0
local driftmode = false -- on/off 
local speed = kmh -- ou mph
local drift_speed_limit = 85.0

ESX  = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

function GetPed()
	return GetPlayerPed(-1) 
end

function GetCar() 
	return GetVehiclePedIsIn(GetPlayerPed(-1),false) 
end

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(1)

		if IsControlJustPressed(1, 82) then

			driftmode = not driftmode

			if driftmode then
				ESX.ShowNotification("Mode Drift : ~g~Activé")
			else
				ESX.ShowNotification("Mode Drift : ~r~Désactivé")
			end
		end

		if driftmode then

			if IsPedInAnyVehicle(GetPed(), false) then

				CarSpeed = GetEntitySpeed(GetCar()) * speed

				if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then

					if CarSpeed <= drift_speed_limit then  
						if IsControlPressed(1, 21) then
							SetVehicleReduceGrip(GetCar(), true)
						else
							SetVehicleReduceGrip(GetCar(), false)
						end
					end
				end
			end
		end
	end
end)