local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Récolte-Bitcoin", colour=46, id=490, x = 1276.0, y = -1723.0, z = 55.0},
     {title="Vente-Bitcoin", colour=18, id=521, x = 718.0, y = -978.0, z = 25.0}
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.1)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)