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

local GUI = {}
local PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}

ESX = nil
GUI.Time = 0

Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj)
          ESX = obj
      end)
      Citizen.Wait(0)
  end

  while ESX.GetPlayerData().job == nil do
    Citizen.Wait(100)
  end
  
  PlayerData = ESX.GetPlayerData()
end)

function Message()
  Citizen.CreateThread(function()
    while messagenotfinish do
        Citizen.Wait(1)

      DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
           Citizen.Wait(1)
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            messagenotfinish = false
           TriggerServerEvent('esx_immojob:annonce',result)
            
        end


    end
  end)
  
end

function OpenRealestateAgentMenu()

  local elements = {
    {label = _U('cloakroom'), value = 'cloakroom'},
    {label = _U('properties'), value = 'properties'},
    {label = _U('clients'), value = 'customers'},
    {label = 'Passer une annonce', value = 'announce'}
  }

  if PlayerData.job ~= nil and PlayerData.job.name == 'realestateagent' and PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = _U('boss_action'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'realestateagent',
    {
      title = _U('realtor'),
      elements = elements
    },
    function(data, menu)
	
	    if data.current.value == 'cloakroom' then
        OpenCloakroomMenu()
      end

      if data.current.value == 'properties' then
        OpenPropertyMenu()
      end

      if data.current.value == 'customers' then
        OpenCustomersMenu()
      end

      if data.current.value == 'announce' then
          messagenotfinish = true
          Message()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBosayyyzensMenu', 'realestateagent', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)

      menu.close()



    end
  )

end

function OpenCloakroomMenu()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title = _U('cloakroom'),
      align = 'top-left',
      elements = {
        {label = _U('ems_clothes_civil'), value = 'citizen_wear'},
        {label = _U('ems_clothes_agent'), value = 'agent_wear'},
      },
    },
    function(data, menu)

      menu.close()

      if data.current.value == 'citizen_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)

      end

      if data.current.value == 'agent_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
          end

        end)

      end
	  
    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenPropertyMenu()

  TriggerEvent('esx_property:getProperties', function(properties)

    local elements = {
      head = {_U('property'), 'Actions'},
      rows = {}
    }

    for i=1, #properties, 1 do
      table.insert(elements.rows, {
        data = properties[i],
        cols = {
          properties[i].label,
          _U('property_actions')
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'properties',
      elements,
      function(data, menu)

        if data.value == 'sell' then

          menu.close()

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'sell_property_amount',
            {
              title = _U('amount')
            },
            function(data2, menu)

              local amount = tonumber(data2.value)

              if amount == nil then
                ESX.ShowNotification(_U('invalid_amount'))
              else

                menu.close()

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                if closestPlayer == -1 or closestDistance > 3.0 then
                  ESX.ShowNotification(_U('no_play_near'))
                else
                  TriggerServerEvent('esx_realestateagentjob:sell', GetPlayerServerId(closestPlayer), data.data.name, amount)
                end

                OpenPropertyMenu()

              end

            end,
            function(data2, menu)
              menu.close()
            end
          )

        end

        --[[if data.value == 'rent' then

          menu.close()

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'rent_property_amount',
            {
              title = _U('amount')
            },
            function(data2, menu)

              local amount = tonumber(data2.value)

              if amount == nil then
                ESX.ShowNotification(_U('invalid_amount'))
              else

                menu.close()

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                if closestPlayer == -1 or closestDistance > 3.0 then
                  ESX.ShowNotification(_U('no_play_near'))
                else
                  TriggerServerEvent('esx_realestateagentjob:rent', GetPlayerServerId(closestPlayer), data.data.name, amount)
                end

                OpenPropertyMenu()

              end

            end,
            function(data2, menu)
              menu.close()
            end
          )

        end]]--

        if data.value == 'gps' then

          TriggerEvent('esx_property:getProperty', data.data.name, function(property)

            if property.isSingle then
              SetNewWaypoint(property.entering.x,  property.entering.y)
            else
              TriggerEvent('esx_property:getGateway', property, function(gateway)
                SetNewWaypoint(gateway.entering.x,  gateway.entering.y)
              end)
            end

          end)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenCustomersMenu()

  ESX.TriggerServerCallback('esx_realestateagentjob:getCustomers', function(customers)

    local elements = {
      head = {'Client', _U('property'), 'Type', 'Actions'},
      rows = {}
    }

    for i=1, #customers, 1 do
      table.insert(elements.rows, {
        data = customers[i],
        cols = {
          customers[i].name,
          customers[i].propertyName,
          (customers[i].propertyRented and _U('rent') or _U('sell')),
          _U('contract')
        }
      })
    end

    ESX.UI.Menu.Open(
      'list', GetCurrentResourceName(), 'customers',
      elements,
      function(data, menu)

        if data.value == 'revoke' then
          TriggerServerEvent('esx_realestateagentjob:revoke', data.data.propertyName, data.data.propertyOwner)
          OpenCustomersMenu()
        end

        if data.value == 'gps' then

          TriggerEvent('esx_property:getProperty', data.data.propertyName, function(property)

            if property.isSingle then
              SetNewWaypoint(property.entering.x,  property.entering.y)
            else
              TriggerEvent('esx_property:getGateway', property, function(gateway)
                SetNewWaypoint(gateway.entering.x,  gateway.entering.y)
              end)
            end

          end)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenMobileImmoActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mobile_immo_actions',
    {
      title = 'Agence Immo',
      align = 'top-left',
      elements = {
          {label = 'Passer une annonce', value = 'announce'}
      }
    },
    function(data, menu)

        if data.current.value == 'announce' then
          messagenotfinish = true
          Message()
        end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

  PlayerData = xPlayer

  if PlayerData.job.name == 'realestateagent' then
    Config.Zones.OfficeActions.Type = 1
  else
    Config.Zones.OfficeActions.Type = -1
  end

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

  PlayerData.job = job

  if PlayerData.job.name == 'realestateagent' then
    Config.Zones.OfficeActions.Type = 1
  else
    Config.Zones.OfficeActions.Type = -1
  end

end)

AddEventHandler('esx_realestateagentjob:hasEnteredMarker', function(zone)

  if zone == 'OfficeEnter' then
    local playerPed = GetPlayerPed(-1)
    SetEntityCoords(playerPed,  Config.Zones.OfficeInside.Pos.x,  Config.Zones.OfficeInside.Pos.y,  Config.Zones.OfficeInside.Pos.z)
  end

  if zone == 'OfficeExit' then
    local playerPed = GetPlayerPed(-1)
    SetEntityCoords(playerPed,  Config.Zones.OfficeOutside.Pos.x,  Config.Zones.OfficeOutside.Pos.y,  Config.Zones.OfficeOutside.Pos.z)
  end

  if zone == 'OfficeActions' and PlayerData.job ~= nil and PlayerData.job.name == 'realestateagent' then
    CurrentAction = 'realestateagent_menu'
    CurrentActionMsg = _U('press_to_access')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_realestateagentjob:hasExitedMarker', function(zone)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)


-- Display markers
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(1)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
      end
    end

  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(1)

    local coords = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
        isInMarker = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone = currentZone
      TriggerEvent('esx_realestateagentjob:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_realestateagentjob:hasExitedMarker', LastZone)
    end

  end
end)

-- Key controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(1)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then

        if CurrentAction == 'realestateagent_menu' then
          OpenRealestateAgentMenu()
        end

        CurrentAction = nil
        GUI.Time = GetGameTimer()

      end

    end

    if IsControlPressed(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'realestateagent' then
        OpenMobileImmoActionsMenu()
    end

  end
end)

-- Load IPLS
--Citizen.CreateThread(function()
--  LoadMpDlcMaps()
--  EnableMpDlcMaps(true)
--  RequestIpl('ex_dt1_02_office_02c')
--end)

function DrawAdvancedTextCNN (x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end


 Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)    
                           
            if (affichenews == true) then
                DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
                DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ Khanez Immo ~d~", 255, 255, 255, 255, 1, 0)
                DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteafiche, 255, 255, 255, 255, 7, 0)
                DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)
            end                
       end
    end)



RegisterNetEvent('esx_immojob:annonce')
AddEventHandler('esx_immojob:annonce', function(text)
    texteafiche = text
    affichenews = true
    
  end) 


RegisterNetEvent('esx_immojob:annoncestop')
AddEventHandler('esx_immojob:annoncestop', function()
    affichenews = false
    
  end)