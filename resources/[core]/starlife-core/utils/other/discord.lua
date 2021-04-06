ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
	while true do
        Citizen.Wait(300)
        
        local name = GetPlayerName(PlayerId())
        local id = GetPlayerServerId(PlayerId())
	    --[[ local onlineplayers = 0
        ESX.TriggerServerCallback('infinity:getPlayersInfos', function(ply)
        	onlineplayers = ply.Count
		    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~y~StarLife v3 ~t~| ~b~ID: ' .. id .. ' ~t~| ~t~ ~b~Nom: ~b~' .. name .. " ~t~| ~r~Joueurs: " .. onlineplayers .. "/256")
        end) ]]
	    players = {}
        
        for _,player in ipairs(GetActivePlayers()) do
            table.insert(players, player)
        end
	    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~y~SweetyLife v3 ~t~| ~b~ID: ' .. id .. ' ~t~| ~t~ ~b~Nom: ~b~' .. name .. " ~t~| ~r~Joueurs: " .. #players .. "/64")

        -- Game > Disconnect
        AddTextEntry('PM_PANE_LEAVE', '~p~Se déconnecter de SweetyLife');
        -- Game > Quit
        AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');
        
    end
end)