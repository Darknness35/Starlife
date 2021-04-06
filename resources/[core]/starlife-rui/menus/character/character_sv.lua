-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---  TOI DUMPER , AU LIEU DE VOLER DIRECTEMENT MON BEAU TRAVAIL DEMANDE MOI LA  ---
---  PERMISSION SUR DISCORD --> ayznismaybedead#0666 . CAR SI JE TE CHOPE SANS  ---
---  ME DEMANDER , TU ES DANS LE CACA :) ALLER JE TE SOUHAITE UN TRES BON DUMP  ---
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

RegisterServerEvent('ayzn:saveSkin')
AddEventHandler('ayzn:saveSkin', function(skin)
    local source = source
    local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@skin'] = json.encode(skin),
		['@identifier'] = identifier
	})
end)

function getIdentity(source, callback)
    local identifier = GetPlayerIdentifiers(source)[1]
      MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
    {
      ['@identifier'] = identifier
    },
    function(result)
      if result[1]['firstname'] ~= nil then
        local data = {
          identifier = result[1]['identifier'],
          firstname = result[1]['firstname']
        }
  
        callback(data)
      else
        local data = {
          identifier = '',
          firstname = '',
        }
  
        callback(data)
      end
    end)
end

AddEventHandler('es:playerLoaded', function(source)
    getIdentity(source, function(data)
      if data.firstname == '' then
        TriggerClientEvent('character:openCreationMenu', source)
      else
        --ShowAdvancedNotification("StarLife","Bon Jeu !","Je te souhaites une Agréable journée sur ~y~StarLife !","CHAR_MULTIPLAYER",1)
        --PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
      end
    end)
  end)

RegisterNetEvent("ayzn:saveIdentity")
AddEventHandler("ayzn:saveIdentity", function(PrenomIdentity, NomIdentity, TailleIdentity, dateIdentity,SexeIdentity)
    local source = source
    local identifier = GetPlayerIdentifiers(source)[1]

    local PrenomIdentity = PrenomIdentity
    local NomIdentity = NomIdentity
    local TailleIdentity = TailleIdentity
    local dateIdentity = dateIdentity
    local SexeIdentity = SexeIdentity
  
    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		  ['@identifier']		= identifier,
		  ['@firstname']		= PrenomIdentity,
		  ['@lastname']		= NomIdentity,
		  ['@dateofbirth']	= dateIdentity,
		  ['@sex']			= SexeIdentity,
		  ['@height']			= TailleIdentity
	  })
    
end)

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---  TOI DUMPER , AU LIEU DE VOLER DIRECTEMENT MON BEAU TRAVAIL DEMANDE MOI LA  ---
---  PERMISSION SUR DISCORD --> ayznismaybedead#0666 . CAR SI JE TE CHOPE SANS  ---
---  ME DEMANDER , TU ES DANS LE CACA :) ALLER JE TE SOUHAITE UN TRES BON DUMP  ---
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------