ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('infinity:updatePlayers')
AddEventHandler('infinity:updatePlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

function UpdatePlayerTable(connectedPlayers)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerId = xPlayer.source
	local players = 0
	Players = {}

	for k,v in pairs(connectedPlayers) do
		Players.Count = GetNumPlayerIndices()

		Players[playerId]			 = {}
		Players[playerId].id		 = playerId

		Players[playerId].position	 = GetEntityCoords(GetPlayerPed(playerId))
		Players[playerId].heading	 = GetEntityHeading(GetPlayerPed(playerId))

		Players[playerId].steamName  = GetPlayerName(playerId)
		Players[playerId].name  	 = xPlayer.getName()

		Players[playerId].group		 = xPlayer.getGroup()
		Players[playerId].job		 = xPlayer.getJob()
		Players[playerId].faction	 = xPlayer.getFaction()

		players = players + 1
	end

end