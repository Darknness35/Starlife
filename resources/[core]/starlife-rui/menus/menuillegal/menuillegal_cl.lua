local PlayerData = {}
PlayerData.faction = {name = nil, faction_grade = nil, faction_label = nil, faction_grade_label = nil, faction_grade_name = nil}
local haveWeapons = false
local hasMenottes = false
local hasObjects = false

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj)
      ESX = obj
    end)
    Citizen.Wait(0)
  end

  while ESX.GetPlayerData().faction == nil do
    Citizen.Wait(100)
  end

  PlayerData = ESX.GetPlayerData()
end)


RMenu.Add('showcase', 'faction', RageUI.CreateMenu("Interaction Citoyen", "Interaction Citoyen"))
RMenu.Add('showcase', 'fouiller', RageUI.CreateMenu("Interaction Citoyen", "Interaction Citoyen"))

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    if IsDisabledControlJustReleased(0, 168) then
      RageUI.Visible(RMenu:Get('showcase', 'faction'), not RageUI.Visible(RMenu:Get('showcase', 'faction')))
    end
    if RageUI.Visible(RMenu:Get('showcase', 'faction')) then
      local player, distance = ESX.Game.GetClosestPlayer()
      RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()       
        if distance ~= -1 and distance <= 3.0 then
          if not hasMenottes then
            RageUI.Button("Fouiller", "Fouiller", {}, true, function(Hovered, Active, Selected)
              if (Selected) then
                RageUI.Visible(RMenu:Get('showcase', 'fouiller'), not RageUI.Visible(RMenu:Get('showcase', 'fouiller')))
              end
            end)
          elseif hasMenottes == true then
            RageUI.Button("Attacher", nil, {}, true, function(Hovered, Active, Selected)
              if (Selected) then
                TriggerServerEvent('esx_faction:handcuff', GetPlayerServerId(player))
              end
            end)
            RageUI.Button("Fouiller", "Fouiller", {}, true, function(Hovered, Active, Selected)
              if (Selected) then
                RageUI.Visible(RMenu:Get('showcase', 'fouiller'), not RageUI.Visible(RMenu:Get('showcase', 'fouiller')))
              end
            end)
            RageUI.Button("Escorter", nil, {}, true, function(Hovered, Active, Selected)
              if (Selected) then
                TriggerServerEvent('esx_faction:drag', GetPlayerServerId(player))
              end
            end)
            RageUI.Button("Mettre dans Véhicule", nil, {}, true, function(Hovered, Active, Selected)
              if (Selected) then
                TriggerServerEvent('esx_faction:putInVehicle', GetPlayerServerId(player))
              end
            end)
            RageUI.Button("Sortir du véhicule", nil, {}, true, function(Hovered, Active, Selected)
              if (Selected) then
                TriggerServerEvent('esx_faction:OutVehicle', GetPlayerServerId(player))
              end
            end)
          end
        else
          RageUI.Button("Aucune Personne à Proximité", nil, {}, true, function(Hovered, Active, Selected)
          end)
        end
      end, function()
      end)
    end
    if RageUI.Visible(RMenu:Get('showcase', 'fouiller')) then
      local player, distance = ESX.Game.GetClosestPlayer()
      RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()       
        if distance ~= -1 and distance <= 3.0 then
          ESX.TriggerServerCallback('esx_faction:getOtherPlayerData', function(data)
            --argent sale
            local blackMoney = 0
            for i=1, #data.accounts, 1 do
              if data.accounts[i].name == 'black_money' then
                blackMoney = data.accounts[i].money
              end
            end
            if blackMoney > 0 then
              RageUI.Button("Argent Sale :", " ", {RightLabel = blackMoney.."$"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                  if hasMenottes then
                    TriggerServerEvent('esx_faction:confiscatePlayerItem', GetPlayerServerId(player), 'item_account', 'black_money', blackMoney)
                  else
                    ShowNotification("Vous ne pouvez pas faire ca")
                    PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                  end
                end
              end)
            else
              RageUI.Button("Pas d'Argent Sale", " ", {}, true, function(Hovered, Active, Selected)
              end)
            end
            --armes
            for i=1, #data.weapons, 1 do
              haveWeapons = true
              local amount = data.ammo
              RageUI.Button(ESX.GetWeaponLabel(data.weapons[i].name), " ", {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                  if hasMenottes then
                    TriggerServerEvent('esx_faction:confiscatePlayerItem', GetPlayerServerId(player), 'item_weapon', data.weapons[i].name, amount)
                  else
                    ShowNotification("Vous ne pouvez pas faire ca")
                    PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                  end
                end
              end)
            end
            if not haveWeapons then
              RageUI.Button("Aucune Arme", " ", {}, true, function(Hovered, Active, Selected)
              end)
            end
            --inventaire
            for i=1, #data.inventory, 1 do
              if data.inventory[i].count > 0 then
                hasObjects = true
                local amount = data.inventory[i].count
                RageUI.Button(data.inventory[i].label, " ", {RightLabel = "x"..data.inventory[i].count }, true, function(Hovered, Active, Selected)
                  if (Selected) then
                    if hasMenottes then
                      TriggerServerEvent('esx_faction:confiscatePlayerItem', GetPlayerServerId(player), 'item_standard', data.weapons[i].name, amount)
                    else
                      ShowNotification("Vous ne pouvez pas faire ca")
                      PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                    end
                  end
                end)
              end
            end
            if not hasObjects then
              RageUI.Button("Aucun Objets", " ", {}, true, function(Hovered, Active, Selected)
              end)
            end
          end, GetPlayerServerId(player))
        else
          RageUI.Button("Aucune Personne à Proximité", " ", {}, true, function(Hovered, Active, Selected)
          end)
        end
      end, function()
      end)
    end
  end
end)

RegisterNetEvent('esx_faction:handcuff')
AddEventHandler('esx_faction:handcuff', function()

  IsHandcuffed = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Citizen.Wait(10)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed, true)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed, true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)


RegisterNetEvent('esx_faction:drag')
AddEventHandler('esx_faction:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)


RegisterNetEvent('esx_faction:putInVehicle')
AddEventHandler('esx_faction:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle, i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
      end

    end

  end

end)


RegisterNetEvent('esx_faction:OutVehicle')
AddEventHandler('esx_faction:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30, true) -- MoveLeftRight
      DisableControlAction(0, 31, true) -- MoveUpDown
    end

    if PlayerData.faction.grade_name ~= 'recrue' then
      hasMenottes = true
    else
      hasMenottes = false
    end

  end
end)