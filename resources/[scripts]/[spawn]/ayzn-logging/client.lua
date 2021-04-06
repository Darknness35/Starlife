local connecte = false
AddEventHandler("playerSpawned", function()
	if (connecte == false) then
		TriggerServerEvent("starlife-rocade:playerConnected")
		connecte = true
	end
end)