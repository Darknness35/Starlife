local hasMinimap = false

function toggleMinimap()

	hasMinimap = not hasMinimap

	if hasMinimap == true then

		DisplayRadar(false)

	else

		DisplayRadar(true)

	end

end



function openCinematique()

	hasCinematic = not hasCinematic

	if not hasCinematic then -- show

		SendNUIMessage({openCinema = true})

		ESX.UI.HUD.SetDisplay(0.0)

		TriggerEvent('es:setMoneyDisplay', 0.0)

		TriggerEvent('esx_status:setDisplay', 0.0)

		DisplayRadar(false)

		TriggerEvent('ui:toggle', false)

	elseif hasCinematic then -- hide

		SendNUIMessage({openCinema = false})

		ESX.UI.HUD.SetDisplay(1.0)

		TriggerEvent('es:setMoneyDisplay', 1.0)

		TriggerEvent('esx_status:setDisplay', 1.0)

		DisplayRadar(true)

		TriggerEvent('ui:toggle', true)

	end

end



local parametresmenu = {

    Base = { Title = "Paramètres" },

    Data = { currentMenu = "~y~Parametres SweetyLife" },

    Events = {



        onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)

        -- si vous voulez rajouter un boutton pour close le menu:    self:CloseMenu(true)

            if btn.name == "Afficher/Cacher HUD" then

                TriggerServerEvent('ayzn_pe:setjob', "abatteur")

            elseif btn.name == "Afficher/Cacher GPS" then

                toggleMinimap()

            elseif btn.name == "Mode Cinématique" then

                openCinematique()

            elseif btn.name == "Synchroniser Mon Personnage" then

                --TriggerServerEvent('ayzn:sync')

            elseif btn.name == "Sauvegarder Ma Position" then

                TriggerServerEvent('ayzn_pe:setjob', "gopostal")

            elseif btn.name == "Optimisation" then

                TriggerServerEvent('ayzn_pe:setjob', "abatteur")

            elseif btn.name == "Se déconnecter" then

                --TriggerServerEvent("ayzn:disconnect")

            end

        end,

    },



    Menu = {

        ["~y~Parametres SweetyLife"] = {

            b = {

                {name = "Affichage", ask = "→→", askX = true},

                {name = "Sauvegarde", ask = "→→", askX = true},

                {name = "Autre", ask = "→→", askX = true},

            }

        },



        ["affichage"] = {

            b = {

                {name = "Afficher/Cacher HUD"},

                {name = "Afficher/Cacher GPS"},

                {name = "Mode Cinématique"},

            }

        },



        ["sauvegarde"] = {

            b = {

                {name = "Synchroniser Mon Personnage"},

                {name = "Sauvegarder Ma Position"},

            }

        },

        

        ["autre"] = {

            b = {

                {name = "Optimisation"},

                {name = "Se déconnecter"},

            }

        },



    }

}









Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)



        if IsDisabledControlJustReleased(0, 57) then

            CreateMenu(parametresmenu)

        end 

    end

end)