Citizen.CreateThread(function()
  while true do
  --#Ceci est l'ID de l'application (remplacez-le par votre propre)
  SetDiscordAppId(723519458718777525)

  --#Ici, vous devrez mettre le nom de l'image pour l'icône "Large".
  SetDiscordRichPresenceAsset('logo_celeste_rp')
      
  --#Ici, vous pouvez ajouter un texte de survol pour l'icône "Large".
  SetDiscordRichPresenceAssetText('SweetyLife-RP')
     
  --#Ici, vous devrez mettre le nom de l'image pour l'icône "small".
  SetDiscordRichPresenceAssetSmall('discord')

  --#Ici, vous pouvez ajouter un texte de survol pour l'icône "small".
  SetDiscordRichPresenceAssetSmallText('discord.gg/TxXZprg8')
  
  --#Merci à @bengold  pour le code du 64 slots
  --#Pour afficher le nombre de joueurs sur 64 il faut ajouter ceci :
  players = {}
  for i = 0, 255 do
      if NetworkIsPlayerActive( i ) then
          table.insert( players, i )
      end
  end
  SetRichPresence(GetPlayerName(PlayerId()) .. " - ".. #players .. "/64 Joueurs en Ville !")

  Citizen.Wait(60000)
  end
end)