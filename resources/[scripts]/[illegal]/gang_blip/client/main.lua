Citizen.CreateThread(function()
	
	for i=1, #Config.Map, 1 do
		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z) 
    	SetBlipSprite (blip, Config.Map[i].id)
    	SetBlipDisplay(blip, 4)
    	SetBlipScale  (blip, 1.0)
    	SetBlipColour (blip, Config.Map[i].color)
    	SetBlipAsShortRange(blip, true)
  		BeginTextCommandSetBlipName("STRING") 
  		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)

		local zoneblip = AddBlipForRadius(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z, 800.0)
		SetBlipSprite(zoneblip,1)
		SetBlipColour(zoneblip,Config.Map[i].color)
		SetBlipAlpha(zoneblip,100)
	end
end)