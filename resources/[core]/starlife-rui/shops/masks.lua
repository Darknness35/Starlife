ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getShayyyzenaredObjayyyzenect', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RMenu.Add('showcase', 'masks', RageUI.CreateMenu("Magasin de Masques", "Magasin de Masques"))
RMenu:Get('showcase', 'masks').EnableMouse = false

RageUI.CreateWhile(1.0, function()
    playerPed = GetPlayerPed(-1)
    maskName = {"Pas de masque","Masque Cochon","Masque Crane","Masque Pogo","Masque hockey 1","Masque Singe","Masque Crane Mexicain","Masque Ogre","Masque Père Noël","Masque Renne","Masque Bonhomme Neige","Masque Soirée","Masque Théâtre","Masque Cupidon","Masque Hockey 2","Masque 3","Masque Crane Métal","Masque Chat","Masque Renard","Masque Hibou","Masque Raton Laveur","Masque Ours","Masque Buffle","Masque Taureau","Masque Aigle","Masque Dindon","Masque Loup","Masque Aviateur","Masque Combat","Masque Mort","Masque Hockey 4","Masque Pingouin","Masque Chaussette Noël","Masque Biscuit","Masque Vieux Noël","Masque Cagoule","Masque Gaz","Masque Cagoule Retournée","Masque Gaz Simple","Masque Zombie","Masque Momie","Masque Dent Pointue","Masque Frankenstein","Masque Manga H","Masque Manga F","Masque Manga H Padré","Masque Toxique","Masque Ruban","Masque Scotch","Masque Papier","Masque Simple","Masque Foulard","Masque Cagoule Braqueur","Masque Ninja 1","Masque Touareg","Masque Ninja 2","Masque Ninja 3","Masque Cagoule Rayé 1","Masque Cagoule Rayé 2","Masque Big Foot","Masque Citrouille","Masque vieux Zombie","Masque Acide","Masque Muscle","Masque Zombie Langue","Masque Loup Garou","Masque Mouche","Masque Gollum","Masque Démons","Masque Cousu","Masque Vampire Tourbi","Masque Sorcière","Masque Démons Moustache","Masque Chauve","Masque Biscuit 2","Masque Biscuit 3","Masque Noël Cigare","Masque Sapin Noël","Masque Fraise Pourri","Masque Big Foot 2","Masque Big Foot 3","Masque Big Foot 4","Masque Big Foot 5","Masque Big Foot 6","Masque Yéti","Masque Poulet","Masque Mère Noël 1","Masque Clochard Noël","Masque Mère Noël 2","Masque Combat 2","Masque Training 1","Masque Rino Métal","Masque Alien","Masque T-Rex","Masque Démons 2","Masque Clown","Masque Gorille","Masque Cheval","Masque Licorne","Masque Crane Motif","Masque Chien","Masque Training 2","Masque Dessin Fluo","Masque Soldat","Masque Ensemble Cagoule","Masque Combat Bouffon","Masque Combat Crane","Masque Training Combat","Masque Combat Mort","Masque Aviateur 2","Masque Combat Teubé","Masque Foulard 2","Masque Cagoule Teubé 2","Masque Ninja Motif","Masque Keffieh Ouvert","Masque Keffieh Fermé","Masque Keffieh Nez","Masque Cagoule Rayé 3","Masque Ninja 4","Masque Cagoule Retournée 2","Masque Chauve","Masque Oreillette","Masque Cagoule Plongée","Masque Collant","Masque Hockey 5","Masque Combat Connecté","Masque Hockey Cagoule","Masque Hockey Biscuit","Masque Simple 2","Masque Combat Gaz","Masque Combat Flamme","Masque Bélier","Masque Vision Nocturne"} 

    if RageUI.Visible(RMenu:Get('showcase', 'shop')) then

        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
            for i=0,GetNumberOfPedDrawableVariations(playerPed, 1)-1,1 do
                amount = {}
		        for c = 1, GetNumberOfPedTextureVariations(playerPed, 1, i), 1 do

			        amount[c] = c 
			
		        end
		        if maskName[i+1] == nil then
			        maskName[i+1] = "Masque #"..i
		        end
                RageUI.List("Masques ( 1000$ )", maskName[i+1], amount, "Quel Masque me va le mieux ?", {}, true, function(Hovered, Active, Selected, Index)


                    if Hovered then
                        SetPedComponentVariation(playerPed, 1, amount-1, 1-1, 2)
                    

                        if Selected then
                            ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
                                if hasEnoughMoney then
                                    TriggerServerEvent('esx_accessories:pay')
                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                        TriggerServerEvent('esx_accessories:save', skin, "Mask")
                                    end)
                                else
                                    SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                                end
                            end)
                        end
                    end


                end)
            end

        end, function()
        end)
    end
end, 1)