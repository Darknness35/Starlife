local guiEnabled = false
local myIdentity = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- VARIABLES-
function EnableGui(enable)
    SetNuiFocus(enable)
    guiEnabled = enable
    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end

-- Show Registration
RegisterNetEvent("esx_identity:showRegisterIdentity")
AddEventHandler("esx_identity:showRegisterIdentity", function()
  EnableGui(true)
end)

-- Close GUI
RegisterNUICallback('escape', function(data, cb)
    EnableGui(false)
end)

-- Register Callback
RegisterNUICallback('register', function(data, cb)
  myIdentity = data
  TriggerServerEvent('esx_identity:setIdentity', data)
  EnableGui(false)
  Citizen.Wait(500)
  TriggerEvent('esx_skin:openSaveableMenu')
  ESX.ShowNotification("Allez dès maintenant au Concessionnaire pour récupérer votre Voiture Offerte !")
end)

-- THREADING
Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(10)
    end
end)