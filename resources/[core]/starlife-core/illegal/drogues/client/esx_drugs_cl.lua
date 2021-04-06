local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PID           			= 0
local GUI           			= {}
local cokeQTE       			= 0
ESX 			    			= nil
GUI.Time            			= 0
local coke_poochQTE 			= 0
local weedQTE					= 0
local weed_poochQTE 			= 0
local methQTE					= 0
local meth_poochQTE 			= 0
local opiumQTE					= 0
local opium_poochQTE 			= 0
local myJob 					= nil
local PlayerData 				= {}
local GUI 						= {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

AddEventHandler('esx_drugs:hasEnteredMarker', function(zone)

        ESX.UI.Menu.CloseAll()

        --coke
        if zone == 'CokeFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'coke_harvest'
                CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour récolter la coke"
                CurrentActionData = {}
            end
        end

        if zone == 'CokeTreatment' then
            if myJob ~= "police" then
                if cokeQTE >= 5 then
                    CurrentAction     = 'coke_treatment'
                    CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour traiter la coke'
                    CurrentActionData = {}
                end
            end
        end

        if zone == 'CokeResell' then
            if myJob ~= "police" then
                if coke_poochQTE >= 1 then
                    CurrentAction     = 'coke_resell'
                    CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour vendre la coke'
                    CurrentActionData = {}
                end
            end
        end

        --meth
        if zone == 'MethFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'meth_harvest'
                CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour récolter la meth'
                CurrentActionData = {}
            end
        end

        if zone == 'MethTreatment' then
            if myJob ~= "police" then
                if methQTE >= 5 then
                    CurrentAction     = 'meth_treatment'
                    CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour traiter la meth'
                    CurrentActionData = {}
                end
            end
        end

        if zone == 'MethResell' then
            if myJob ~= "police" then
                if meth_poochQTE >= 1 then
                    CurrentAction     = 'meth_resell'
                    CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour vendre la meth'
                    CurrentActionData = {}
                end
            end
        end

        --weed
        if zone == 'WeedFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'weed_harvest'
                CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour récolter la weed'
                CurrentActionData = {}
            end
        end

        if zone == 'WeedTreatment' then
            if myJob ~= "police" then
                if weedQTE >= 5 then
                    CurrentAction     = 'weed_treatment'
                    CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour traiter la weed'
                    CurrentActionData = {}
                end
            end
        end

        if zone == 'WeedResell' then
            if myJob ~= "police" then
                if weed_poochQTE >= 1 then
                    CurrentAction     = 'weed_resell'
                    CurrentActionMsg  = 'appuyez sur ~INPUT_CONTEXT~ pour vendre la weed'
                    CurrentActionData = {}
                end
            end
        end

        --opium
        if zone == 'OpiumFarm' then
            if myJob ~= "police" then
                CurrentAction     = 'opium_harvest'
                CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour récolter l'opium"
                CurrentActionData = {}
            end
        end

        if zone == 'OpiumTreatment' then
            if myJob ~= "police" then
                if opiumQTE >= 5 then
                    CurrentAction     = 'opium_treatment'
                    CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour traiter l'opium"
                    CurrentActionData = {}
                end
            end
        end

        if zone == 'OpiumResell' then
            if myJob ~= "police" then
                if opium_poochQTE >= 1 then
                    CurrentAction     = 'opium_resell'
                    CurrentActionMsg  = "appuyez sur ~INPUT_CONTEXT~ pour vendre l'opium"
                    CurrentActionData = {}
                end
            end
        end
end)

AddEventHandler('esx_drugs:hasExitedMarker', function(zone)

        CurrentAction = nil
        ESX.UI.Menu.CloseAll()

        TriggerServerEvent('esx_drugs:stopHarvayyyzenestCoke')
        TriggerServerEvent('esx_drugs:stopTranayyyzensformCoke')
        TriggerServerEvent('esx_drugs:stopSellayyyzenCoke')
        TriggerServerEvent('esx_drugs:stopHarvesayyyzentMeth')
        TriggerServerEvent('esx_drugs:stopTranayyyzensformMeth')
        TriggerServerEvent('esx_drugs:stopSellMayyyzeneth')
        TriggerServerEvent('esx_drugs:stopHarayyyzenvestWeed')
        TriggerServerEvent('esx_drugs:stopTayyyzenransformWeed')
        TriggerServerEvent('esx_drugs:stopSellWayyyzeneed')
        TriggerServerEvent('esx_drugs:stopHarvestayyyzenOpium')
        TriggerServerEvent('esx_drugs:stopTransayyyzenformOpium')
        TriggerServerEvent('esx_drugs:stopSellOpiuayyyzenm')
end)


-- Render markers
Citizen.CreateThread(function()
    while true do

        Wait(0)

        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(ConfigDrogues.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < ConfigDrogues.DrawDistance) then
                DrawMarker(ConfigDrogues.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, ConfigDrogues.ZoneSize.x, ConfigDrogues.ZoneSize.y, ConfigDrogues.ZoneSize.z, ConfigDrogues.MarkerColor.r, ConfigDrogues.MarkerColor.g, ConfigDrogues.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('esx_drugs:ReturnInventory')
AddEventHandler('esx_drugs:ReturnInventory', function(cokeNbr, cokepNbr, methNbr, methpNbr, weedNbr, weedpNbr, opiumNbr, opiumpNbr, jobName, currentZone)
    cokeQTE       = cokeNbr
    coke_poochQTE = cokepNbr
    methQTE 	  = methNbr
    meth_poochQTE = methpNbr
    weedQTE 	  = weedNbr
    weed_poochQTE = weedpNbr
    opiumQTE       = opiumNbr
    opium_poochQTE = opiumpNbr
    myJob         = jobName
    TriggerEvent('esx_drugs:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
    while true do

        Wait(0)

        local coords      = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker  = false
        local currentZone = nil

        for k,v in pairs(ConfigDrogues.Zones) do
            if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < ConfigDrogues.ZoneSize.x / 2) then
                isInMarker  = true
                currentZone = k
            end
        end

        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            lastZone                = currentZone
            TriggerServerEvent('esx_drugs:GetUserInventory', currentZone)
        end

        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('esx_drugs:hasExitedMarker', lastZone)
        end

    end
end)

-- Key Controls
Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    while true do
        Citizen.Wait(1)
        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(0, 38) then
                if CurrentAction == 'coke_harvest' then
                    TriggerServerEvent('esx_drugs:startHarvestayyyzenCoke')
                    ESX.ShowNotification("~s~Vous ramassez de la ~g~Coke~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'coke_treatment' then
                    TriggerServerEvent('esx_drugs:startTransayyyzenformCoke')
                    ESX.ShowNotification("~s~Vous traitez de la ~g~Coke~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'coke_resell' then
                    TriggerServerEvent('esx_drugs:startSellCayyyzenoke')
                    ESX.ShowNotification("~s~Vous vendez de la ~g~Coke~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'meth_harvest' then
                    TriggerServerEvent('esx_drugs:startHarayyyzenvestMeth')
                    ESX.ShowNotification("~s~Vous ramassez de la ~g~Meth~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'meth_treatment' then
                    TriggerServerEvent('esx_drugs:startTayyyzenransformMeth')
                    ESX.ShowNotification("~s~Vous traitez de la ~g~Meth~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'meth_resell' then
                    TriggerServerEvent('esx_drugs:startSellMayyyzeneth')
                    ESX.ShowNotification("~s~Vous vendez de la ~g~Meth~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'weed_harvest' then
                    TriggerServerEvent('esx_drugs:startHarvestWayyyzeneed')
                    ESX.ShowNotification("~s~Vous ramassez de la ~g~Weed~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'weed_treatment' then
                    TriggerServerEvent('esx_drugs:startTransfoayyyzenrmWeed')
                    ESX.ShowNotification("~s~Vous traitez de la ~g~Weed~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'weed_resell' then
                    TriggerServerEvent('esx_drugs:startSellWeayyyzened')
                    ESX.ShowNotification("~s~Vous vendez de la ~g~Weed~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'opium_harvest' then
                    TriggerServerEvent('esx_drugs:startHayyyzenarvestOpium')
                    ESX.ShowNotification("~s~Vous ramassez de l\'~g~Opium~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'opium_treatment' then
                    TriggerServerEvent('esx_drugs:starayyyzentTransformOpium')
                    ESX.ShowNotification("~s~Vous traitez de l\'~g~Opium~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                if CurrentAction == 'opium_resell' then
                    TriggerServerEvent('esx_drugs:startSellayyyzenOpium')
                    ESX.ShowNotification("~s~Vous vendez de l\'~g~Opium~n~.")
                    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                end
                CurrentAction = nil
            end
        end
    end
end)

--Weed
RegisterNetEvent('esx_drugeffects:onWeed')
AddEventHandler('esx_drugeffects:onWeed', function()
  
  local playerPed = GetPlayerPed(-1)
  
    RequestAnimSet("move_m@hipster@a") 
    while not HasAnimSetLoaded("move_m@hipster@a") do
      Citizen.Wait(1)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.3)
        
    Wait(300000)

    SetRunSprintMultiplierForPlayer(player, 1.0)		
end)

--Opium
RegisterNetEvent('esx_drugeffects:onOpium')
AddEventHandler('esx_drugeffects:onOpium', function()
  
  local playerPed = GetPlayerPed(-1)
  
        RequestAnimSet("move_m@drunk@moderatedrunk") 
    while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
      Citizen.Wait(1)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)

    Wait(520000)

    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
 end)

--Meth
RegisterNetEvent('esx_drugeffects:onMeth')
AddEventHandler('esx_drugeffects:onMeth', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_injured_generic") 
    while not HasAnimSetLoaded("move_injured_generic") do
      Citizen.Wait(1)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_injured_generic", true)
    SetPedIsDrug(playerPed, true)
    
   --Efects
    local player = PlayerId()  
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
    SetEntityHealth(playerPed, newHealth)
    
end)

--Coke
RegisterNetEvent('esx_drugeffects:onCoke')
AddEventHandler('esx_drugeffects:onCoke', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(1)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    AddArmourToPed(playerPed, 100)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    SetEntityHealth(playerPed, newHealth)
    
end)