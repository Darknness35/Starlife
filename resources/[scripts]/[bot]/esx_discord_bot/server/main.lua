ESX = nil

TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)

local DISCORD_WEBHOOK = "https://discordapp.com/api/webhooks/689952281495601227/7zhSvkLLoPODf-enOlHLKfvw-mTD-FbT16MFpaACNnCnNVEBnSaX2MVjSI203aBW3wgc"
local CHAT_WEBHOOK = "https://discordapp.com/api/webhooks/689952281495601227/7zhSvkLLoPODf-enOlHLKfvw-mTD-FbT16MFpaACNnCnNVEBnSaX2MVjSI203aBW3wgc"
local CHEAT_WEBHOOK = "https://discordapp.com/api/webhooks/689952281495601227/7zhSvkLLoPODf-enOlHLKfvw-mTD-FbT16MFpaACNnCnNVEBnSaX2MVjSI203aBW3wgc"
local ADMIN_WEBHOOK = "https://discordapp.com/api/webhooks/689952281495601227/7zhSvkLLoPODf-enOlHLKfvw-mTD-FbT16MFpaACNnCnNVEBnSaX2MVjSI203aBW3wgc"
local DEATH_WEBHOOK = "https://discordapp.com/api/webhooks/675748905316646957/WI1jKcrVugCHzdrrHvvLlEVKerpFNB-DVMnaAcO1TV3TCI-IBUEQ4d4CtqCDXzIAiujU"
local GIVE_WEBHOOK = "https://discordapp.com/api/webhooks/695988545784905779/Cg_yXiFF7e_RaO7xsWCuwQ_YgwsS_f51tOpAn3JNAN_qOT4TcAw_cuOwokGADa8IHwCf"
local REPORT_WEBHOOK = "https://discordapp.com/api/webhooks/689952281495601227/7zhSvkLLoPODf-enOlHLKfvw-mTD-FbT16MFpaACNnCnNVEBnSaX2MVjSI203aBW3wgc"
local CONNEXION_WEBHOOK ="https://discordapp.com/api/webhooks/695985812701053018/3mT1es0snFlW65fbKHUm9ymaS4IpF0s1ApMC8WLneTSWINQFe-jTpJdbqm6arxTN0hAM"
local FOUILLE_WEBHOOK = "https://discordapp.com/api/webhooks/683010313439674380/2W3nF5Af-wRc6GJmhu-aE4DF2GiRzDTabt-Ulhh2vUq-EyKLFJogLR_vpSnJCDRQi2yc"
local STAFF_WEBHOOK = "https://discordapp.com/api/webhooks/695991566006878288/WuHSgiEOWbUhvP1e1gOaXPv_DMdlzVmfH4W3jH7RxvbOdhsJneG6uq6GmHrqdrm6Z-FL"
local DISCORD_NAME = "StarLife"
local STEAM_KEY = ""
local DISCORD_IMAGE = ""

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = Config.webhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,  
        ["footer"]=  {
        ["text"]= "StarLife - AYZN",
       },
      ["fields"]=  {
        {
          ["name"]="Comment Se Connecter :",
          ["value"]="connect cfx.re/join/zjrey5"
        }
      },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordConnect(name, message, color, webhook)
	webhook = CONNEXION_WEBHOOK
	local ip = GetPlayerEndpoint(source)
	local steamhex = GetPlayerIdentifier(source)

	local connect = {
		{
			["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message.."\n**IP:** "..ip.."\n**Steam Hex:** "..steamhex.."\n**ID:** "..source,
            ["footer"] = {
				["text"] = "StarLife - By AYZN",
            },
        }
    }
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordAdmin (name,message,color)
  local DiscordWebHookAdmin = Config.webhookadmin
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
        ["text"]= "StarLife - AYZN",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHookAdmin, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordGive (name,message,color)
  local webhook = GIVE_WEBHOOK
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
        ["text"]= "StarLife - AYZN",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordFouille (name,message,color)
  local webhook = FOUILLE_WEBHOOK
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
        ["text"]= "StarLife - AYZN",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


-- Send the first notification
sendToDiscord(_U('server'),_U('server_start'),Config.green)
sendToDiscordAdmin(_U('server'),_U('server_start'),Config.green)

-- Event when a player is writing
AddEventHandler('chatMessage', function(author, color, message)
  if(settings.LogChatServer)then
      local player = ESX.GetPlayerFromId(author)
     sendToDiscordAdmin(_U('server_chat'), player.name .." : "..message,Config.grey)
  end
end)


-- Event when a player is connecting
RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
  local source = source
	if source then
    	sendToDiscordConnect("Connexion", "**" .. GetPlayerName(source) .. "** à rejoint le serveur.", 65280)
    end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	if source then
		local color
		if string.match(reason, "Kicked") then
			color = 16007897
			sendToDiscordConnect("Déconnexion", "**" .. GetPlayerName(source) .. "** à été kick du serveur.\n**Raison:** " .. reason, color)
		elseif string.match(reason, "Banned") then
			color = 16007897
			sendToDiscordConnect("Déconnexion", "**" .. GetPlayerName(source) .. "** à été ban du serveur.\n**Raison:** " .. reason, color)
		else
			color = 16711680
			sendToDiscordConnect("Déconnexion", "**" .. GetPlayerName(source) .. "** à quitté le serveur.\n**Raison:** " .. reason, color)
		end
	end
end)


-- Add event when a player give an item
--  TriggerEvent("esx:giveitemalert",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount) -> ESX_extended
RegisterServerEvent("esx:giveitemalert")
AddEventHandler("esx:giveitemalert", function(name,nametarget,itemname,amount)
    sendToDiscordGive("Give Item",name.." a donner à"..nametarget.." "..amount .." "..itemname,Config.orange)
end)

-- Add event when a player give money
-- TriggerEvent("esx:givemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount) -> ESX_extended
RegisterServerEvent("esx:givemoneyalert")
AddEventHandler("esx:givemoneyalert", function(name,nametarget,amount)
    sendToDiscordGive("Give Argent",name.." ".." a donner à".." "..nametarget.." "..amount .." dollars",Config.orange)
end)

-- Add event when a player give weapon
--  TriggerEvent("esx:giveweaponalert",sourceXPlayer.name,targetXPlayer.name,weaponLabel) -> ESX_extended
RegisterServerEvent("esx:giveweaponalert")
AddEventHandler("esx:giveweaponalert", function(name,nametarget,weaponlabel)
    sendToDiscordGive("Give Arme",name.." ".." a donner à".." "..nametarget.." "..weaponlabel,Config.orange)
end)

--TriggerServerEvent('esx_faction:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
RegisterServerEvent("esx_faction:confiscatePlayerItem")
AddEventHandler("esx_faction:confiscatePlayerItem", function(target, itemType, itemName, amount)
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if itemType == 'item_standard' then
    local label = sourceXPlayer.getInventoryItem(itemName).label
    sendToDiscordFouille("Fouille detectée",sourceXPlayer.name.." ".."a confisqué à".." "..targetXPlayer.name.." "..amount.." "..label,Config.orange)
  end

  if itemType == 'item_account' then
    sendToDiscordFouille("Fouille detectée",sourceXPlayer.name.." ".."a confisqué à".." "..targetXPlayer.name.." "..amount.." $",Config.orange)
  end

  if itemType == 'item_weapon' then
    sendToDiscordFouille("Fouille detectée",sourceXPlayer.name.." ".."a confisqué à".." "..targetXPlayer.name.." x1 "..ESX.GetWeaponLabel(itemName),Config.orange)
  end

end)

-- Event when a player is killing an other one
RegisterServerEvent('SendPlayerDied')
AddEventHandler('SendPlayerDied', function(message)
	local source = source
	if source then
    	sendToDiscordDeath("Death Log", message, 16711680, DEATH_WEBHOOK)
    end
end)

function sendToDiscordDeath(name, message, color, webhook)
	webhook = webhook or DISCORD_WEBHOOK
	local ip = GetPlayerEndpoint(source)
	local steamhex = GetPlayerIdentifier(source)

	local connect = {
		{
			["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message.."\n**IP:** "..ip.."\n**Steam Hex:** "..steamhex.."\n**ID:** "..source,
            ["footer"] = {
				["text"] = "StarLife - By AYZN",
            },
        }
    }
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('SendToDiscord')
AddEventHandler('SendToDiscord', function(source, name, message, color, Type)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		local playergroup = xPlayer.getGroup()
		local ip = GetPlayerEndpoint(source)
		local steamhex = GetPlayerIdentifier(source)

		if playergroup then
			if playergroup == 'superadmin' then
				ip = "regarde pas ici fils de pute"
			else
				ip = GetPlayerEndpoint(source)
			end
		else
			ip = GetPlayerEndpoint(source)
		end
		local connect = {
			{
				["color"] = color,
	            ["title"] = "**".. name .."**",
	            ["description"] = message.."\n**IP:** "..ip.."\n**Steam Hex:** "..steamhex.."\n**ID:** "..source,
	            ["footer"] = {
					["text"] = "StarLife - By AYZN",
	            },
	        }
	    }
	    if Type == "chat" then
			PerformHttpRequest(CHAT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		elseif Type == "cheat" then
			PerformHttpRequest(CHEAT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		elseif Type == "logs" or Type == "" or Type == nil then
			PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		elseif Type == "staff" or Type == "" or Type == nil then
			PerformHttpRequest(STAFF_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		elseif Type == "death" or Type == "" or Type == nil then
			PerformHttpRequest(DEATH_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		elseif Type == "report" or Type == "" or Type == nil then
			PerformHttpRequest(REPORT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
		end
	end
end)