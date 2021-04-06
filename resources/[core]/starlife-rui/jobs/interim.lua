RMenu.Add('starlife', 'interim', RageUI.CreateMenu("Missions Interim", " "))
RMenu:Get('starlife', 'interim'):SetSubtitle("~b~Missions Interimaires")

zones = {
    missions = vector3(-268.93, -956.245, 30.4),
    Chantier = vector3(-509.94, -1001.59, 22.55),
    jardinier = vector3(-1347.78, 113.09, 55.37),
    mineur = vector3(2831.689, 2798.311, 56.49803),
    bucheron = vector3(-570.853, 5367.214, 69.21643),
}

local travailleZone = {
    --[[ {
        zone = vector3(-509.94, -1001.59, 22.55),
        nom = "Chantier",
        blip = 175,
        couleur = 44,
    },
    {
        zone = vector3(-1347.78, 113.09, 55.37),
        nom = "Golf",
        blip = 109,
        couleur = 43,
    }, ]]
    {
        zone = vector3(2831.689, 2798.311, 56.49803),
        nom = "Mine",
        blip = 477,
        couleur = 70,
    },
    {
        zone = vector3(-570.853, 5367.214, 70.21643),
        nom = "Bucheron",
        blip = 477,
        couleur = 21,
    },
}

Citizen.CreateThread(function()
    for k,v in pairs(travailleZone) do
        local blip = AddBlipForCoord(v.zone)
        SetBlipSprite(blip, v.blip)
        SetBlipScale(blip, 0.8)
        SetBlipShrink(blip, true)
        SetBlipColour(blip, v.couleur)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.nom)
        EndTextCommandSetBlipName(blip)
    end
end)

local metiers = {
--[[     chantier = {
        nom = "Travailler au Chantier",
        desc = "Viens travailler au chantier, avoir des muscles dans les bras est obligatoire ! Pas pour les feignants ! ~g~aucun diplôme demandé.",
        coords = zones.Chantier,
    },
    jardinier = {
        nom = "Nettoyer le Golf",
        desc = "Viens Aider les Jardiniers à Tondre la Pelouse ! Si tu n'aimes pas trop Travailler dans le Mal , Cette Mission est faite pour toi !",
        coords = zones.jardinier,
    }, ]]
    mineur = {
        nom = "Trouver de l'Or",
        desc = "Viens Travailler à la Mine comme un dur ! On trouveras de Or et deviendrons Riche ! Permis de Conduire demandé",
        coords = zones.mine,
    },
    bucheron = {
        nom = "Couper les Arbres",
        desc = "Viens Travailler dans notre sublime Forêt ! Equipement Fourni , être costaud .",
        coords = zones.bucheron,
    },
}

RageUI.CreateWhile(1.0, function()
    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), zones.missions, true)
    if distance <= 2.2 then
        alert("Appuyer sur ~b~E~w~ pour parler avec la Personne.")
        if IsControlJustPressed(1, 51) then
            RageUI.Visible(RMenu:Get('starlife', 'interim'), not RageUI.Visible(RMenu:Get('starlife', 'interim')))
        end
    end

    if RageUI.Visible(RMenu:Get('starlife', 'interim')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()        
            for _,v in pairs(metiers) do
                RageUI.Button(v.nom, v.desc, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        SetNewWaypoint(v.coords)
                        RageUI.Visible(RMenu:Get('starlife', 'interim'), not RageUI.Visible(RMenu:Get('starlife', 'interim')))
                        RageUI.Popup({
                            message = "Vous avez choisis de ~b~"..v.nom.."~w~ ? Je vous ai envoyé les coordonnées GPS sur votre Téléphone. ~g~Bonne Chance !",
                            sound = {
                                audio_name = "BASE_JUMP_PASSED",
                                audio_ref = "HUD_AWARDS",
                            }
                        })
                    end
                end)
            end
        end, function()
            ---Panels
        end)
    end
end, 1)