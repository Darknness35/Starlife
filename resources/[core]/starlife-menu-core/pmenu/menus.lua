Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)
------------------------------------------------
--============== INITIALIZE MENU ==============--
------------------------------------------------

------------------------------------------------
--============== MENU SUPERETTE ==============--
------------------------------------------------

local superet = {
    Base = { Title = "Superette" },
    Data = { currentMenu = "~y~Acheter un Produit" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
        -- si vous voulez rajouter un boutton pour close le menu:    self:CloseMenu(true)
            if btn.name == "Sandwich" then
                TriggerServerEvent('RiZie_ShOps:buy', 70, "bread", "Pain")
            elseif btn.name == "Bouteille d'Eau" then
                TriggerServerEvent('RiZie_ShOps:buy', 50, "water", "Eau")
            elseif btn.name == "Téléphone" then
                TriggerServerEvent('RiZie_ShOps:buy', 1200, "phone", "Téléphone")
            end
        end,
    },

    Menu = {
        ["~y~Acheter un Produit"] = {
            b = {
                {name = "Nourriture", ask = "→→", askX = true},
                {name = "Boissons", ask = "→→", askX = true},
                {name = "Multimédia", ask = "→→", askX = true},
            }
        },

        ["nourriture"] = {
            b = {
                {name = "Sandwich", ask = "~y~70$", askX = true},
            }
        },

        ["boissons"] = {
            b = {
                {name = "Bouteille d'Eau", ask = "~y~50$", askX = true},
            }
        },

        ["multimédia"] = {
            b = {
                {name = "Téléphone", ask = "~y~1200$", askX = true},
            }
        },

    }
}

------------------------------------------------
--============== MENU ARMURERIE ==============--
------------------------------------------------
local ammu = {
    Base = { Title = "Armurerie" },
    Data = { currentMenu = "~y~Acheter Une Arme" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
            if btn.name == "Couteau" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 260000, "WEAPON_KNIFE", "Couteau")
                Citizen.Wait(1)
            elseif btn.name == "Batte de Baseball" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 280000, "WEAPON_BAT", "Batte")
                Citizen.Wait(1)
            elseif btn.name == "Bouteille en Verre" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 240000, "WEAPON_BOTTLE", "Bouteille")
                Citizen.Wait(1)
            elseif btn.name == "Poing Américain" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 250000, "WEAPON_KNUCKLE", "Poing Américain")
                Citizen.Wait(1)
            elseif btn.name == "Hachette" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 250000, "WEAPON_HATCHET", "Hachette")
                Citizen.Wait(1)
            elseif btn.name == "Pétoire" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 570000, "WEAPON_SNSPISTOL", "Pétoire")
                Citizen.Wait(1)
            elseif btn.name == "Pistolet" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 555000, "WEAPON_PISTOL", "Pistolet")
                Citizen.Wait(1)
            elseif btn.name == "Pistolet Calibre 50" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 635000, "WEAPON_PISTOL50", "Pistolet Calibre 50")
                Citizen.Wait(1)
            elseif btn.name == "Pistolet Vintage" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 600000, "WEAPON_VINTAGEPISTOL", "Pistolet Vintage")
                Citizen.Wait(1)
            elseif btn.name == "Pistolet Lourd" then
                TriggerServerEvent('RiZie_Ammu:buyweapon', 666000, "WEAPON_HEAVYPISTOL", "Pistolet Lourd")
                Citizen.Wait(1)
            elseif btn.name == "Chargeurs" then
                TriggerServerEvent('RiZie_ShOps:buy', 2500, "clip", "Chargeur")
                Citizen.Wait(1)
            elseif btn.name == "Jumelles" then
                TriggerServerEvent('RiZie_ShOps:buy', 6500, "jumelles", "Jumelles")
                Citizen.Wait(1)
            elseif btn.name == "Silencieux" then
                TriggerServerEvent('RiZie_ShOps:buy', 3750, "silencieux", "Silencieux")
                Citizen.Wait(1)
            elseif btn.name == "Lampe" then
                TriggerServerEvent('RiZie_ShOps:buy', 3750, "flashlight", "Lampe")
                Citizen.Wait(1)
            elseif btn.name == "Poignée" then
                TriggerServerEvent('RiZie_ShOps:buy', 3750, "grip", "Poignée")
                Citizen.Wait(1)
            elseif btn.name == "Skin OR" then
                TriggerServerEvent('RiZie_ShOps:buy', 12500, "yusuf", "Skin d'arme")
                Citizen.Wait(1)
            end
        end,
    },

    Menu = {
        ["~y~Acheter Une Arme"] = {
            b = {
                {name = "Armes Blanches", ask = "→→", askX = true},
                {name = "Armes Létales", ask = "→→", askX = true},
                {name = "Accessoires", ask = "→→", askX = true},
            }
        },

        ["armes blanches"] = {
            b = {
                {name = "Couteau", ask = "~y~260000$", askX = true},
                {name = "Batte de Baseball", ask = "~y~280000$", askX = true},
                {name = "Bouteille en Verre", ask = "~y~240000$", askX = true},
                {name = "Poing Américain", ask = "~y~250000$", askX = true},
                {name = "Hachette", ask = "~y~250000$", askX = true},
            }
        },

        ["armes létales"] = {
            b = {
                {name = "Pistolet", ask = "~y~555000$", askX = true},
                {name = "Pistolet Calibre 50", ask = "~y~635000$", askX = true},
                {name = "Pétoire", ask = "~y~570000$", askX = true},
                {name = "Pistolet Vintage", ask = "~y~600000$", askX = true},
                {name = "Pistolet Lourd", ask = "~y~666000$", askX = true},
            }
        },

        ["accessoires"] = {
            b = {
                {name = "Chargeurs", ask = "~y~2500$", askX = true},
                {name = "Jumelles", ask = "~y~6500$", askX = true},
                {name = "Silencieux", ask = "~y~3750$", askX = true},
                {name = "Lampe", ask = "~y~3750$", askX = true},
                {name = "Poignée", ask = "~y~3750$", askX = true},
                {name = "Skin OR", ask = "~y~12500$", askX = true},
            }
        },
    }
}

------------------------------------------------
--============= MENU POLE EMPLOI =============--
------------------------------------------------

local poleemploi = {
    Base = { Title = "Pôle Emploi" },
    Data = { currentMenu = "~y~Rechercher Un Travail" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
        -- si vous voulez rajouter un boutton pour close le menu:    self:CloseMenu(true)
            if btn.name == "Abatteur" then
                TriggerServerEvent('ayzn_pe:setjob', "abatteur")
            elseif btn.name == "Bucheron" then
                TriggerServerEvent('ayzn_pe:setjob', "bucheron")
            elseif btn.name == "Star Record's" then
                TriggerServerEvent('ayzn_pe:setjob', "daymson")
            elseif btn.name == "Livreur de Pizza" then
                TriggerServerEvent('ayzn_pe:setjob', "pizza")
            elseif btn.name == "Facteur" then
                TriggerServerEvent('ayzn_pe:setjob', "gopostal")
            --elseif btn.name == "Livreur de Marchandises" then
                --TriggerServerEvent('ayzn_pe:setjob', "abatteur")
            elseif btn.name == "Sans Emploi" then
                TriggerServerEvent('ayzn_pe:setjob', "unemployed")
            end
        end,
    },

    Menu = {
        ["~y~Rechercher Un Travail"] = {
            b = {
                {name = "Métiers Farm", ask = "→→", askX = true},
                {name = "Métiers Livraisons", ask = "→→", askX = true},
                {name = "Chômage", ask = "→→", askX = true},
            }
        },

        ["métiers farm"] = {
            b = {
                {name = "Abatteur"},
                {name = "Bucheron"},
                {name = "Star Record's"},
            }
        },

        ["métiers livraisons"] = {
            b = {
                {name = "Livreur de Pizza"},
                {name = "Facteur"},
                --{name = "Livreur de Marchandises"},
            }
        },

        ["chômage"] = {
            b = {
                {name = "Sans Emploi"},
            }
        },

    }
}

------------------------------------------------
--============= MENU AUTO ECOLE ==============--
------------------------------------------------
local autoecole = {
    Base = { Title = "Auto-Ecole" },
    Data = { currentMenu = "~y~Passer Son Permis" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
        -- si vous voulez rajouter un boutton pour close le menu:    self:CloseMenu(true)
            if btn.name == "Permis Voiture" then
                TriggerServerEvent('ayzn_autoecole:addlicense', 10000, "drive")
            elseif btn.name == "Permis Moto" then
                TriggerServerEvent('ayzn_autoecole:addlicense', 8000, "drive_bike")
            elseif btn.name == "Permis Camion" then
                TriggerServerEvent('ayzn_autoecole:addlicense', 6000, "drive_truck")
            end
        end,
    },

    Menu = {
        ["~y~Passer Son Permis"] = {
            b = {
                {name = "Permis Voiture", ask = "~y~10000$", askX = true},
                {name = "Permis Moto", ask = "~y~8000$", askX = true},
                {name = "Permis Camion", ask = "~y~6000$", askX = true},
            }
        },
    }
}



-- MENU LOCATION
local location = {
    Base = { Title = "Location" },
    Data = { currentMenu = "~y~Louer Un Véhicule" },
    Events = {

        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
        -- si vous voulez rajouter un boutton pour close le menu:    self:CloseMenu(true)
            if btn.name == "Blista" then
                TriggerServerEvent('ayzn:buycar',3000)
                spawnCar("blista")
            elseif btn.name == "Faggio" then
                TriggerServerEvent('ayzn:buycar',1500)
                spawnCar("faggio")
            elseif btn.name == "BMX" then
                TriggerServerEvent('ayzn:buycar',750)
                spawnCar("bmw")
            end
        end,
    },

    Menu = {
        ["~y~Louer Un Véhicule"] = {
            b = {
                {name = "Blista", ask = "3000$", askX = true},
                {name = "Faggio", ask = "1500$", askX = true},
                {name = "BMX", ask = "750$", askX = true},
            }
        },

    }
}

spawnCar = function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(10)
    end

    local vehicle = CreateVehicle(car, -255.038, -339.3356, 28.801, 0.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LOCATION")
end

------------------------------------------------
--============== DISPLAY MENUS ===============--
------------------------------------------------

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        for k,v in pairs(Config.Zones) do
            


            for i = 1, #v.Superettes, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Superettes[i].x, v.Superettes[i].y, v.Superettes[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler à Apu')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        CreateMenu(superet) 
                    end
                end
            end




            for i = 1, #v.Armureries, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Armureries[i].x, v.Armureries[i].y, v.Armureries[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler à l\'Armurerier')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        CreateMenu(ammu)
                    end
                end
            end

            for i = 1, #v.Emplois, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Emplois[i].x, v.Emplois[i].y, v.Emplois[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler au Recruteur')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        CreateMenu(poleemploi)
                    end
                end
            end

            for i = 1, #v.AutoEcole, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.AutoEcole[i].x, v.AutoEcole[i].y, v.AutoEcole[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour parler à l\'Examinateur')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        CreateMenu(autoecole)
                    end
                end
            end

            for i = 1, #v.Locations, 1 do
                local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, true)
                if distance < 2.2 then
                    alert('Appuyez sur ~INPUT_CONTEXT~ pour Louer un vehicule')
                    if IsControlJustPressed(1,51) then  -- 51 = E
                        CreateMenu(location)
                    end
                end
            end
        end
    end
end)