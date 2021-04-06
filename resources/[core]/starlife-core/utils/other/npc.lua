local zoneDouane = {
	{co = vector3(-2612.849, 3203.553, 48.19164), dst = 1500.0},--base militaire
	{co = vector3(1651.373, 1227.158, 84.49791), dst = 1500.0},
	{co = vector3(-1096.632, -840.7131, 51.88755), dst = 150.0},
	{co = vector3(-246.6787, -339.6397, 29.9765), dst = 150.0},
	{co = vector3(-13.90932, 18.28495, 73.84755), dst = 150.0},
	{co = vector3(279.1121, -579.1276, 44.21798), dst = 150.0},
    {co = vector3(-511.197, -602.736, 30.298), dst = 500.0},--pc
    {co = vector3(-977.216, -2710.379, 13.853), dst = 1500.0},--aeroport
    {co = vector3(105.359, 6613.586,  32.3973), dst = 1500.0},--paleto
}
local iPlayerID = GetPlayerServerId()
local pasDePnj = false
local pasDePnjEnt = false

-- Main thread

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
		ClearAreaOfCops(GetEntityCoords(GetPlayerPed(-1)), 100.0, 0)
		SetEveryoneIgnorePlayer(player, true)

		if pasDePnj then
			SetVehicleDensityMultiplierThisFrame(0.0)
	    	SetPedDensityMultiplierThisFrame(0.0)
	    	SetRandomVehicleDensityMultiplierThisFrame(0.0)
	    	SetParkedVehicleDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
			ClearAreaOfEverything(GetEntityCoords(GetPlayerPed(-1)), 150, 0, 0, 0, 0)
		elseif pasDePnjEnt then
			SetVehicleDensityMultiplierThisFrame(0.0)
	    	SetPedDensityMultiplierThisFrame(0.0)
	    	SetRandomVehicleDensityMultiplierThisFrame(0.0)
	    	SetParkedVehicleDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
			ClearAreaOfEverything(GetEntityCoords(GetPlayerPed(-1)), 150, 0, 0, 0, 0)
		else
        	SetVehicleDensityMultiplierThisFrame(0.1)
	    	SetPedDensityMultiplierThisFrame(0.1)
	    	SetRandomVehicleDensityMultiplierThisFrame(0.1)
	    	SetParkedVehicleDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		end
    end
end)

function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false
	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		SetWeaponDrops()
		DisablePlayerVehicleRewards(iPlayerID)
		for k,v in pairs(zoneDouane) do
			local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.co, false)
			if dst <= v.dst then
				pasDePnj = true
				break
			else
				pasDePnj = false
			end
		end

		if #GetActivePlayers() >= 75 then
			pasDePnj = true
		end
	end
end)
GetPeds = function(ignoreList)
	local ignoreList = ignoreList or {}
	local peds       = {}
	for ped in EnumeratePeds() do
		local found = false
		for j=1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end
	return peds
end

local OwnedEntity = 0
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(10*1000)
		for v in EnumeratePeds() do
            if NetworkGetEntityOwner(v) == GetPlayerIndex() then
                OwnedEntity = OwnedEntity + 1
            end
        end
        for v in EnumeratePickups() do
            if NetworkGetEntityOwner(v) == GetPlayerIndex() then
                OwnedEntity = OwnedEntity + 1
            end
        end
        for v in EnumerateVehicles() do
            if NetworkGetEntityOwner(v) == GetPlayerIndex() then
                OwnedEntity = OwnedEntity + 1
            end
        end
        for v in EnumerateObjects() do
            if NetworkGetEntityOwner(v) == GetPlayerIndex() then
                OwnedEntity = OwnedEntity + 1
            end
        end
        if OwnedEntity >= 2000 then
            pasDePnjEnt = true
        end
        OwnedEntity = 0
    end
end)

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end
Citizen.CreateThread(function()
    for i = 1, 12 do
        EnableDispatchService(i, false)
    end
    while true do
        Wait(1000)
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
    end
end)

-- AFK Camera
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- The idle camera activates after 30 second so we don't need to call this per frame
        N_0xf4f2c0d4ee209e20() -- Disable the pedestrian idle camera
        N_0x9e4cfff989258472() -- Disable the vehicle idle camera
    end
end)

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(100)       
    RemovePedHelmet(GetVehiclePedIsUsing(GetPlayerPed(-1)),true) end  
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
		RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))
	end
end)

--enleve vehicule exploser
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10) -- [[Usually 1 however the difference between the two is un-noticable.]]
        for theveh in EnumerateVehicles() do -- [[Gets every single vehicle that exists... I think.]]
            if GetEntityHealth(theveh) == 0 then -- [[If the vehicle is destroyed continue.]]
                SetEntityAsMissionEntity(theveh, false, false) -- [[Sets the entity as mission entity for further use.]]
                DeleteEntity(theveh) -- [[Once set as mission entity it will be deleted.]]
            end
		end
    end
end)

--regulation vitesses voiture
Citizen.CreateThread(function() 
	local headId = {}
	while true do
		Citizen.Wait(1000)
		ped = GetPlayerPed(-1)
		if IsPedSittingInAnyVehicle(ped) then
			local veh = GetVehiclePedIsIn(ped, false)
			local vehClass = GetVehicleClass(veh)
			if vehClass == 7 then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 20.0)
			elseif vehClass == 6 then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 13.0)
			elseif vehClass == 5 then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 7.0)
			elseif vehClass == 8 then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 4.0)
				-- LSPD / EMS
			elseif vehClass == 18 then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(GetPlayerPed(-1), false), 2.0 * 20.0)
			elseif vehClass == 16 then
				SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(ped, false), 2.0 * 500.0)
			end
		end
	end
end)