ESX = nil

TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('nwx_jobs:getPlayerInventory', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local items = xPlayer.inventory

    cb({
        items = items
    })

end)

ESX.RegisterServerCallback('nwx_jobs:getPlayerInventory2', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local blackMoney = xPlayer.getAccount('black_money').money
    local items = xPlayer.inventory

    cb({
        blackMoney = blackMoney,
        items = items
    })
end)

-- Avocat
if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'avocat', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'avocat', 'Client Avocat', true, true)
TriggerEvent('esx_society:registerSociety', 'avocat', 'Avocat', 'society_avocat', 'society_avocat', 'society_avocat', { type = 'private' })

RegisterServerEvent('nwx_avocat:annonceAvocat')
AddEventHandler('nwx_avocat:annonceAvocat', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_avocat:annonceAvocat', xPlayers[i], text)
    end

    Citizen.Wait(10000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_avocat:annonceAvocatstop', xPlayers[i])
    end

end)

-- Journalist
if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'journalist', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'journalist', 'Client FlashNews', true, true)
TriggerEvent('esx_society:registerSociety', 'journalist', 'FlashNews', 'society_journalist', 'society_journalist', 'society_journalist', { type = 'private' })

RegisterServerEvent('nwx_journalist:annonceJournalist')
AddEventHandler('nwx_journalist:annonceJournalist', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_journalist:annonceJournalist', xPlayers[i], text)
    end

    Citizen.Wait(10000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_journalist:annonceJournaliststop', xPlayers[i])
    end

end)

-- Taxi
if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'taxi', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'taxi', 'Client Taxi', true, true)
TriggerEvent('esx_society:registerSociety', 'taxi', 'Taxi', 'society_taxi', 'society_taxi', 'society_taxi', { type = 'public' })

RegisterServerEvent('nwx_taxi:successTaxi')
AddEventHandler('nwx_taxi:successTaxi', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= 'taxi' then
        print(('nwx_taxi: %s attempted to trigger success!'):format(xPlayer.identifier))
        return
    end

    math.randomseed(os.time())

    local total = math.random(ConfigJob.NPCTaxiJobEarnings.min, ConfigJob.NPCTaxiJobEarnings.max)
    local societyAccount

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
        societyAccount = account
    end)

    if societyAccount then
        local societyMoney = ESX.Math.Round(total / 100 * 50)

        societyAccount.addMoney(societyMoney)

        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ' .. societyMoney .. ' ~g~$~s~', societyMoney)
    end

end)


-- Palace
if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'palace', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'palace', 'Client Palace', true, true)
TriggerEvent('esx_society:registerSociety', 'palace', 'Palace', 'society_palace', 'society_palace', 'society_palace', { type = 'private' })

RegisterServerEvent('nwx_palace:annoncePalace')
AddEventHandler('nwx_palace:annoncePalace', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_palace:annoncePalace', xPlayers[i], text)
    end

    Citizen.Wait(10000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_palace:annoncePalacestop', xPlayers[i])
    end

end)

-- Daymson
PlayersHarvestingDaymson = {}
PlayersCraftingDaymson = {}
PlayersSellingDaymson = {}
local cddaym = 1

if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'daymson', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'daymson', 'Client Daymson', true, true)
TriggerEvent('esx_society:registerSociety', 'daymson', 'Daymson', 'society_daymson', 'society_daymson', 'society_daymson', { type = 'private' })

RegisterServerEvent('nwx_daymson:annonceDaymson')
AddEventHandler('nwx_daymson:annonceDaymson', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_daymson:annonceDaymson', xPlayers[i], text)
    end

    Citizen.Wait(8000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_daymson:annoncestopDaymson', xPlayers[i])
    end

end)

-- Récupération cd vierge
local function HarvestDaymson(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersHarvestingDaymson[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local CdviergeQuantity = xPlayer.getInventoryItem('cdvierge').count

            if CdviergeQuantity >= 50 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place~s~')
            else
                xPlayer.addInventoryItem('cdvierge', 5)
                HarvestDaymson(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_daymson:startHarvestDaymson')
AddEventHandler('nwx_daymson:startHarvestDaymson', function()
    local _source = source
    PlayersHarvestingDaymson[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération des ~b~cd vierge~s~...')
    HarvestDaymson(_source)
end)

RegisterServerEvent('nwx_daymson:stopHarvestDaymson')
AddEventHandler('nwx_daymson:stopHarvestDaymson', function()
    local _source = source
    PlayersHarvestingDaymson[_source] = false
end)

-- Gravure CD
local function CraftDaymson(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingDaymson[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local CdviergeQuantity = xPlayer.getInventoryItem('cdvierge').count

            if CdviergeQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de cd vierge !')
            else
                xPlayer.removeInventoryItem('cdvierge', 5)
                xPlayer.addInventoryItem('cddaym', 5)

                CraftDaymson(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_daymson:startCraftDaymson')
AddEventHandler('nwx_daymson:startCraftDaymson', function()
    local _source = source
    PlayersCraftingDaymson[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Gravure en ~g~cours~s~...')
    CraftDaymson(_source)
end)

RegisterServerEvent('nwx_daymson:stopCraftDaymson')
AddEventHandler('nwx_daymson:stopCraftDaymson', function()
    local _source = source
    PlayersCraftingDaymson[_source] = false
end)

-- Vente des cd
local function SellDaymson(source, zone)

    if PlayersSellingDaymson[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'DaymsonSellFarm' then
            if xPlayer.getInventoryItem('cddaym').count <= 5 then
                cddaym = 0
            else
                cddaym = 1
            end

            if cddaym == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de cd a vendre.')
                return
            elseif xPlayer.getInventoryItem('cddaym').count <= 5 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de cd a vendre.')
                cddaym = 0
                return
            else
                if (cddaym == 1) then
                    SetTimeout(4000, function()
                        local money = math.random(7, 13)
                        xPlayer.removeInventoryItem('cddaym', 5)

                        local societyAccount
                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_daymson', function(account)
                            societyAccount = account
                        end)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ~g~$' .. money)
                        SellDaymson(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_daymson:startSellDaymson')
AddEventHandler('nwx_daymson:startSellDaymson', function(zone)

    local _source = source

    if PlayersSellingDaymson[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingDaymson[_source] = false
    else
        PlayersSellingDaymson[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellDaymson(_source, zone)
    end

end)

RegisterServerEvent('nwx_daymson:stopSellDaymson')
AddEventHandler('nwx_daymson:stopSellDaymson', function()

    local _source = source

    if PlayersSellingDaymson[_source] == true then
        PlayersSellingDaymson[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingDaymson[_source] = true
    end

end)


-- Tabac
PlayersHarvestingTabac = {}
PlayersCraftingTabac = {}
PlayersCraftingTabac2 = {}
PlayersCraftingTabac3 = {}
PlayersSellingTabac = {}
PlayersSellingTabac2 = {}
local feuilletabac = 1
local tabacsec = 1
local malbora = 1
local cigar = 1

if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'tabac', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'tabac', 'Client Malborose', true, true)
TriggerEvent('esx_society:registerSociety', 'tabac', 'Tabac', 'society_tabac', 'society_tabac', 'society_tabac', { type = 'private' })

RegisterServerEvent('nwx_tabac:annonceTabac')
AddEventHandler('nwx_tabac:annonceTabac', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_tabac:annonceTabac', xPlayers[i], text)
    end

    Citizen.Wait(8000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_tabac:annoncestopTabac', xPlayers[i])
    end

end)

-- Récupération des feuilles de tabac
local function HarvestTabac(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersHarvestingTabac[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local FeuilleTabacQuantity = xPlayer.getInventoryItem('feuilletabac').count

            if FeuilleTabacQuantity >= 100 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place~s~')
            else
                xPlayer.addInventoryItem('feuilletabac', 5)
                HarvestTabac(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_tabac:startHarvestTabac')
AddEventHandler('nwx_tabac:startHarvestTabac', function()
    local _source = source
    PlayersHarvestingTabac[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération des ~b~feuilles de tabac~s~...')
    HarvestTabac(_source)
end)

RegisterServerEvent('nwx_tabac:stopHarvestTabac')
AddEventHandler('nwx_tabac:stopHarvestTabac', function()
    local _source = source
    PlayersHarvestingTabac[_source] = false
end)

-- Séchage du tabac
local function CraftTabac(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingTabac[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local FeuilleTabacQuantity = xPlayer.getInventoryItem('feuilletabac').count

            if FeuilleTabacQuantity <= 1 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de feuille de tabac !')
            else
                xPlayer.removeInventoryItem('feuilletabac', 2)
                xPlayer.addInventoryItem('tabacsec', 1)

                CraftTabac(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_tabac:startCraftTabac')
AddEventHandler('nwx_tabac:startCraftTabac', function()
    local _source = source
    PlayersCraftingTabac[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Séchage en ~g~cours~s~...')
    CraftTabac(_source)
end)

RegisterServerEvent('nwx_tabac:stopCraftTabac')
AddEventHandler('nwx_tabac:stopCraftTabac', function()
    local _source = source
    PlayersCraftingTabac[_source] = false
end)

-- Tabac sec en cigarette
local function CraftTabac2(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingTabac2[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local TabacSecQuantity = xPlayer.getInventoryItem('tabacsec').count

            if TabacSecQuantity <= 1 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de tabac sec !')
            else
                xPlayer.removeInventoryItem('tabacsec', 2)
                xPlayer.addInventoryItem('malbora', 1)

                CraftTabac2(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_tabac:startCraftTabac2')
AddEventHandler('nwx_tabac:startCraftTabac2', function()
    local _source = source
    PlayersCraftingTabac2[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Assemblage ~g~en cours~s~...')
    CraftTabac2(_source)
end)

RegisterServerEvent('nwx_tabac:stopCraftTabac2')
AddEventHandler('nwx_tabac:stopCraftTabac2', function()
    local _source = source
    PlayersCraftingTabac2[_source] = false
end)

-- Tabac sec en cigar
local function CraftTabac3(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingTabac3[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local TabacSecQuantity = xPlayer.getInventoryItem('tabacsec').count

            if TabacSecQuantity <= 2 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de tabac sec !')
            else
                xPlayer.removeInventoryItem('tabacsec', 3)
                xPlayer.addInventoryItem('cigar', 1)

                CraftTabac3(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_tabac:startCraftTabac3')
AddEventHandler('nwx_tabac:startCraftTabac3', function()
    local _source = source
    PlayersCraftingTabac3[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Assemblage ~g~en cours~s~...')
    CraftTabac3(_source)
end)

RegisterServerEvent('nwx_tabac:stopCraftTabac3')
AddEventHandler('nwx_tabac:stopCraftTabac3', function()
    local _source = source
    PlayersCraftingTabac3[_source] = false
end)

-- Vente des cigarettes
local function SellTabac(source, zone)

    if PlayersSellingTabac[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'TabacSellFarm' then
            if xPlayer.getInventoryItem('malbora').count <= 1 then
                malbora = 0
            else
                malbora = 1
            end

            if malbora == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de cigarettes a vendre.')
                return
            elseif xPlayer.getInventoryItem('malbora').count <= 1 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de cigarettes a vendre.')
                malbora = 0
                return
            else
                if (malbora == 1) then
                    SetTimeout(5000, function()
                        local money = math.random(90, 140)
                        xPlayer.removeInventoryItem('malbora', 2)
                        local societyAccount

                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
                            societyAccount = account
                        end)
                        if societyAccount ~= nil then
                            societyAccount.addMoney(50)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ~g~$' .. money)
                        end
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez gagné ~g~2$~s~')
                        SellTabac(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_tabac:startSellTabac')
AddEventHandler('nwx_tabac:startSellTabac', function(zone)

    local _source = source

    if PlayersSellingTabac[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingTabac[_source] = false
    else
        PlayersSellingTabac[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellTabac(_source, zone)
    end

end)

RegisterServerEvent('nwx_tabac:stopSellTabac')
AddEventHandler('nwx_tabac:stopSellTabac', function()

    local _source = source

    if PlayersSellingTabac[_source] == true then
        PlayersSellingTabac[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingTabac[_source] = true
    end

end)

-- Vente des cigarettes
local function SellTabac2(source, zone)

    if PlayersSellingTabac2[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'TabacSellFarm2' then
            if xPlayer.getInventoryItem('cigar').count <= 1 then
                cigar = 0
            else
                cigar = 1
            end

            if cigar == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de cigarettes a vendre.')
                return
            elseif xPlayer.getInventoryItem('cigar').count <= 1 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de cigarettes a vendre.')
                cigar = 0
                return
            else
                if (cigar == 1) then
                    SetTimeout(5000, function()
                        local money = math.random(120, 160)
                        xPlayer.removeInventoryItem('cigar', 2)
                        local societyAccount

                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_tabac', function(account)
                            societyAccount = account
                        end)
                        if societyAccount ~= nil then
                            societyAccount.addMoney(50)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ~g~$' .. money)
                        end
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez gagné ~g~4$~s~')
                        SellTabac2(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_tabac:startSellTabac2')
AddEventHandler('nwx_tabac:startSellTabac2', function(zone)
    local _source = source

    if PlayersSellingTabac2[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingTabac2[_source] = false
    else
        PlayersSellingTabac2[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellTabac2(_source, zone)
    end

end)

RegisterServerEvent('nwx_tabac:stopSellTabac2')
AddEventHandler('nwx_tabac:stopSellTabac2', function()
    local _source = source

    if PlayersSellingTabac2[_source] == true then
        PlayersSellingTabac2[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingTabac2[_source] = true
    end

end)


-- Vigneron
PlayersHarvestingVigneron = {}
PlayersCraftingVigneron = {}
PlayersCraftingVigneron2 = {}
PlayersSellingVigneron = {}
PlayersSellingVigneron2 = {}
local raisin = 1
local jusraisin = 1
local vin = 1

if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'vigneron', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'vigneron', 'Client Vigneron', true, true)
TriggerEvent('esx_society:registerSociety', 'vigneron', 'Vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', { type = 'private' })

RegisterServerEvent('nwx_vigneron:annonceVigneron')
AddEventHandler('nwx_vigneron:annonceVigneron', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_vigneron:annonceVigneron', xPlayers[i], text)
    end

    Citizen.Wait(8000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_vigneron:annoncestopVigneron', xPlayers[i])
    end

end)

-- Récupération du raisin
local function HarvestVigneron(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersHarvestingVigneron[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local RaisinQuantity = xPlayer.getInventoryItem('raisin').count

            if RaisinQuantity >= 100 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place~s~')
            else
                xPlayer.addInventoryItem('raisin', 5)
                HarvestVigneron(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_vigneron:startHarvestVigneron')
AddEventHandler('nwx_vigneron:startHarvestVigneron', function()
    local _source = source
    PlayersHarvestingVigneron[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération du ~b~raisin~s~...')
    HarvestVigneron(_source)
end)

RegisterServerEvent('nwx_vigneron:stopHarvestVigneron')
AddEventHandler('nwx_vigneron:stopHarvestVigneron', function()
    local _source = source
    PlayersHarvestingVigneron[_source] = false
end)

-- Raisin en Jus de raisin
local function CraftVigneron(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingVigneron[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local RaisinQuantity = xPlayer.getInventoryItem('raisin').count

            if RaisinQuantity <= 1 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de raisin !')
            else
                xPlayer.removeInventoryItem('raisin', 2)
                xPlayer.addInventoryItem('jusraisin', 1)

                CraftVigneron(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_vigneron:startCraftVigneron')
AddEventHandler('nwx_vigneron:startCraftVigneron', function()
    local _source = source
    PlayersCraftingVigneron[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation~s~ en cours..')
    CraftVigneron(_source)
end)

RegisterServerEvent('nwx_vigneron:stopCraftVigneron')
AddEventHandler('nwx_vigneron:stopCraftVigneron', function()
    local _source = source
    PlayersCraftingVigneron[_source] = false
end)

-- Raisin en vin
local function CraftVigneron2(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingVigneron2[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local RaisinQuantity = xPlayer.getInventoryItem('raisin').count

            if RaisinQuantity <= 1 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de raisin !')
            else
                xPlayer.removeInventoryItem('raisin', 4)
                xPlayer.addInventoryItem('vin', 1)

                CraftVigneron2(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_vigneron:startCraftVigneron2')
AddEventHandler('nwx_vigneron:startCraftVigneron2', function()
    local _source = source
    PlayersCraftingVigneron2[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation~s~ en cours..')
    CraftVigneron2(_source)
end)

RegisterServerEvent('nwx_vigneron:stopCraftVigneron2')
AddEventHandler('nwx_vigneron:stopCraftVigneron2', function()
    local _source = source
    PlayersCraftingVigneron2[_source] = false
end)

-- Vente jus de raisin
local function SellVigneron(source, zone)
    if PlayersSellingVigneron[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'VigneronSellFarm' then
            if xPlayer.getInventoryItem('jusraisin').count <= 0 then
                jusraisin = 0
            else
                jusraisin = 1
            end

            if jusraisin == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de jus de raisin a vendre.')
                return
            elseif xPlayer.getInventoryItem('jusraisin').count <= 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de jus de raisin a vendre.')
                jusraisin = 0
                return
            else
                if (jusraisin == 1) then
                    SetTimeout(5000, function()
                        local money = math.random(70, 90)
                        xPlayer.removeInventoryItem('jusraisin', 1)
                        local societyAccount

                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
                            societyAccount = account
                        end)
                        if societyAccount ~= nil then
                            societyAccount.addMoney(50)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ~g~$' .. money)
                        end
                        xPlayer.addMoney(100)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez gagné ~g~2$~s~')
                        SellVigneron(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_vigneron:startSellVigneron')
AddEventHandler('nwx_vigneron:startSellVigneron', function(zone)
    local _source = source

    if PlayersSellingVigneron[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingVigneron[_source] = false
    else
        PlayersSellingVigneron[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellVigneron(_source, zone)
    end

end)

RegisterServerEvent('nwx_vigneron:stopSellVigneron')
AddEventHandler('nwx_vigneron:stopSellVigneron', function()
    local _source = source

    if PlayersSellingVigneron[_source] == true then
        PlayersSellingVigneron[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingVigneron[_source] = true
    end

end)

-- Vente de vin
local function SellVigneron2(source, zone)

    if PlayersSellingVigneron2[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'VigneronSellFarm2' then
            if xPlayer.getInventoryItem('vin').count <= 0 then
                vin = 0
            else
                vin = 1
            end

            if vin == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de vin a vendre.')
                return
            elseif xPlayer.getInventoryItem('vin').count <= 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de vin a vendre.')
                vin = 0
                return
            else
                if (vin == 1) then
                    SetTimeout(5000, function()
                        local money = math.random(80, 120)
                        xPlayer.removeInventoryItem('vin', 1)
                        local societyAccount

                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_vigneron', function(account)
                            societyAccount = account
                        end)
                        if societyAccount ~= nil then
                            societyAccount.addMoney(70)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ~g~$' .. money)
                        end
                        xPlayer.addMoney(120)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez gagné ~g~4$~s~')
                        SellVigneron2(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_vigneron:startSellVigneron2')
AddEventHandler('nwx_vigneron:startSellVigneron2', function(zone)
    local _source = source

    if PlayersSellingVigneron2[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingVigneron2[_source] = false
    else
        PlayersSellingVigneron2[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellVigneron2(_source, zone)
    end

end)

RegisterServerEvent('nwx_vigneron:stopSellVigneron2')
AddEventHandler('nwx_vigneron:stopSellVigneron2', function()
    local _source = source

    if PlayersSellingVigneron2[_source] == true then
        PlayersSellingVigneron2[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingVigneron2[_source] = true
    end

end)


-- Unicorn
PlayersHarvestingUnicorn = {}
PlayersHarvestingUnicorn2 = {}
PlayersCraftingUnicorn = {}
PlayersCraftingUnicorn2 = {}
PlayersCraftingUnicorn3 = {}
PlayersCraftingUnicorn4 = {}

if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'unicorn', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'unicorn', 'Client Unicorn', true, true)
TriggerEvent('esx_society:registerSociety', 'unicorn', 'Unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', { type = 'private' })

RegisterServerEvent('nwx_unicorn:annonceUnicorn')
AddEventHandler('nwx_unicorn:annonceUnicorn', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_unicorn:annonceUnicorn', xPlayers[i], text)
    end

    Citizen.Wait(8000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_unicorn:annoncestopUnicorn', xPlayers[i])
    end

end)

-- Récupération du houblon
local function HarvestUnicorn(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersHarvestingUnicorn[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local HoublonQuantity = xPlayer.getInventoryItem('houblon').count

            if HoublonQuantity >= 50 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place~s~')
            else
                xPlayer.addInventoryItem('houblon', 2)
                HarvestUnicorn(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_unicorn:startHarvestUnicorn')
AddEventHandler('nwx_unicorn:startHarvestUnicorn', function()
    local _source = source
    PlayersHarvestingUnicorn[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération du ~b~houblon~s~...')
    HarvestUnicorn(_source)
end)

RegisterServerEvent('nwx_unicorn:stopHarvestUnicorn')
AddEventHandler('nwx_unicorn:stopHarvestUnicorn', function()
    local _source = source
    PlayersHarvestingUnicorn[_source] = false
end)

-- Récupération malt
local function HarvestUnicorn2(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersHarvestingUnicorn2[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local MaltQuantity = xPlayer.getInventoryItem('malt').count

            if MaltQuantity >= 50 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place~s~')
            else
                xPlayer.addInventoryItem('malt', 2)
                HarvestUnicorn2(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_unicorn:startHarvestUnicorn2')
AddEventHandler('nwx_unicorn:startHarvestUnicorn2', function()
    local _source = source
    PlayersHarvestingUnicorn2[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération du ~b~malt~s~...')
    HarvestUnicorn2(_source)
end)

RegisterServerEvent('nwx_unicorn:stopHarvestUnicorn2')
AddEventHandler('nwx_unicorn:stopHarvestUnicorn2', function()
    local _source = source
    PlayersHarvestingUnicorn2[_source] = false
end)





-- craft bière
local function CraftUnicorn(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingUnicorn[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local HoublonBiereQuantity = xPlayer.getInventoryItem('houblon').count
            local MaltBiereQuantity = xPlayer.getInventoryItem('malt').count
            local LevureBiereQuantity = xPlayer.getInventoryItem('levure').count
            local WaterBiereQuantity = xPlayer.getInventoryItem('water').count

            if HoublonBiereQuantity >= 1 or MaltBiereQuantity >= 1 or LevureBiereQuantity >= 1 or WaterBiereQuantity >= 1 then
				xPlayer.removeInventoryItem('houblon', 2)
				xPlayer.removeInventoryItem('malt', 2)
				xPlayer.removeInventoryItem('levure', 1)
				xPlayer.removeInventoryItem('water', 1)
				xPlayer.addInventoryItem('biere', 1)

				CraftUnicorn(_source)
            else
				TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ les composants nécessaires !')
            end
        end
    end)
end

RegisterServerEvent('nwx_unicorn:startCraftUnicorn')
AddEventHandler('nwx_unicorn:startCraftUnicorn', function()
    local _source = source
    PlayersCraftingUnicorn[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation~s~ en cours..')
    CraftUnicorn(_source)
end)

RegisterServerEvent('nwx_unicorn:stopCraftUnicorn')
AddEventHandler('nwx_unicorn:stopCraftUnicorn', function()
    local _source = source
    PlayersCraftingUnicorn[_source] = false
end)





-- Craft cocktail
local function CraftUnicorn2(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingUnicorn2[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local JusfruitCocktailQuantity = xPlayer.getInventoryItem('jusfruit').count
            local BananeCocktailQuantity = xPlayer.getInventoryItem('banane').count
            local SiropCocktailQuantity = xPlayer.getInventoryItem('sirop').count
            local GlaconCocktailQuantity = xPlayer.getInventoryItem('glacon').count

            if JusfruitCocktailQuantity >= 1 or BananeCocktailQuantity >= 1 or SiropCocktailQuantity >= 1 or GlaconCocktailQuantity >= 1 then
                xPlayer.removeInventoryItem('jusfruit', 1)
                xPlayer.removeInventoryItem('banane', 1)
                xPlayer.removeInventoryItem('sirop', 1)
                xPlayer.removeInventoryItem('glacon', 2)
                xPlayer.addInventoryItem('cocktail', 1)

                CraftUnicorn2(_source)
            else
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ les composants nécessaires !')
            end
        end
    end)
end

RegisterServerEvent('nwx_unicorn:startCraftUnicorn2')
AddEventHandler('nwx_unicorn:startCraftUnicorn2', function()
    local _source = source
    PlayersCraftingUnicorn2[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation~s~ en cours..')
    CraftUnicorn2(_source)
end)

RegisterServerEvent('nwx_unicorn:stopCraftUnicorn2')
AddEventHandler('nwx_unicorn:stopCraftUnicorn2', function()
    local _source = source
    PlayersCraftingUnicorn2[_source] = false
end)




-- Craft mojito
local function CraftUnicorn3(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingUnicorn3[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local RhumMojitoQuantity = xPlayer.getInventoryItem('rhum').count
            local SucrecanneMojitoQuantity = xPlayer.getInventoryItem('sucrecanne').count
            local SiropMojitoQuantity = xPlayer.getInventoryItem('menthe').count
            local CitronMojitoQuantity = xPlayer.getInventoryItem('citron').count
            local WatergMojitoQuantity = xPlayer.getInventoryItem('waterg').count
            local GlaconMojitoQuantity = xPlayer.getInventoryItem('glacon').count

            if RhumMojitoQuantity >= 1 or SucrecanneMojitoQuantity >= 1 or SiropMojitoQuantity >= 1 or CitronMojitoQuantity >= 1 or WatergMojitoQuantity >= 1 or GlaconMojitoQuantity >= 1 then
                xPlayer.removeInventoryItem('rhum', 1)
                xPlayer.removeInventoryItem('sucrecanne', 1)
                xPlayer.removeInventoryItem('menthe', 1)
                xPlayer.removeInventoryItem('citron', 1)
                xPlayer.removeInventoryItem('waterg', 1)
                xPlayer.removeInventoryItem('glacon', 2)
                xPlayer.addInventoryItem('mojito', 1)

                CraftUnicorn3(_source)
            else
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ les composants nécessaires !')
            end
        end
    end)
end

RegisterServerEvent('nwx_unicorn:startCraftUnicorn3')
AddEventHandler('nwx_unicorn:startCraftUnicorn3', function()
    local _source = source
    PlayersCraftingUnicorn3[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation~s~ en cours..')
    CraftUnicorn3(_source)
end)

RegisterServerEvent('nwx_unicorn:stopCraftUnicorn3')
AddEventHandler('nwx_unicorn:stopCraftUnicorn3', function()
    local _source = source
    PlayersCraftingUnicorn3[_source] = false
end)




-- Craft Rhum
local function CraftUnicorn4(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingUnicorn4[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local LevureRhumQuantity = xPlayer.getInventoryItem('levure').count
            local JuscanneRhumQuantity = xPlayer.getInventoryItem('juscanne').count
            local SiropRhumQuantity = xPlayer.getInventoryItem('sirop').count

            if LevureRhumQuantity >= 1 or JuscanneRhumQuantity >= 1 or SiropRhumQuantity >= 1 then
				xPlayer.removeInventoryItem('levure', 1)
				xPlayer.removeInventoryItem('juscanne', 1)
				xPlayer.removeInventoryItem('sirop', 1)
				xPlayer.addInventoryItem('rhum', 1)

				CraftUnicorn4(_source)
            else
				TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ les composants nécessaires !')
            end
        end
    end)
end

RegisterServerEvent('nwx_unicorn:startCraftUnicorn4')
AddEventHandler('nwx_unicorn:startCraftUnicorn4', function()
    local _source = source
    PlayersCraftingUnicorn4[_source] = true
    TriggerClientEvent('esx:showNotification', _source, '~g~Distillation~s~ en cours..')
    CraftUnicorn4(_source)
end)

RegisterServerEvent('nwx_unicorn:stopCraftUnicorn4')
AddEventHandler('nwx_unicorn:stopCraftUnicorn4', function()
    local _source = source
    PlayersCraftingUnicorn4[_source] = false
end)












-- Bucheron
PlayersHarvestingBucheron = {}
PlayersCraftingBucheron = {}
PlayersCraftingBucheron2 = {}
PlayersSellingBucheron = {}
local bois = 1
local planche = 1
local paquetplanche = 1

if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'bucheron', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'bucheron', 'Client Malborose', true, true)
TriggerEvent('esx_society:registerSociety', 'bucheron', 'Bucheron', 'society_bucheron', 'society_bucheron', 'society_bucheron', { type = 'private' })

RegisterServerEvent('nwx_bucheron:annonceBucheron')
AddEventHandler('nwx_bucheron:annonceBucheron', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_bucheron:annonceBucheron', xPlayers[i], text)
    end

    Citizen.Wait(8000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_bucheron:annoncestopBucheron', xPlayers[i])
    end

end)

-- Récupération du bois
local function HarvestBucheron(source)
    local _source = source
    SetTimeout(5000, function()

        if PlayersHarvestingBucheron[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local PlancheToBoisQuantity = xPlayer.getInventoryItem('planche').count
            local PaquetPlancheToBoisQuantity = xPlayer.getInventoryItem('paquetplanche').count
            local HarvestBoisQuantity = xPlayer.getInventoryItem('bois').count

            if PlancheToBoisQuantity >= 1 or PaquetPlancheToBoisQuantity >= 1 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez trop de planches ou paquets de planche sur vous~s~')
            elseif HarvestBoisQuantity >= 5 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous avez trop de bois sur vous~s~')
            else
                xPlayer.addInventoryItem('bois', 1)
                HarvestBucheron(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_bucheron:startHarvestBucheron')
AddEventHandler('nwx_bucheron:startHarvestBucheron', function()
    local _source = source
    PlayersHarvestingBucheron[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération du ~b~bois~s~...')
    HarvestBucheron(_source)
end)

RegisterServerEvent('nwx_bucheron:stopHarvestBucheron')
AddEventHandler('nwx_bucheron:stopHarvestBucheron', function()
    local _source = source
    PlayersHarvestingBucheron[_source] = false
end)

-- Bois en planche
local function CraftBucheron(source)
    local _source = source
    SetTimeout(5000, function()

        if PlayersCraftingBucheron[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local BoisPlancheQuantity = xPlayer.getInventoryItem('bois').count

            if BoisPlancheQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de Bois !')
            else
                xPlayer.removeInventoryItem('bois', 1)
                xPlayer.addInventoryItem('planche', 4)

                CraftBucheron(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_bucheron:startCraftBucheron')
AddEventHandler('nwx_bucheron:startCraftBucheron', function()
    local _source = source
    PlayersCraftingBucheron[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Coupe en ~g~cours~s~...')
    CraftBucheron(_source)
end)

RegisterServerEvent('nwx_bucheron:stopCraftBucheron')
AddEventHandler('nwx_bucheron:stopCraftBucheron', function()
    local _source = source
    PlayersCraftingBucheron[_source] = false
end)

-- Planche en paquet de planche
local function CraftBucheron2(source)
    local _source = source
    SetTimeout(4000, function()

        if PlayersCraftingBucheron2[_source] == true then
            local xPlayer = ESX.GetPlayerFromId(_source)
            local PlanchePaquetQuantity = xPlayer.getInventoryItem('planche').count

            if PlanchePaquetQuantity <= 3 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de planche !')
            else
                xPlayer.removeInventoryItem('planche', 4)
                xPlayer.addInventoryItem('paquetplanche', 1)

                CraftBucheron2(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_bucheron:startCraftBucheron2')
AddEventHandler('nwx_bucheron:startCraftBucheron2', function()
    local _source = source
    PlayersCraftingBucheron2[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Assemblage ~g~en cours~s~...')
    CraftBucheron2(_source)
end)

RegisterServerEvent('nwx_bucheron:stopCraftBucheron2')
AddEventHandler('nwx_bucheron:stopCraftBucheron2', function()
    local _source = source
    PlayersCraftingBucheron2[_source] = false
end)

-- Vente des paquet de planches
local function SellBucheron(source, zone)

    if PlayersSellingBucheron[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'BucheronSellFarm' then
            if xPlayer.getInventoryItem('paquetplanche').count <= 0 then
                paquetplanche = 0
            else
                paquetplanche = 1
            end

            if paquetplanche == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de paquet de planches a vendre.')
                return
            elseif xPlayer.getInventoryItem('paquetplanche').count <= 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de paquet de planches a vendre.')
                paquetplanche = 0
                return
            else
                if (paquetplanche == 1) then
                    SetTimeout(5000, function()
                        xPlayer.removeInventoryItem('paquetplanche', 1)

                        local money = math.random(5, 8)
                        xPlayer.addMoney(money)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez gagné ~g~$' .. money)
                        SellBucheron(source, zone)
                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_bucheron:startSellBucheron')
AddEventHandler('nwx_bucheron:startSellBucheron', function(zone)
    local _source = source

    if PlayersSellingBucheron[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingBucheron[_source] = false
    else
        PlayersSellingBucheron[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellBucheron(_source, zone)
    end

end)

RegisterServerEvent('nwx_bucheron:stopSellBucheron')
AddEventHandler('nwx_bucheron:stopSellBucheron', function()
    local _source = source

    if PlayersSellingBucheron[_source] == true then
        PlayersSellingBucheron[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingBucheron[_source] = true
    end

end)

-- Abatteur
PlayersHarvestingAbatteur = {}
PlayersCraftingAbatteur = {}
PlayersCraftingAbatteur2 = {}
PlayersSellingAbatteur = {}
local bois = 1
local planche = 1
local paquetplanche = 1

if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'abatteur', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'abatteur', 'Client Malborose', true, true)
TriggerEvent('esx_society:registerSociety', 'abatteur', 'Abatteur', 'society_abatteur', 'society_abatteur', 'society_abatteur', { type = 'private' })

RegisterServerEvent('nwx_abatteur:annonceAbatteur')
AddEventHandler('nwx_abatteur:annonceAbatteur', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_abatteur:annonceAbatteur', xPlayers[i], text)
    end

    Citizen.Wait(8000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_abatteur:annoncestopAbatteur', xPlayers[i])
    end

end)

-- Récupération du bois
local function HarvestAbatteur(source)
    local _source = source
    SetTimeout(5000, function()

        if PlayersHarvestingAbatteur[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local BoisQuantity = xPlayer.getInventoryItem('poule').count

            if BoisQuantity >= 5 then
                TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de place~s~')
            else
                xPlayer.addInventoryItem('poule', 1)
                HarvestAbatteur(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_abatteur:startHarvestAbatteur')
AddEventHandler('nwx_abatteur:startHarvestAbatteur', function()
    local _source = source
    PlayersHarvestingAbatteur[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Récupération du ~b~Poulet~s~...')
    HarvestAbatteur(_source)
end)

RegisterServerEvent('nwx_abatteur:stopHarvestAbatteur')
AddEventHandler('nwx_abatteur:stopHarvestAbatteur', function()
    local _source = source
    PlayersHarvestingAbatteur[_source] = false
end)

-- Bois en planche
local function CraftAbatteur(source)
    local _source = source
    SetTimeout(5000, function()

        if PlayersCraftingAbatteur[_source] == true then

            local xPlayer = ESX.GetPlayerFromId(_source)
            local BoisPlancheQuantity = xPlayer.getInventoryItem('poule').count

            if BoisPlancheQuantity <= 0 then
                TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez ~r~pas assez~s~ de Poulet !')
            else
                xPlayer.removeInventoryItem('poule', 2)
                xPlayer.addInventoryItem('viandepoulet', 1)

                CraftAbatteur(_source)
            end
        end
    end)
end

RegisterServerEvent('nwx_abatteur:startCraftAbatteur')
AddEventHandler('nwx_abatteur:startCraftAbatteur', function()
    local _source = source
    PlayersCraftingAbatteur[_source] = true
    TriggerClientEvent('esx:showNotification', _source, 'Coupe en ~g~cours~s~...')
    CraftAbatteur(_source)
end)

RegisterServerEvent('nwx_abatteur:stopCraftAbatteur')
AddEventHandler('nwx_abatteur:stopCraftAbatteur', function()
    local _source = source
    PlayersCraftingAbatteur[_source] = false
end)
-- Vente des paquet de planches
local function SellAbatteur(source, zone)

    if PlayersSellingAbatteur[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)

        if zone == 'AbatteurSellFarm' then
            if xPlayer.getInventoryItem('viandepoulet').count <= 0 then
                paquetplanche = 0
            else
                paquetplanche = 1
            end

            if paquetplanche == 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de paquet de planches a vendre.')
                return
            elseif xPlayer.getInventoryItem('viandepoulet').count <= 0 then
                TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de paquet de planches a vendre.')
                paquetplanche = 0
                return
            else
                if (paquetplanche == 1) then
                    SetTimeout(5000, function()
                        xPlayer.removeInventoryItem('viandepoulet', 1)

                        local moneys = math.random(8, 12)
                        xPlayer.addMoney(moneys)
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez gagné ~g~$' .. moneys)
                        SellAbatteur(source, zone)

                        local money = math.random(6, 10)
                        local societyAccount

                        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_abatteur', function(account)
                            societyAccount = account
                        end)
                        if societyAccount ~= nil then
                            societyAccount.addMoney(money)
                            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Votre société a gagné ~g~$' .. money)
                        end

                    end)
                end

            end
        end
    end
end

RegisterServerEvent('nwx_abatteur:startSellAbatteur')
AddEventHandler('nwx_abatteur:startSellAbatteur', function(zone)

    local _source = source

    if PlayersSellingAbatteur[_source] == false then
        TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
        PlayersSellingAbatteur[_source] = false
    else
        PlayersSellingAbatteur[_source] = true
        TriggerClientEvent('esx:showNotification', _source, 'Vente en cours..')
        SellAbatteur(_source, zone)
    end

end)

RegisterServerEvent('nwx_abatteur:stopSellAbatteur')
AddEventHandler('nwx_abatteur:stopSellAbatteur', function()

    local _source = source

    if PlayersSellingAbatteur[_source] == true then
        PlayersSellingAbatteur[_source] = false
        TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
        PlayersSellingAbatteur[_source] = true
    end

end)

-- Bacars
if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'bacars', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'bacars', 'Client Bacars', true, true)
TriggerEvent('esx_society:registerSociety', 'bacars', 'Bacars', 'society_bacars', 'society_bacars', 'society_bacars', { type = 'private' })

RegisterServerEvent('nwx_bacars:annonceBacars')
AddEventHandler('nwx_bacars:annonceBacars', function(result)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local text = result
    print(text)
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_bacars:annonceBacars', xPlayers[i], text)
    end

    Citizen.Wait(10000)

    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('nwx_bacars:annonceBacarsstop', xPlayers[i])
    end

end)


--- Militaire
if ConfigJob.MaxInService ~= -1 then
    TriggerEvent('esx_service:activateService', 'militaire', ConfigJob.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'militaire', 'Alerte Militaire', true, true)
TriggerEvent('esx_society:registerSociety', 'militaire', 'Militaire', 'society_militaire', 'society_militaire', 'society_militaire', { type = 'public' })

RegisterServerEvent('esx_militairejob:confiscatePlayerItem')
AddEventHandler('esx_militairejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if sourceXPlayer.job.name ~= 'militaire' then
        print(('esx_militairejob: %s attempted to confiscate!'):format(xPlayer.identifier))
        return
    end

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
        local sourceItem = sourceXPlayer.getInventoryItem(itemName)

        -- does the target player have enough in their inventory?
        if targetItem.count > 0 and targetItem.count <= amount then

            -- can the player carry the said amount of x item?
            if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
                TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
            else
                targetXPlayer.removeInventoryItem(itemName, amount)
                sourceXPlayer.addInventoryItem(itemName, amount)
                TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
                TriggerClientEvent('esx:showNotification', target, _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
            end
        else
            TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
        end

    elseif itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney(itemName, amount)

        TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
        TriggerClientEvent('esx:showNotification', target, _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

    elseif itemType == 'item_weapon' then
        if amount == nil then
            amount = 0
        end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon(itemName, amount)

        TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
        TriggerClientEvent('esx:showNotification', target, _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
    end
end)

RegisterServerEvent('esx_militairejob:handcuff')
AddEventHandler('esx_militairejob:handcuff', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'militaire' then
        TriggerClientEvent('esx_militairejob:handcuff', target)
    else
        print(('esx_militairejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
    end
end)

RegisterServerEvent('esx_militairejob:drag')
AddEventHandler('esx_militairejob:drag', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'militaire' then
        TriggerClientEvent('esx_militairejob:drag', target, source)
    else
        print(('esx_militairejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
    end
end)

RegisterServerEvent('esx_militairejob:putInVehicle')
AddEventHandler('esx_militairejob:putInVehicle', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'militaire' then
        TriggerClientEvent('esx_militairejob:putInVehicle', target)
    else
        print(('esx_militairejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
    end
end)

RegisterServerEvent('esx_militairejob:OutVehicle')
AddEventHandler('esx_militairejob:OutVehicle', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == 'militaire' then
        TriggerClientEvent('esx_militairejob:OutVehicle', target)
    else
        print(('esx_militairejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
    end
end)


ESX.RegisterServerCallback('esx_militairejob:getOtherPlayerData', function(source, cb, target)
    if ConfigJob.EnableESXIdentity then
        local xPlayer = ESX.GetPlayerFromId(target)
        local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })

        local firstname = result[1].firstname
        local lastname = result[1].lastname
        local sex = result[1].sex
        local dob = result[1].dateofbirth
        local height = result[1].height

        local data = {
            name = GetPlayerName(target),
            job = xPlayer.job,
            inventory = xPlayer.inventory,
            accounts = xPlayer.accounts,
            weapons = xPlayer.loadout,
            firstname = firstname,
            lastname = lastname,
            sex = sex,
            dob = dob,
            height = height
        }

        TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
            if status ~= nil then
                data.drunk = math.floor(status.percent)
            end
        end)

        if ConfigJob.EnableLicenses then
            TriggerEvent('esx_license:getLicenses', target, function(licenses)
                data.licenses = licenses
                cb(data)
            end)
        else
            cb(data)
        end
    else
        local xPlayer = ESX.GetPlayerFromId(target)

        local data = {
            name = GetPlayerName(target),
            job = xPlayer.job,
            inventory = xPlayer.inventory,
            accounts = xPlayer.accounts,
            weapons = xPlayer.loadout
        }

        TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
            if status then
                data.drunk = math.floor(status.percent)
            end
        end)

        TriggerEvent('esx_license:getLicenses', target, function(licenses)
            data.licenses = licenses
        end)

        cb(data)
    end
end)

ESX.RegisterServerCallback('esx_militairejob:getVehicleFromPlate', function(source, cb, plate)
    MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        if result[1] ~= nil then

            MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier', {
                ['@identifier'] = result[1].owner
            }, function(result2)

                if ConfigJob.EnableESXIdentity then
                    cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
                else
                    cb(result2[1].name, true)
                end

            end)
        else
            cb('Inconnu', false)
        end
    end)
end)

ESX.RegisterServerCallback('esx_militairejob:getArmoryWeapons', function(source, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', 'society_militaire', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        cb(weapons)
    end)
end)

ESX.RegisterServerCallback('esx_militairejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if removeWeapon then
        xPlayer.removeWeapon(weaponName)
    end

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_militaire', function(store)
        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = weapons[i].count + 1
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 1
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_militairejob:removeArmoryWeapon', function(source, cb, weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weaponName, 500)

    TriggerEvent('esx_datastore:getSharedDataStore', 'society_militaire', function(store)

        local weapons = store.get('weapons')

        if weapons == nil then
            weapons = {}
        end

        local foundWeapon = false

        for i = 1, #weapons, 1 do
            if weapons[i].name == weaponName then
                weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
                foundWeapon = true
                break
            end
        end

        if not foundWeapon then
            table.insert(weapons, {
                name = weaponName,
                count = 0
            })
        end

        store.set('weapons', weapons)
        cb()
    end)
end)

ESX.RegisterServerCallback('esx_militairejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
    local xPlayer = ESX.GetPlayerFromId(source)
    local authorizedWeapons, selectedWeapon = ConfigJob.AuthorizedWeaponsMilitaire[xPlayer.job.grade_name]

    for k, v in ipairs(authorizedWeapons) do
        if v.weapon == weaponName then
            selectedWeapon = v
            break
        end
    end

    if not selectedWeapon then
        print(('esx_militairejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
        cb(false)
    else
        -- Weapon
        if type == 1 then
            if xPlayer.getMoney() >= selectedWeapon.price then
                xPlayer.removeMoney(selectedWeapon.price)
                xPlayer.addWeapon(weaponName, 100)

                cb(true)
            else
                cb(false)
            end

            -- Weapon Component
        elseif type == 2 then
            local price = selectedWeapon.components[componentNum]
            local weaponNum, weapon = ESX.GetWeapon(weaponName)

            local component = weapon.components[componentNum]

            if component then
                if xPlayer.getMoney() >= price then
                    xPlayer.removeMoney(price)
                    xPlayer.addWeaponComponent(weaponName, component.name)

                    cb(true)
                else
                    cb(false)
                end
            else
                print(('esx_militairejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
                cb(false)
            end
        end
    end
end)

ESX.RegisterServerCallback('esx_militairejob:buyJobVehicle', function(source, cb, vehicleProps, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

    -- vehicle model not found
    if price == 0 then
        print(('esx_militairejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
        cb(false)
    else
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)

            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
                ['@owner'] = xPlayer.identifier,
                ['@vehicle'] = json.encode(vehicleProps),
                ['@plate'] = vehicleProps.plate,
                ['@type'] = type,
                ['@job'] = xPlayer.job.name,
                ['@stored'] = true
            }, function(rowsChanged)
                cb(true)
            end)
        else
            cb(false)
        end
    end
end)

ESX.RegisterServerCallback('esx_militairejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
    local xPlayer = ESX.GetPlayerFromId(source)
    local foundPlate, foundNum

    for k, v in ipairs(nearbyVehicles) do
        local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = v.plate,
            ['@job'] = xPlayer.job.name
        })

        if result[1] then
            foundPlate, foundNum = result[1].plate, k
            break
        end
    end

    if not foundPlate then
        cb(false)
    else
        MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = foundPlate,
            ['@job'] = xPlayer.job.name
        }, function(rowsChanged)
            if rowsChanged == 0 then
                print(('esx_militairejob: %s has exploited the garage!'):format(xPlayer.identifier))
                cb(false)
            else
                cb(true, foundNum)
            end
        end)
    end

end)

function getPriceFromHash(hashKey, jobGrade, type)
    if type == 'helicopter' then
        local vehicles = ConfigJob.AuthorizedHelicoptersMilitaire[jobGrade]

        for k, v in ipairs(vehicles) do
            if GetHashKey(v.model) == hashKey then
                return v.price
            end
        end
    elseif type == 'car' then
        local vehicles = ConfigJob.AuthorizedVehiclesMilitaire[jobGrade]
        local shared = ConfigJob.AuthorizedVehiclesMilitaire['Shared']

        for k, v in ipairs(vehicles) do
            if GetHashKey(v.model) == hashKey then
                return v.price
            end
        end

        for k, v in ipairs(shared) do
            if GetHashKey(v.model) == hashKey then
                return v.price
            end
        end
    end

    return 0
end

ESX.RegisterServerCallback('esx_militairejob:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.inventory

    cb({ items = items })
end)

AddEventHandler('playerDropped', function()
    -- Save the source in case we lose it (which happens a lot)
    local _source = source

    -- Did the player ever join?
    if _source ~= nil then
        local xPlayer = ESX.GetPlayerFromId(_source)

        -- Is it worth telling all clients to refresh?
        if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'militaire' then
            Citizen.Wait(5000)
            TriggerClientEvent('esx_militairejob:updateBlip', -1)
        end
    end
end)

RegisterServerEvent('esx_militairejob:spawned')
AddEventHandler('esx_militairejob:spawned', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'militaire' then
        Citizen.Wait(5000)
        TriggerClientEvent('esx_militairejob:updateBlip', -1)
    end
end)

RegisterServerEvent('esx_militairejob:forceBlip')
AddEventHandler('esx_militairejob:forceBlip', function()
    TriggerClientEvent('esx_militairejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Citizen.Wait(5000)
        TriggerClientEvent('esx_militairejob:updateBlip', -1)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerEvent('esx_phone:removeNumber', 'militaire')
    end
end)

RegisterServerEvent('esx_militairejob:message')
AddEventHandler('esx_militairejob:message', function(target, msg)
    TriggerClientEvent('esx:showNotification', target, msg)
end)