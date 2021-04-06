local vocalLevel = 2

AddEventHandler('onClientMapStart', function()
	vocalLevel = 2
	NetworkSetTalkerProximity(5.001)
end)

function ShowNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local keyPressed = false
local once = true

local boost = 0.0

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if once then
			once = false
			NetworkSetVoiceActive(1)
			NetworkSetTalkerProximity(5.001)
		end
		while IsControlPressed(1, 56) and keyPressed do
			Wait(10)
		end
		if IsControlPressed(1, 56) and not keyPressed then
			keyPressed = true
			vocalLevel = vocalLevel + 1
			if vocalLevel > 3 then
				vocalLevel = 1
			end
			if vocalLevel == 1 then
				NetworkClearVoiceChannel()
				ShowNotif("Le niveau de votre voix a été réglé sur ~h~~b~Faible")
				NetworkSetTalkerProximity(3.001)
				boost = -0.3
			elseif vocalLevel == 2 then
				NetworkClearVoiceChannel()
				ShowNotif("Le niveau de votre voix a été réglé sur ~h~~g~Normal")
				NetworkSetTalkerProximity(5.001)
				boost = 0.0
			elseif vocalLevel == 3 then
				NetworkClearVoiceChannel()
				ShowNotif("L'intensité de votre voix a été réglé sur ~h~~r~Elevé")
				NetworkSetTalkerProximity(6.001)
				boost = 0.5
			end
			Wait(200)
		elseif not IsControlPressed(1, 56) and keyPressed then
			keyPressed = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		if vocalLevel == 1 then
			NetworkClearVoiceChannel()
			NetworkSetTalkerProximity(4.0)
		elseif vocalLevel == 2 then
			NetworkClearVoiceChannel()
			NetworkSetTalkerProximity(6.0)
		elseif vocalLevel == 3 then
			NetworkClearVoiceChannel()
			NetworkSetTalkerProximity(8.0)
		end	
	end
end)


--Citizen.CreateThread(function()
--	wait = 100
--	NetworkClearVoiceProximityOverride()
--	while true do
--		local pPed = GetPlayerPed(-1)
--		local players = GetActivePlayers()
--		if #players > 10 then
--			wait = 500 + #players
--		else
--			wait = 100
--		end
--		for k,v in pairs(players) do
--			if v ~= PlayerId() then
--				local oPed = GetPlayerPed(v)
--				local dst = GetDistanceBetweenCoords(GetEntityCoords(pPed), GetEntityCoords(oPed), true)
--				volume = 1.0 - (dst/10)
--				volume = volume - 0.1
--				if vocalLevel == 1 then
--					MumbleSetVolumeOverride(v, volume - 0.3)
--				elseif vocalLevel == 2 then
--					MumbleSetVolumeOverride(v, volume)
--				elseif vocalLevel == 3 then
--					MumbleSetVolumeOverride(v, volume + 0.5)
--				end
--			end
--		end
--		Citizen.Wait(wait)
--	end
--end)
--
--local playersNumSave = 0
--Citizen.CreateThread(function()
--	while true do
--		channel = 0
--		local players = GetActivePlayers()
--		local pPed = GetPlayerPed(-1)
--		for k,v in pairs(players) do
--			local oPed = GetPlayerPed(v)
--			local dst = GetDistanceBetweenCoords(GetEntityCoords(pPed), GetEntityCoords(oPed), true)
--			if dst <= 11.0 then
--				channel = channel + 1
--			end
--		end
--		local target = false
--		--print(playersNumSave.." - "..#players.." - Channel: "..channel)
--		if playersNumSave ~= #players then
--			playersNumSave = #players
--			target = true
--		else
--			target = false
--		end
--		if target then
--			MumbleClearVoiceTarget(channel)
--			MumbleSetVoiceTarget(channel)
--			MumbleAddVoiceTargetPlayer(channel, PlayerId())
--		end
--		for k,v in pairs(players) do
--			if v ~= PlayerId() then
--				if target then
--					MumbleAddVoiceTargetPlayer(channel, v)
--				end
--			end
--		end
--
--		Citizen.Wait(3000)
--	end
--end)