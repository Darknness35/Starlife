-- Get  Players Identification
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
        firstname = result[1]['firstname'],
        lastname = result[1]['lastname'],
        dateofbirth = result[1]['dateofbirth'],
        sex = result[1]['sex'],
        height = result[1]['height']
      }

      callback(data)
    else
      local data = {
        identifier = '',
        firstname = '',
        lastname = '',
        dateofbirth = '',
        sex = '',
        height = ''
      }

      callback(data)
    end
  end)
end

-- Get Players Identification
function getCharacters(source, callback)
  local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if result[1] then
      local data = {
        identifier = result[1]['identifier'],
        firstname1 = result[1]['firstname'],
        lastname1 = result[1]['lastname'],
        dateofbirth1 = result[1]['dateofbirth'],
        sex1 = result[1]['sex'],
        height1 = result[1]['height'],
      }

      callback(data)
    else
      local data = {
        identifier = '',
        firstname1 = '',
        lastname1 = '',
        dateofbirth1 = '',
        sex1 = '',
        height1 = ''
      }

      callback(data)
    end
  end)
end

-- Players Identification
function setIdentity(identifier, data, callback)
  MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
    {
      ['@identifier'] = identifier,
      ['@firstname'] = data.firstname,
      ['@lastname'] = data.lastname,
      ['@dateofbirth'] = data.dateofbirth,
      ['@sex'] = data.sex,
      ['@height'] = data.height
    },
  function(done)
    if callback then
      callback(true)
    end
  end)
end

-- Update Players Identification
function updateIdentity(identifier, data, callback)
  MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
    {
      ['@identifier'] = identifier,
      ['@firstname'] = data.firstname,
      ['@lastname'] = data.lastname,
      ['@dateofbirth'] = data.dateofbirth,
      ['@sex'] = data.sex,
      ['@height'] = data.height
    },
  function(done)
    if callback then
      callback(true)
    end
  end)
end

-- Server Event Set Identity
RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data)
  local identifier = GetPlayerIdentifiers(source)[1]
    setIdentity(GetPlayerIdentifiers(source)[1], data, function(callback)
      
    if callback == true then
      print('Idendité chargé avec succès ' .. identifier)
    else
      print('Identité non chargé.')
    end
  end)
end)

-- Players Loaded Event
AddEventHandler('es:playerLoaded', function(source)
  getIdentity(source, function(data)
    if data.firstname == '' then
      TriggerClientEvent('esx_identity:showRegisterIdentity', source)
    else
      print('Idendité chargé avec succès ' .. data.firstname .. ' ' .. data.lastname)
    end
  end)
end)

-- Commands
-- /charlist - Show Characters
TriggerEvent('es:addGroupCommand', 'idhelp', "user", function(source, args, user)
  TriggerClientEvent('chatMessage', source, 'IDHelp', {255, 0, 0}, "ESX_IDENTITY Commands")
  TriggerClientEvent('chatMessage', source, 'IDHelp', {255, 0, 0}, "/identite - Enregistrer une nouvelle identité")
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "IDHelp", {255, 0, 0}, "Autorisations insuffisantes!")
end, {help = "List Your Characters"})

-- /identite - Open Registration
TriggerEvent('es:addCommand', 'identite', function(source, args, user)
  getCharacters(source, function(data)
    if data.firstname1 ~= '' then
      TriggerClientEvent('chatMessage', source, 'IDENTITE', {255, 0, 0}, "Vous ne pouvez avoir qu'une seule identité.")
    else
      TriggerClientEvent('esx_identity:showRegisterIdentity', source, {})
    end
  end)
end)