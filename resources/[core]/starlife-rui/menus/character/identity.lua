-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---  TOI DUMPER , AU LIEU DE VOLER DIRECTEMENT MON BEAU TRAVAIL DEMANDE MOI LA  ---
---  PERMISSION SUR DISCORD --> ayznismaybedead#0666 . CAR SI JE TE CHOPE SANS  ---
---  ME DEMANDER , TU ES DANS LE CACA :) ALLER JE TE SOUHAITE UN TRES BON DUMP  ---
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

local IdentityPrenom
local IdentityNom
local IdentityDOB
local IdentityTaille
local IdentitySexe

RMenu.Add('identity', 'main', RageUI.CreateMenu("Mon Identité", "Mon Identité"))
RMenu:Get('identity', 'main'):SetSubtitle("Mon Identité")
RMenu:Get('identity', 'main').Closable = false;

RageUI.CreateWhile(1.0, function()
	if RageUI.Visible(RMenu:Get('identity', 'main')) then

		DisableControlAction(0, 1,   true) -- LookLeftRight
		DisableControlAction(0, 2,   true) -- LookUpDown
		DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		DisableControlAction(0, 30,  true) -- MoveLeftRight
		DisableControlAction(0, 31,  true) -- MoveUpDown
		DisableControlAction(0, 21,  true) -- disable sprint
		DisableControlAction(0, 24,  true) -- disable attack
		DisableControlAction(0, 25,  true) -- disable aim
		DisableControlAction(0, 47,  true) -- disable weapon
		DisableControlAction(0, 58,  true) -- disable weapon
		DisableControlAction(0, 263, true) -- disable melee
		DisableControlAction(0, 264, true) -- disable melee
		DisableControlAction(0, 257, true) -- disable melee
		DisableControlAction(0, 140, true) -- disable melee
		DisableControlAction(0, 141, true) -- disable melee
		DisableControlAction(0, 143, true) -- disable melee
		DisableControlAction(0, 75,  true) -- disable exit vehicle
		DisableControlAction(27, 75, true) -- disable exit vehicle
		
		RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
			
			RageUI.Button("Mon Prénom", "Mon Prénom", { RightLabel = IdentityPrenom }, true, function(Hovered, Active, Selected)
				if Selected then
					IdentityPrenom = KeyboardInput("fefe","Prénom avec une Majuscule", "Prénom", 10)
				end
            end)
               
            RageUI.Button("Mon Nom", "Mon Nom", { RightLabel = IdentityNom }, true, function(Hovered, Active, Selected)
				if Selected then
					IdentityNom = KeyboardInput("fefe","Nom avec une Majuscule", "Nom", 10)
				end
			end)
		
			RageUI.Button("Ma Date de Naissance", "Ma Date de Naissance", { RightLabel = IdentityDOB }, true, function(Hovered, Active, Selected)
				if Selected then
					IdentityDOB = KeyboardInput("fefe","Date de naissance", "03/06/1999", 10)
				end
            end)
                
            RageUI.Button("Ma Taille", "Ma Taille", { RightLabel = IdentityTaille }, true, function(Hovered, Active, Selected)
				if Selected then
					IdentityTaille = KeyboardInput("fefe","Ma Taille en cm", "180", 3)
				end
            end)
            
            RageUI.Button("Mon Sexe", "Mon Sexe", { RightLabel = IdentitySexe }, true, function(Hovered, Active, Selected)
				if Selected then
					IdentitySexe = KeyboardInput("fefe","Mon Sexe ( M ou F )", "", 0)
				end
			end)
		
			RageUI.Button("Sauvegarder & Continuer", "Sauvegarder & Continuer.", { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 0, 120, 0, 25 }} }, true, function(Hovered, Active, Selected)  
				if (Selected) then
                    local PrenomIdentity = IdentityPrenom
                    local NomIdentity = IdentityNom
                    local TailleIdentity = tonumber(IdentityTaille)
                    local dateIdentity = IdentityDOB
					local SexeIdentity = IdentitySexe
					local fullname = PrenomIdentity.." "..NomIdentity
					local nameLength = string.len(fullname)

					local spacesInName    = 0
					local spacesWithUpper = 0

					for word in string.gmatch(fullname, '%S+') do

						if string.match(word, '%u') then
							spacesWithUpper = spacesWithUpper + 1
						end
				
						spacesInName = spacesInName + 1
					end
		
					if not PrenomIdentity then
						ESX.ShowNotification("Veuillez Renseigner un ~y~Prenom")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif not NomIdentity then
						ESX.ShowNotification("Veuillez Renseigner un ~y~Nom")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif nameLength < 2 or nameLength > 20 then
						ESX.ShowNotification("Veuillez Renseigner un ~y~Nom et Prénom Valide")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif not TailleIdentity then
						ESX.ShowNotification("Veuillez Renseigner une ~y~Taille Valide")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif not dateIdentity then
						ESX.ShowNotification("Veuillez Renseigner une ~y~Date de Naissance")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif not SexeIdentity then
						ESX.ShowNotification("Veuillez Renseigner un ~y~Sexe")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif not SexeIdentity == "M" or "F" then
						ESX.ShowNotification("Votre Sexe doit être M ou F")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif spacesInName > 2 then
						ESX.ShowNotification("Vous ne devez pas mettre d'Espaces dans votre ~y~Nom ou Prénom")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
					elseif spacesWithUpper ~= spacesInName then
						ESX.ShowNotification("Votre Nom et prénom doit commencer par une ~y~majuscule")
						PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
							
					else
						TriggerServerEvent("ayzn:saveIdentity", PrenomIdentity,NomIdentity, TailleIdentity, dateIdentity,SexeIdentity)
						LoadingPrompt("Sauvegarde de votre identité en cours", 3)
						Citizen.Wait(500)
						DoScreenFadeOut(7500)
						Wait(8500)
						DoScreenFadeIn(1500)
						Wait(1500)
                        RemoveLoadingPrompt()
                        PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
						RageUI.CloseAll()
						RMenu:Delete('identity', 'main')
						TriggerEvent("character:openCreationMenu")
					end
				end
			end)
		end, function()
			---Panels
        end)
    end
end, 1)

RegisterNetEvent("ayzn:CreateIdentity")
AddEventHandler("ayzn:CreateIdentity", function()
	--DoScreenFadeOut(2000)
	--Wait(1000)
	RageUI.Visible(RMenu:Get('identity', 'main'), not RageUI.Visible(RMenu:Get('identity', 'main')))
end)

RegisterCommand("identity", function()
	--DoScreenFadeOut(2000)
	RageUI.Visible(RMenu:Get('identity', 'main'), not RageUI.Visible(RMenu:Get('identity', 'main')))
end)

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---  TOI DUMPER , AU LIEU DE VOLER DIRECTEMENT MON BEAU TRAVAIL DEMANDE MOI LA  ---
---  PERMISSION SUR DISCORD --> ayznismaybedead#0666 . CAR SI JE TE CHOPE SANS  ---
---  ME DEMANDER , TU ES DANS LE CACA :) ALLER JE TE SOUHAITE UN TRES BON DUMP  ---
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------