local Animations = {
	{lib = "anim@heists@ornate_bank@chat_manager", anim = "disrupt"},
	{lib = "anim@heists@ornate_bank@chat_manager", anim = "nice_clothes"},
	{lib = "anim@heists@ornate_bank@chat_manager", anim = "no_speak"},
	{lib = "anim@heists@ornate_bank@chat_manager", anim = "not_nice_car"},
	{lib = "gestures@f@standing@casual", anim = "gesture_bye_soft"},
	{lib = "gestures@f@standing@casual", anim = "gesture_why"},
	{lib = "gestures@f@standing@casual", anim = "gesture_hello"},
	{lib = "gestures@f@standing@casual", anim = "gesture_nod_yes_soft"},
	{lib = "gestures@f@standing@casual", anim = "gesture_hand_right"},
	{lib = "gestures@f@standing@casual", anim = "gesture_hand_left"},
}


local isTalk = false
local currentAnim = nil
local clearEnd = false
local enabled = true
local disabled = false
local forceStop = -1

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
    	forceStop = -1
    	if disabled then
    		forceStop = 0
    	end
    	local playerPed = GetPlayerPed(-1)
    	if not enabled or GetSelectedPedWeapon(playerPed) ~= GetHashKey("WEAPON_UNARMED") or IsPedInAnyVehicle(playerPed) or GetEntitySpeed(playerPed) > 1.2 then
    		forceStop = 1
    	end
    	if NetworkIsPlayerTalking(PlayerId()) and not isTalk and forceStop == -1 then
    		if not clearEnd then
    			isTalk = true
    			restartAnim()
    		end
    	elseif (not NetworkIsPlayerTalking(PlayerId()) and isTalk) or forceStop == 1 then
    		clearEnd = true
    		if currentAnim ~= nil then
    			StopAnimTask(GetPlayerPed(-1),currentAnim.lib,currentAnim.anim,2.0)
    		end
    		isTalk = false
    		SetTimeout(500,function()
    			clearEnd = false
    		end)
    	end
    end
end)


local talkingPlayers = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300)
        for k,v in pairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(v)
            --if v ~= PlayerId() then
                if boolTalking and not talkingPlayers[v] then
                    PlayFacialAnim(GetPlayerPed(v), "mic_chatter", "mp_facial")
                    talkingPlayers[v] = true
                elseif not boolTalking and talkingPlayers[v] then
                    PlayFacialAnim(GetPlayerPed(v), "mood_normal_1", "facials@gen_male@variations@normal")
                    talkingPlayers[v] = nil
                end
            --end
        end
    end
end)

local prevKey = 0
function restartAnim()
	
	Citizen.CreateThread(function()
		Wait(500)
		
		local key = math.random(1,#Animations)
		
		while key == prevKey do
			Wait(0)
			key = math.random(1,#Animations)
		end
		
		currentAnim = Animations[key]
        prevKey = key
        
        if not HasAnimDictLoaded(currentAnim.lib) then
            RequestAnimDict(currentAnim.lib)
    
            while not HasAnimDictLoaded(currentAnim.lib) do
                Citizen.Wait(0)
            end
        end
		TaskPlayAnim(GetPlayerPed(-1), currentAnim.lib, currentAnim.anim, 1.5, 1.0, -1, 48, 0.0, 0, 0, 0)
		
		local isPlaying = true
		
		while isPlaying do
			Wait(0)
			isPlaying = IsEntityPlayingAnim(GetPlayerPed(-1),currentAnim.lib,currentAnim.anim,3)
			if not isTalk then
				isPlaying = false
			end
		end
        
        StopAnimTask(GetPlayerPed(-1), currentAnim.lib,currentAnim.anim, 2.0)
		
		local timer = math.random(500,1000)
		
		Wait(timer)
		
		if not isTalk then
			return
		end
		
		restartAnim()
	
	end)
end