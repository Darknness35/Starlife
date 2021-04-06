-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---  TOI DUMPER , AU LIEU DE VOLER DIRECTEMENT MON BEAU TRAVAIL DEMANDE MOI LA  ---
---  PERMISSION SUR DISCORD --> ayznismaybedead#0666 . CAR SI JE TE CHOPE SANS  ---
---  ME DEMANDER , TU ES DANS LE CACA :) ALLER JE TE SOUHAITE UN TRES BON DUMP  ---
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

function setPlayerPed(skin)
    local hash = skin
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(500)
    end
    SetPlayerModel(PlayerId(), hash)
    SetPedDefaultComponentVariation(PlayerPedId())
    SetEntityAsMissionEntity(PlayerPedId(), true, true)
    SetModelAsNoLongerNeeded(PlayerPedId())
end

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

function setPlayerFaceCreator(ped, zboubi, skin)
    
    SetPedHeadBlendData(ped, zboubi.faceMum, zboubi.faceDad, 0, zboubi.faceMum, zboubi.faceDad, 0, zboubi.ressemblance, zboubi.skinMix, 0, false)
    SetPedFaceFeature(ped, 0, zboubi.noseWidth)
    SetPedFaceFeature(ped, 1, zboubi.nosePeakHeight)
    SetPedFaceFeature(ped, 2, zboubi.nosePeakLength)
    SetPedFaceFeature(ped, 3, zboubi.noseBoneHeight)
    SetPedFaceFeature(ped, 4, zboubi.nosePeaklowering)
    SetPedFaceFeature(ped, 5, zboubi.noseBoneTwist)
    SetPedFaceFeature(ped, 6, zboubi.eyebrowHeight)
    SetPedFaceFeature(ped, 7, zboubi.eyebrowForward)
    SetPedFaceFeature(ped, 8, zboubi.cheeksBoneHeight)
    SetPedFaceFeature(ped, 9, zboubi.cheeksBoneWidth)
    SetPedFaceFeature(ped, 11, zboubi.eyeOpening)
    SetPedFaceFeature(ped, 12, zboubi.lipsThickness)
    SetPedFaceFeature(ped, 13, zboubi.jawBoneWidth)
    SetPedFaceFeature(ped, 14, zboubi.jawBoneBackLength)
    SetPedFaceFeature(ped, 15, zboubi.chimpBoneLowering)
    SetPedFaceFeature(ped, 16, zboubi.chimpBoneLength)
    SetPedFaceFeature(ped, 17, zboubi.chimpBoneWidth)
    SetPedFaceFeature(ped, 18, zboubi.chimpHole)
    SetPedComponentVariation(ped, 2, zboubi.hairStyle, 0, 0)
    SetPedHairColor(ped, zboubi.hairColor[1], zboubi.hairColor[2])
    SetPedHeadOverlay(ped, 1, zboubi.beardStyle, zboubi.beardOpacity)
    SetPedHeadOverlayColor(ped, 1, 1, zboubi.beardColor[1], zboubi.beardColor[2])
    SetPedHeadOverlay(ped, 3, zboubi.ageingStyle, zboubi.ageingOpacity)
    SetPedHeadOverlay(ped, 8, zboubi.lipstickStyle, zboubi.lipstickOpacity)
    SetPedHeadOverlayColor(ped, 8, 1, zboubi.lipstickColor[1], zboubi.lipstickColor[2])
    SetPedHeadOverlay(ped, 4, zboubi.makeupStyle, zboubi.makeupOpacity)
    SetPedHeadOverlayColor(ped, 4, 1, zboubi.makeupColor[1], zboubi.makeupColor[2])
    SetPedEyeColor(ped, zboubi.eyeStyle)
    SetPedHeadOverlay(ped, 0, zboubi.blemishesStyle, zboubi.blemishesOpacity)
    SetPedHeadOverlay(ped, 6, zboubi.complexionStyle, zboubi.complexionStyle)
    SetPedHeadOverlay(ped, 7, zboubi.skinAspectStyle, zboubi.skinAspectOpacity)
    SetPedHeadOverlay(ped, 9, zboubi.frecklesStyle, zboubi.frecklesOpacity)

end


local HeritageMom = { "Laila", "Jasmine", "Khadija", "Hannan", "Hasna", "Samira", "Ines", "Lina", "Amira", "Luna", "Aya", "Noûr", "Fatima", "Amina", "Aicha", "Myriam", "Leila", "Emira", "Selma", "Jana", "Manël", "Bouchra" }
local HeritageDad = { "Azize", "Mustapha", "Jibril", "Walid", "Mohammed", "Merwan", "Ali", "Hassan", "Nabil", "Momo", "Karim", "Rayan", "Mehdi", "Yussuf", "Akram", "Ismail", "Ilyess", "Naïm", "Youness", "Youssef", "Ayoub", "Wassim", "Aymen" }
local sexChoice = { "Homme", "Femme" }
local hairListM = {
    { ID = 0, name = "Chauve" },
    { ID = 2, name = "Longue queue", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 3, name = "Chignon", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 5, name = "Queue courte", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 6, name = "Biker", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 7, name = "Pecno", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 8, name = "Macbeat" },
    { ID = 9, name = "Trunks", collection = "multiplayer_overlays", overlay = "NG_M_Hair_012" },
    { ID = 10, name = "Coiffure 10", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 11, name = "Coiffure 11", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 12, name = "Coiffure 12", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 37, name = "Court" },
    { ID = 38, name = "Faux Hawk", collection = "multiplayer_overlays", overlay = "NG_M_Hair_002" },
    { ID = 39, name = "Hipster", collection = "multiplayer_overlays", overlay = "NG_M_Hair_003" },
    { ID = 40, name = "Side Parting", collection = "multiplayer_overlays", overlay = "NG_M_Hair_004" },
    { ID = 41, name = "Shorter Cut", collection = "multiplayer_overlays", overlay = "NG_M_Hair_005" },
    { ID = 42, name = "Biker", collection = "multiplayer_overlays", overlay = "NG_M_Hair_006" },
    { ID = 43, name = "Ponytail", collection = "multiplayer_overlays", overlay = "NG_M_Hair_007" },
    { ID = 44, name = "Cornrows", collection = "multiplayer_overlays", overlay = "NG_M_Hair_008" },
    { ID = 45, name = "Slicked", collection = "multiplayer_overlays", overlay = "NG_M_Hair_009" },
    { ID = 46, name = "Short Brushed", collection = "multiplayer_overlays", overlay = "NG_M_Hair_013" },
    { ID = 47, name = "Spikey", collection = "multiplayer_overlays", overlay = "NG_M_Hair_002" },
    { ID = 48, name = "Caesar", collection = "multiplayer_overlays", overlay = "NG_M_Hair_011" },
    { ID = 49, name = "Chopped", collection = "multiplayer_overlays", overlay = "NG_M_Hair_012" },
    { ID = 50, name = "Dreads", collection = "multiplayer_overlays", overlay = "NG_M_Hair_014" },
    { ID = 51, name = "Long Hair", collection = "multiplayer_overlays", overlay = "NG_M_Hair_015" },
    { ID = 52, name = "Shaggy Curls", collection = "multiplayer_overlays", overlay = "NGBea_M_Hair_000" },
    { ID = 53, name = "Surfer Dude", collection = "multiplayer_overlays", overlay = "NGBea_M_Hair_001" },
    { ID = 54, name = "Short Side Part", collection = "multiplayer_overlays", overlay = "NGBus_M_Hair_000" },
    { ID = 55, name = "High Slicked Sides", collection = "multiplayer_overlays", overlay = "NGBus_M_Hair_001" },
    { ID = 56, name = "Long Slicked", collection = "multiplayer_overlays", overlay = "NGHip_M_Hair_000" },
    { ID = 57, name = "Hipster Youth", collection = "multiplayer_overlays", overlay = "NGHip_M_Hair_001" },
    { ID = 58, name = "Mullet", collection = "multiplayer_overlays", overlay = "NGInd_M_Hair_000" },
    { ID = 59, name = "Classic Cornrows", collection = "mplowrider_overlays", overlay = "LR_M_Hair_000" },
    { ID = 60, name = "Palm Cornrows", collection = "mplowrider_overlays", overlay = "LR_M_Hair_001" },
    { ID = 61, name = "Lightning Cornrows", collection = "mplowrider_overlays", overlay = "LR_M_Hair_002" },
    { ID = 62, name = "Whipped Cornrows", collection = "mplowrider_overlays", overlay = "LR_M_Hair_003" },
    { ID = 63, name = "Zig Zag Cornrows", collection = "mplowrider2_overlays", overlay = "LR_M_Hair_004" },
    { ID = 64, name = "Snail Cornrows", collection = "mplowrider2_overlays", overlay = "LR_M_Hair_005" },
    { ID = 65, name = "Hightop", collection = "mplowrider2_overlays", overlay = "LR_M_Hair_006" },
    { ID = 66, name = "Loose Swept Back", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_000_M" },
    { ID = 67, name = "Undercut Swept Back", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_001_M" },
    { ID = 68, name = "Undercut Swept Side", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_002_M" },
    { ID = 69, name = "Spiked Mohawk", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_003_M" },
    { ID = 70, name = "Mod", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_004_M" },
    { ID = 71, name = "Layered Mod", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_005_M" },
    { ID = 72, name = "Flattop", collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_M_000_M" },
    { ID = 73, name = "Military Buzzcut", collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_M_001_M" },
}

local hairListF = {
    { ID = 0, name = "Crâne rasé", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 1, name = "Long", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 2, name = "Coiffure 03", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 3, name = "Court", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 4, name = "Coiffure 04", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 5, name = "Long épaule", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 6, name = "Coiffure 06", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 7, name = "Dread", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 8, name = "Coiffure 08" },
    { ID = 9, name = "Coiffure 09", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 10, name = "Coiffure 10", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 11, name = "Coiffure 11", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 12, name = "Coiffure 12", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 13, name = "Coiffure 13", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 14, name = "Coiffure 14", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 15, name = "Coiffure 15", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 16, name = "Coiffure 16", collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
    { ID = 39, name = "Short", collection = "multiplayer_overlays", overlay = "NG_F_Hair_001" },
    { ID = 40, name = "Layered Bob", collection = "multiplayer_overlays", overlay = "NG_F_Hair_002" },
    { ID = 41, name = "Pigtails", collection = "multiplayer_overlays", overlay = "NG_F_Hair_003" },
    { ID = 42, name = "Ponytail", collection = "multiplayer_overlays", overlay = "NG_F_Hair_004" },
    { ID = 43, name = "Braided Mohawk", collection = "multiplayer_overlays", overlay = "NG_F_Hair_005" },
    { ID = 44, name = "Braids", collection = "multiplayer_overlays", overlay = "NG_F_Hair_006" },
    { ID = 45, name = "Bob", collection = "multiplayer_overlays", overlay = "NG_F_Hair_007" },
    { ID = 46, name = "Faux Hawk", collection = "multiplayer_overlays", overlay = "NG_F_Hair_008" },
    { ID = 47, name = "French Twist", collection = "multiplayer_overlays", overlay = "NG_F_Hair_009" },
    { ID = 48, name = "Long Bob", collection = "multiplayer_overlays", overlay = "NG_F_Hair_010" },
    { ID = 49, name = "Loose Tied", collection = "multiplayer_overlays", overlay = "NG_F_Hair_011" },
    { ID = 50, name = "Pixie", collection = "multiplayer_overlays", overlay = "NG_F_Hair_012" },
    { ID = 51, name = "Shaved Bangs", collection = "multiplayer_overlays", overlay = "NG_F_Hair_013" },
    { ID = 52, name = "Top Knot", collection = "multiplayer_overlays", overlay = "NG_M_Hair_014" },
    { ID = 53, name = "Wavy Bob", collection = "multiplayer_overlays", overlay = "NG_M_Hair_015" },
    { ID = 54, name = "Messy Bun", collection = "multiplayer_overlays", overlay = "NGBea_F_Hair_000" },
    { ID = 55, name = "Pin Up Girl", collection = "multiplayer_overlays", overlay = "NGBea_F_Hair_001" },
    { ID = 56, name = "Tight Bun", collection = "multiplayer_overlays", overlay = "NG_F_Hair_007" },
    { ID = 57, name = "Twisted Bob", collection = "multiplayer_overlays", overlay = "NGBus_F_Hair_000" },
    { ID = 58, name = "Flapper Bob", collection = "multiplayer_overlays", overlay = "NGBus_F_Hair_001" },
    { ID = 59, name = "Big Bangs", collection = "multiplayer_overlays", overlay = "NGBea_F_Hair_001" },
    { ID = 60, name = "Braided Top Knot", collection = "multiplayer_overlays", overlay = "NGHip_F_Hair_000" },
    { ID = 61, name = "Mullet", collection = "multiplayer_overlays", overlay = "NGInd_F_Hair_000" },
    { ID = 62, name = "Pinched Cornrows", collection = "mplowrider_overlays", overlay = "LR_F_Hair_000" },
    { ID = 63, name = "Leaf Cornrows", collection = "mplowrider_overlays", overlay = "LR_F_Hair_001" },
    { ID = 64, name = "Zig Zag Cornrows", collection = "mplowrider_overlays", overlay = "LR_F_Hair_002" },
    { ID = 65, name = "Pigtail Bangs", collection = "mplowrider2_overlays", overlay = "LR_F_Hair_003" },
    { ID = 66, name = "Wave Braids", collection = "mplowrider2_overlays", overlay = "LR_F_Hair_003" },
    { ID = 67, name = "Coil Braids", collection = "mplowrider2_overlays", overlay = "LR_F_Hair_004" },
    { ID = 68, name = "Rolled Quiff", collection = "mplowrider2_overlays", overlay = "LR_F_Hair_006" },
    { ID = 69, name = "Loose Swept Back", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_000_F" },
    { ID = 70, name = "Undercut Swept Back", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_001_F" },
    { ID = 71, name = "Undercut Swept Side", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_002_F" },
    { ID = 72, name = "Spiked Mohawk", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_003_F" },
    { ID = 73, name = "Bandana and Braid", collection = "multiplayer_overlays", overlay = "NG_F_Hair_003" },
    { ID = 74, name = "Layered Mod", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_006_F" },
    { ID = 75, name = "Skinbyrd", collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_004_F" },
    { ID = 76, name = "Neat Bun", collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_F_000_F" },
    { ID = 77, name = "Short Bob", collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_F_001_F" }
}

local rideList = { "-", "Rides yeux", "Rides 1", "Rides 2", "Rides 3", "Rides 4", "Rides 5", "Rides 6", "Rides 7", "Rides 8", "Rides 9", "Rides 10", "Rides EX 1", "Rides EX 2", "Cernes" }
local tachList = { "-", "Peu de tâches", "Tâches peu visibles", "Tâches baladées", "Tâches éparpillées", "Tâches sauvages", "Tâches centrées", "Tâches joues", "Tâches visage", "Infection visage", "Infection joues", "Rougeur", "Rougeur infectée", "Rougeurs front", "Acnée", "Acnée sévère", "Acnée baladée", "Acnée épaisse", "Acnée front", "Acnée totale" }
local eyesList = { "Vert", "Emmeraude", "Bleu", "Bleu ciel", "Marron clair", "Marron", "Noisette", "Gris sombre", "Gris propre", "Rose", "Jaune", "Violet", "Blackout", "Ombre grise", "Soleil tequila", "Atomic", "Faux", "Cola", "Ranger", "Ying-yang", "Bull", "Lezard", "Dragon", "Extra-terrestre", "Chèvre", "Smiley", "Possédé", "Démon", "Infecté", "Alien", "Mort", "Zombie" }
local spawnInProgress = false

local BarbeName = {}
for i = 1, 29, 1 do
    BarbeName[i] = GetLabelText("CC_BEARD_" .. i - 1)
end

local SKClist = { "-" }
for i = 0, 11, 1 do
    table.insert(SKClist, GetLabelText("CC_SKINCOM_" .. i))
end

local MoleList = { "-" }

for i = 0, 18, 1 do
    table.insert(MoleList, GetLabelText("CC_MOLEFRECK_" .. i))
end

local ComplexList = { "-" }
for i = 1, 11, 1 do
    table.insert(ComplexList, GetLabelText("CC_MOLEFRECK_" .. i))
end

local MaquillageList = { "-" }
for i = 1, 71, 1 do
    table.insert(MaquillageList, GetLabelText("CC_MKUP_" .. i))
end

local LipsList = { "-" }
for i = 1, 10, 1 do
    table.insert(LipsList, GetLabelText("CC_LIPSTICK_" .. i))
end

local colorsPanel = {
    haircut = {
        [1] = 1,
        [2] = 1,
    },
    barber = {
        [1] = 1,
        [2] = 1,
    },
    lipstick = {
        [1] = 1,
        [2] = 1,
    },
    makeup = {
        [1] = 1,
        [2] = 1,
    }
}
--cIdentity = {}

cCharacterCreatorData = {}
cCharacterCreatorDataPED = ""
cCharacterCreatorData.sex = 1
cCharacterCreatorData.faceMum = 1
cCharacterCreatorData.faceDad = 1
cCharacterCreatorData.ressemblance = 1
cCharacterCreatorData.skinMix = 1
cCharacterCreatorData.eyebrowHeight = 1
cCharacterCreatorData.eyebrowForward = 1
cCharacterCreatorData.eyeOpening = 1
cCharacterCreatorData.noseWidth = 1
cCharacterCreatorData.nosePeaklowering = 1
cCharacterCreatorData.noseBoneHeight = 1
cCharacterCreatorData.noseBoneTwist = 1
cCharacterCreatorData.nosePeakHeight = 1
cCharacterCreatorData.nosePeakLength = 1
cCharacterCreatorData.cheeksBoneHeight = 1
cCharacterCreatorData.cheeksBoneWidth = 1
cCharacterCreatorData.lipsThickness = 1
cCharacterCreatorData.jawBoneWidth = 1
cCharacterCreatorData.jawBoneBackLength = 1
cCharacterCreatorData.chimpBoneLength = 1
cCharacterCreatorData.chimpBoneWidth = 1
cCharacterCreatorData.chimpHole = 1
cCharacterCreatorData.chimpBoneLowering = 1
cCharacterCreatorData.hairStyle = 1
cCharacterCreatorData.hairColor = { [1] = 1, [2] = 1 }
cCharacterCreatorData.blemishesStyle = 1
cCharacterCreatorData.blemishesOpacity = 1
cCharacterCreatorData.ageingStyle = 1
cCharacterCreatorData.complexionStyle = 1
cCharacterCreatorData.eyeStyle = 1
cCharacterCreatorData.lipstickStyle = 1
cCharacterCreatorData.lipstickOpacity = 1
cCharacterCreatorData.lipstickColor = { [1] = 1, [2] = 1 }
cCharacterCreatorData.makeupStyle = 1
cCharacterCreatorData.makeupOpacity = 1
cCharacterCreatorData.makeupColor = { [1] = 1, [2] = 1 }
cCharacterCreatorData.beardStyle = 1
cCharacterCreatorData.beardOpacity = 1
cCharacterCreatorData.beardColor = { [1] = 1, [2] = 1 }
cCharacterCreatorData.ageingOpacity = 1
cCharacterCreatorData.skinAspectStyle = 1
cCharacterCreatorData.skinAspectOpacity = 1
cCharacterCreatorData.frecklesStyle = 1
cCharacterCreatorData.frecklesOpacity = 1
cCharacterCreatorData.complexionOpacity = 1

iCharacterCreatorData = {}
iCharacterCreatorData.faceMum = 1
iCharacterCreatorData.faceDad = 1
iCharacterCreatorData.ressemblance = 1
iCharacterCreatorData.skinMix = 1
iCharacterCreatorData.eyebrowHeight = 1
iCharacterCreatorData.eyebrowForward = 1
iCharacterCreatorData.eyeOpening = 1
iCharacterCreatorData.noseWidth = 1
iCharacterCreatorData.nosePeaklowering = 1
iCharacterCreatorData.noseBoneHeight = 1
iCharacterCreatorData.noseBoneTwist = 1
iCharacterCreatorData.nosePeakHeight = 1
iCharacterCreatorData.nosePeakLength = 1
iCharacterCreatorData.cheeksBoneHeight = 1
iCharacterCreatorData.cheeksBoneWidth = 1
iCharacterCreatorData.lipsThickness = 1
iCharacterCreatorData.jawBoneWidth = 1
iCharacterCreatorData.jawBoneBackLength = 1
iCharacterCreatorData.chimpBoneLength = 1
iCharacterCreatorData.chimpBoneWidth = 1
iCharacterCreatorData.chimpHole = 1
iCharacterCreatorData.chimpBoneLowering = 1
iCharacterCreatorData.jawBoneBackLength = 1
iCharacterCreatorData.hairStyle = 1
iCharacterCreatorData.hairColor = { [1] = 1, [2] = 1 }
iCharacterCreatorData.beardStyle = 1
iCharacterCreatorData.blemishesStyle = 1
iCharacterCreatorData.ageingStyle = 1
iCharacterCreatorData.skinAspectStyle = 1
iCharacterCreatorData.frecklesStyle = 1
iCharacterCreatorData.complexionStyle = 1
iCharacterCreatorData.eyeStyle = 1
iCharacterCreatorData.makeupStyle = 1
iCharacterCreatorData.lipstickStyle = 1
iCharacterCreatorData.lipstickOpacity = 1
iCharacterCreatorData.lipstickColor = { [1] = 1, [2] = 1 }
iCharacterCreatorData.makeupOpacity = 1
iCharacterCreatorData.makeupColor = { [1] = 1, [2] = 1 }
iCharacterCreatorData.beardOpacity = 1
iCharacterCreatorData.beardColor = { [1] = 1, [2] = 1 }
iCharacterCreatorData.blemishesOpacity = 1
iCharacterCreatorData.ageingOpacity = 1
iCharacterCreatorData.skinAspectOpacity = 1
iCharacterCreatorData.frecklesOpacity = 1
iCharacterCreatorData.complexionOpacity = 1


local Items = {
    mp_m_freemode_01 = {
        [1] = {
            List = { "Standard", "Protubérant", "Plat", "-" },
            Index = 1,
        },
        [2] = {
            List = { "Standard", "Ouverts", "Plissés", "-" },
            Index = 1,
        },
        [3] = {
            List = { "Standard", "Large", "Petit", "-" },
            Index = 1,
        },
        [4] = {
            List = { "Standard", "Saillante", "Incurvée", "-" },
            Index = 1,
        },
        [5] = {
            List = { "Standard", "Cassé", "Vers le haut", "-" },
            Index = 1,
        },
        [6] = {
            List = { "Standard", "Larges", "Fines", "-" },
            Index = 1,
        },
        [7] = {
            List = { "Standard", "Grosses", "Minces", "-" },
            Index = 1,
        },
        [8] = {
            List = { "Standard", "Épaisses", "Minces", "-" },
            Index = 1,
        },
        [9] = {
            List = { "Standard", "Carrée", "Ronde", "-" },
            Index = 1,
        },
        [10] = {
            List = { "Standard", "Large", "Petit", "-" },
            Index = 1,
        },
        [11] = {
            List = { "Standard", "Pointu", "Rond", "-" },
            Index = 1,
        },
    },

    mp_f_freemode_01 = {
        [1] = {
            List = { "Standard", "Protubérant", "Plat", "-" },
            Index = 1,
        },
        [2] = {
            List = { "Standard", "Ouverts", "Plissés", "-" },
            Index = 1,
        },
        [3] = {
            List = { "Standard", "Large", "Petit", "-" },
            Index = 1,
        },
        [4] = {
            List = { "Standard", "Saillante", "Incurvée", "-" },
            Index = 1,
        },
        [5] = {
            List = { "Standard", "Cassé", "Vers le haut", "-" },
            Index = 1,
        },
        [6] = {
            List = { "Standard", "Larges", "Fines", "-" },
            Index = 1,
        },
        [7] = {
            List = { "Standard", "Grosses", "Minces", "-" },
            Index = 1,
        },
        [8] = {
            List = { "Standard", "Épaisses", "Minces", "-" },
            Index = 1,
        },
        [9] = {
            List = { "Standard", "Carrée", "Ronde", "-" },
            Index = 1,
        },
        [10] = {
            List = { "Standard", "Large", "Petit", "-" },
            Index = 1,
        },
        [11] = {
            List = { "Standard", "Pointu", "Rond", "-" },
            Index = 1,
        },
    }
}
local self = {
    FACE_F_BROW = false,
    FACE_F_EYES = false,
    FACE_F_NOSE = false,
    FACE_F_NOSEP = false,
    FACE_F_NOSET = false,
    FACE_F_CHEEK = false,
    FACE_F_CHEEKS = false,
    FACE_F_LIPS = false,
    FACE_F_JAW = false,
    FACE_F_CHIN = false,
    FACE_F_CHINS = false,
    FACE_HAIR = false,
    FACE_BEARD = false,
    FACE_SKINISSUES = false,
    FACE_OLDNESS = false,
    FACE_TINT = false,
}

function spawnCharacterPersonnalisation(zboubi, skin)
    local ped = GetPlayerPed(-1)

    setPlayerPed(cCharacterCreatorDataPED)
    Wait(500)
    setPlayerFaceCreator(ped, cCharacterCreatorData, skin)
end

function saveCharacterPersonnalisation()
    LoadingPrompt("Sauvegarde de votre personnage en cours", 3)


    local skin              = cCharacterCreatorDataPED
    local sex               = cCharacterCreatorData.sex
    local faceMum           = cCharacterCreatorData.faceMum
    local faceDad           = cCharacterCreatorData.faceDad
    local ressemblance      = cCharacterCreatorData.ressemblance
    local skinMix           = cCharacterCreatorData.skinMix
    local hairStyle         = cCharacterCreatorData.hairStyle
    local hairColorOne      = cCharacterCreatorData.hairColor[1]
    local hairColorTwo      = cCharacterCreatorData.hairColor[2]
    local blemishesStyle    = cCharacterCreatorData.blemishesStyle
    local blemishesOpacity  = cCharacterCreatorData.blemishesOpacity
    local ageingStyle       = cCharacterCreatorData.ageingStyle
    local complexionStyle   = cCharacterCreatorData.complexionStyle
    local eyeStyle          = cCharacterCreatorData.eyeStyle
    local lipstickStyle     = cCharacterCreatorData.lipstickStyle
    local lipstickOpacity   = cCharacterCreatorData.lipstickOpacity
    local lipstickColorOne  = cCharacterCreatorData.lipstickColor[1]
    local lipstickColorTwo  = cCharacterCreatorData.lipstickColor[2]
    local makeupStyle       = cCharacterCreatorData.makeupStyle
    local makeupOpacity     = cCharacterCreatorData.makeupOpacity    
    local makeupColorOne    = cCharacterCreatorData.makeupColor[1]
    local makeupColorTwo    = cCharacterCreatorData.makeupColor[2]
    local beardStyle        = cCharacterCreatorData.beardStyle
    local beardOpacity      = cCharacterCreatorData.beardOpacity
    local beardColorOne     = cCharacterCreatorData.beardColor[1]
    local beardColorTwo     = cCharacterCreatorData.beardColor[2]
    local ageingOpacity     = cCharacterCreatorData.ageingOpacity
    local skinAspectStyle   = cCharacterCreatorData.skinAspectStyle
    local skinAspectOpacity = cCharacterCreatorData.skinAspectOpacity
    local frecklesStyle     = cCharacterCreatorData.frecklesStyle
    local frecklesOpacity   = cCharacterCreatorData.frecklesOpacity
    local complexionOpacity = cCharacterCreatorData.complexionOpacity

    --tenues
    local Tshirt = myTshirt
    local Tshirt2 = myTshirt2
    local Torse = myTorse
    local Torse2 = myTorse2
    local Bras = myBras
    local Bras2 = myBras2
    local Pantalon = myPantalon
    local Pantalon2 = myPantalon2
    local Chaussures = myChaussures
    local Chaussures2 = myChaussures2

    --[[ local cCharacterCreatorData = {
        ["skin"]              = skin,
        ["faceMum"]           = faceMum,          
        ["faceDad"]           = faceDad,         
        ["ressemblance"]      = ressemblance,     
        ["skinMix"]           = skinMix,          
        ["eyebrowHeight"]     = eyebrowHeight,    
        ["eyebrowForward"]    = eyebrowForward,   
        ["eyeOpening"]        = eyeOpening,       
        ["noseWidth"]         = noseWidth,        
        ["nosePeaklowering"]  = nosePeaklowering, 
        ["noseBoneHeight"]    = noseBoneHeight,   
        ["noseBoneTwist"]     = noseBoneTwist,    
        ["noseBoneHeight"]    = noseBoneHeight,   
        ["nosePeakLength"]    = nosePeakLength,
        ["nosePeakHeight"]    = nosePeakHeight, 
        ["cheeksBoneHeight"]  = cheeksBoneHeight, 
        ["cheeksBoneWidth"]   = cheeksBoneWidth,  
        ["lipsThickness"]     = lipsThickness,    
        ["jawBoneBackLength"] = jawBoneBackLength,
        ["chimpBoneLength"]   = chimpBoneLength,  
        ["chimpBoneWidth"]    = chimpBoneWidth,   
        ["chimpHole"]         = chimpHole,  
        ["chimpBoneLowering"] = chimpBoneLowering,
        ["hairStyle"]         = hairStyle,        
        ["hairColorOne"]      = hairColorOne,        
        ["hairColorTwo"]      = hairColorTwo,        
        ["blemishesStyle"]    = blemishesStyle,  
        ["blemishesOpacity"]  = blemishesOpacity,
        ["ageingStyle"]       = ageingStyle,   
        ["complexionStyle"]   = complexionStyle,  
        ["eyeStyle"]          = eyeStyle,         
        ["lipstickStyle"]     = lipstickStyle,    
        ["lipstickOpacity"]   = lipstickOpacity,  
        ["lipstickColorOne"]  = lipstickColorOne,    
        ["lipstickColorTwo"]  = lipstickColorTwo,    
        ["makeupStyle"]       = makeupStyle,      
        ["makeupOpacity"]     = makeupOpacity,    
        ["makeupColorOne"]    = makeupColorOne,      
        ["makeupColorTwo"]    = makeupColorTwo,      
        ["beardStyle"]        = beardStyle,      
        ["beardOpacity"]      = beardOpacity,     
        ["beardColorOne"]     = beardColorOne,       
        ["beardColorTwo"]     = beardColorTwo,       
        ["ageingOpacity"]     = ageingOpacity,    
        ["skinAspectStyle"]   = skinAspectStyle,  
        ["skinAspectOpacity"] = skinAspectOpacity,
        ["frecklesStyle"]     = frecklesStyle,    
        ["frecklesOpacity"]   = frecklesOpacity,  
        ["complexionOpacity"] = complexionOpacity
    } ]]

    local cCharacterCreatorData = {
        ["sex"]                 = sex,
        ["face"]                = ressemblance,
        ["skin"]                = skinMix,
        ["eye_color"]           = eyeStyle,
        ["hair_1"]              = hairStyle,
        ["hair_color_1"]        = hairColorOne,
        ["hair_color_2"]        = hairColorTwo,
        ["blemishes_1"]         = blemishesStyle,
        ["blemishes_2"]         = blemishesOpacity,
        ["complexion_1"]        = complexionStyle,
        ["complexion_2"]        = complexionOpacity,
        ["lipstick_1"]          = lipstickStyle,
        ["lipstick_2"]          = lipstickOpacity,
        ["lipstick_3"]          = lipstickColorOne,
        ["lipstick_4"]          = lipstickColorTwo,
        ["makeup_1"]            = makeupStyle,
        ["makeup_2"]            = makeupOpacity,
        ["makeup_3"]            = makeupColorOne,
        ["makeup_4"]            = makeupColorTwo,
        ["beard_1"]             = beardStyle,
        ["beard_2"]             = beardOpacity,
        ["beard_3"]             = beardColorOne, 
        ["beard_4"]             = beardColorTwo,
        ["age_1"]               = ageingStyle,
        ["age_2"]               = ageingOpacity,
        ["sun_1"]               = skinAspectStyle,
        ["sun_2"]               = skinAspectOpacity,
        ["moles_1"]             = frecklesStyle,
        ["moles_2"]             = frecklesOpacity,
        
        --tenues
        ["tshirt_1"]            = Tshirt,
        ["tshirt_2"]            = Tshirt2,
        ["torso_1"]             = Torse,
        ["torso_2"]             = Torse2,
        ["arms"]                = Bras,
        ["arms_2"]              = Bras2,
        ["pants_1"]            = Pantalon,
        ["pants_2"]            = Pantalon2,
        ["shoes_1"]            = Chaussures,
        ["shoes_2"]            = Chaussures2,
    }

    TriggerServerEvent('ayzn:saveSkin', cCharacterCreatorData)
    Wait(3500)
    RemoveLoadingPrompt()
    cCharacterCreatorData = nil
end

local Character = {}

function setPlayerFaceSpawn(skin)
    local ped = PlayerPedId()
    spawnInProgress = true

    for k,v in pairs(skin) do
		Character[k] = v
    end
    
    cCharacterCreatorDataPED = Character['skin']
    cCharacterCreatorData.noseWidth = Character['noseWidth']
    cCharacterCreatorData.nosePeakHeight = Character['nosePeakHeight']
    cCharacterCreatorData.nosePeakLength = Character['nosePeakLength']
    cCharacterCreatorData.noseBoneHeight = Character['noseBoneHeight']
    cCharacterCreatorData.nosePeaklowering = Character['nosePeaklowering']
    cCharacterCreatorData.noseBoneTwist = Character['noseBoneTwist']
    cCharacterCreatorData.eyebrowHeight = Character['eyebrowHeight']
    cCharacterCreatorData.eyebrowForward = Character['eyebrowForward']
    cCharacterCreatorData.cheeksBoneHeight = Character['cheeksBoneHeight']
    cCharacterCreatorData.cheeksBoneWidth = Character['cheeksBoneWidth']
    cCharacterCreatorData.eyeOpening = Character['eyeOpening']
    cCharacterCreatorData.lipsThickness = Character['lipsThickness']
    cCharacterCreatorData.jawBoneWidth = Character['jawBoneWidth']
    cCharacterCreatorData.jawBoneBackLength = Character['jawBoneBackLength']
    cCharacterCreatorData.chimpBoneLowering = Character['chimpBoneLowering']
    cCharacterCreatorData.chimpBoneLength = Character['chimpBoneLength']
    cCharacterCreatorData.chimpBoneWidth = Character['chimpBoneWidth']
    cCharacterCreatorData.chimpHole = Character['chimpHole']
    cCharacterCreatorData.beardStyle  = Character['beardStyle']
    cCharacterCreatorData.beardOpacity = Character['beardOpacity']
    cCharacterCreatorData.beardColor[1] = Character['beardColorOne']
    cCharacterCreatorData.beardColor[2] = Character['beardColorTwo']
    cCharacterCreatorData.ageingStyle  = Character['ageingStyle']
    cCharacterCreatorData.ageingOpacity = Character['ageingOpacity']
    cCharacterCreatorData.lipstickStyle  = Character['lipstickStyle']
    cCharacterCreatorData.lipstickOpacity = Character['lipstickOpacity']
    cCharacterCreatorData.makeupStyle = Character['makeupStyle']
    cCharacterCreatorData.makeupOpacity = Character['makeupOpacity']
    cCharacterCreatorData.makeupColor[1] = Character['makeupColorOne']
    cCharacterCreatorData.makeupColor[2] = Character['makeupColorTwo']
    cCharacterCreatorData.hairStyle = Character['hairStyle']
    cCharacterCreatorData.hairColor[1]  = Character['hairColorOne']
    cCharacterCreatorData.hairColor[2] = Character['hairColorTwo']
    cCharacterCreatorData.lipstickColor[1] = Character['lipstickColorOne']
    cCharacterCreatorData.lipstickColor[2] = Character['lipstickColorTwo']
    cCharacterCreatorData.eyeStyle = Character['eyeStyle']
    cCharacterCreatorData.blemishesStyle  = Character['blemishesStyle']
    cCharacterCreatorData.blemishesOpacity = Character['blemishesOpacity']
    cCharacterCreatorData.complexionStyle  = Character['complexionStyle']
    cCharacterCreatorData.complexionStyle = Character['complexionStyle']
    cCharacterCreatorData.skinAspectStyle = Character['skinAspectStyle']
    cCharacterCreatorData.skinAspectOpacity = Character['skinAspectOpacity']
    cCharacterCreatorData.frecklesStyle = Character['frecklesStyle']
    cCharacterCreatorData.frecklesOpacity = Character['frecklesOpacity']
    
    Wait(100)

    loadedCharacter = setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
    --loadedCharacter = spawnCharacterPersonnalisation(cCharacterCreatorData, skin)

    while not loadedCharacter do
        Citizen.Wait(0)
    end

    Wait(10000)
    cCharacterCreatorData = nil

end

local IdentityPrenom
local IdentityNom
local IdentityDOB
local IdentityTaille
local IdentitySexe

function openCharCreatorMenu()

    RMenu.Add('charCreator', 'main', RageUI.CreateMenu("Mon Personnage", ""))
    RMenu.Add('charCreator', 'identity', RageUI.CreateSubMenu(RMenu:Get('charCreator', 'main'), "Personnage", "~y~Identité"))
    RMenu.Add('charCreator', 'heritage', RageUI.CreateSubMenu(RMenu:Get('charCreator', 'main'), "Personnage", "~y~Heritage"))
    RMenu.Add('charCreator', 'customFace', RageUI.CreateSubMenu(RMenu:Get('charCreator', 'main'), "Personnage", "~y~Traits du visage"))
    RMenu.Add('charCreator', 'customAdvanced', RageUI.CreateSubMenu(RMenu:Get('charCreator', 'main'), "Personnage", "~y~Traits du visage"))
    RMenu.Add('charCreator', 'clothing', RageUI.CreateSubMenu(RMenu:Get('charCreator', 'main'), "Personnage", "~y~Vetements"))

    RMenu:Get('charCreator', 'main'):SetSubtitle("~b~Creation du Personnage")
    RMenu:Get('charCreator', 'main').Closable = false;
    RMenu:Get('charCreator', 'main').EnableMouse = true
    RMenu:Get('charCreator', 'customFace').EnableMouse = true
    RMenu:Get('charCreator', 'customAdvanced').EnableMouse = true

    RMenu:Get('charCreator', 'heritage').Closed = function()
    RMenu:Get('charCreator', 'identity').Closable = false;
    end

    local pedChoisi = false
    local mpNonChoisi = true
    local heritageSet = false
    local TraitSet = false
    local ApparenceSet = false
    local TenueSet = false
    local IdentitySet = false

    RageUI.CreateWhile(1.0, function()
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

        if RageUI.Visible(RMenu:Get('charCreator', 'main')) then
            RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()

                --if not pedChoisi then
                    RageUI.List("Sexe", sexChoice, cCharacterCreatorData.sex, "Choisissez votre sexe.", {}, true, function(Hovered, Active, Selected, Index)   -- Slidebar
                        if (Selected) then
                            if Index == 1 then
                                cCharacterCreatorDataPED = "mp_m_freemode_01"
                                setPlayerPed("mp_m_freemode_01")
                                pedChoisi = true
                            elseif Index == 2 then
                                cCharacterCreatorDataPED = "mp_f_freemode_01"
                                setPlayerPed("mp_f_freemode_01")
                                pedChoisi = true
                            end
                        end
                        cCharacterCreatorData.sex = Index;
                    end)

                    if pedChoisi then

                        RageUI.Button("Mon Identité", "Mon Identité", { RightLabel = "→" }, true, function(Hovered, Active, Selected)

                        end, RMenu:Get('charCreator', 'identity'))

                        
                        if IdentitySet then
                            RageUI.Button("Mon Heritage", "Mon Heritage", { RightLabel = "→" }, true, function(Hovered, Active, Selected)

                            end, RMenu:Get('charCreator', 'heritage'))

                            if heritageSet then
                                RageUI.Button("Mon Visage", "Mon Visage", { RightLabel = "→" }, true, function(Hovered, Active, Selected)

                                end, RMenu:Get('charCreator', 'customFace'))

                                if TraitSet then

                                    RageUI.Button("Mon Apparence", "Mon Apparence", { RightLabel = "→" }, true, function(Hovered, Active, Selected)

                                    end, RMenu:Get('charCreator', 'customAdvanced'))

                                    if ApparenceSet then

                                        RageUI.Button("Ma Tenue", "Ma Tenue", { RightLabel = "→" }, true, function(Hovered, Active, Selected)  
                                        end, RMenu:Get('charCreator', 'clothing'))

                                        if TenueSet then
                                            RageUI.Button("Arriver En Ville", "Arriver En Ville", { RightBadge = RageUI.BadgeStyle.Tick, Color = { BackgroundColor = { 0, 120, 0, 25 } } }, true, function(Hovered, Active, Selected)  
                                                if (Selected) then
                                                    RageUI.CloseAll()
                                                    DoScreenFadeOut(2000)
                                                    saveCharacterPersonnalisation()
                                                    SetEntityCoords(GetPlayerPed(-1), -246.6787, -339.6397, 29.9765)
                                                    DoScreenFadeIn(2000)
                                                    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                                    ShowAdvancedNotification("Guide Touristique", "Bienvenue En Ville !", "Commencons par louer une Voiture", "CHAR_CARSITE", 1)
                                                    Wait(5000)
                                                    ShowAdvancedNotification("Guide Touristique", "Bienvenue En Ville !", "Il te faudrait peut être un Emploi ?\nAllons au Centre d'Interim !", "CHAR_CARSITE", 1)
                                                    Wait(5000)
                                                    ShowAdvancedNotification("Guide Touristique","Bonne Chance !","Ah ! Escuse moi je dois y aller\nJe te laisse te débrouiller tu verras c'est facile de se trouver des amis.")
                                                end
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                --end
            end, function()
            end)
        end

        if RageUI.Visible(RMenu:Get('charCreator', 'identity')) then

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
                            ShowAdvancedNotification("Identité","Erreur","Veuillez renseigner un Prénom !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        elseif not NomIdentity then
                            ShowAdvancedNotification("Identité","Erreur","Veuillez renseigner un Nom !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        elseif nameLength < 2 or nameLength > 20 then
                            ShowAdvancedNotification("Identité","Erreur","Veuillez renseigner un Nom et Prénom Valide !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        elseif not TailleIdentity then
                            ShowAdvancedNotification("Identité","Erreur","Veuillez renseigner un Taille Valide !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        elseif not dateIdentity then
                            ShowAdvancedNotification("Identité","Erreur","Veuillez renseigner une Date De Naissance !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        elseif not SexeIdentity then
                            ShowAdvancedNotification("Identité","Erreur","Veuillez renseigner un votre Sexe !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        --[[ elseif not SexeIdentity == "M" or "F" then
                            ShowAdvancedNotification("Identité","Erreur","Votre Sexe doit etre M ou F !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true) ]]
                        elseif spacesInName > 2 then
                            ShowAdvancedNotification("Identité","Erreur","Veuillez ne mettre aucun Espace dans votre Nom ou Prénom !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        elseif spacesWithUpper ~= spacesInName then
                            ShowAdvancedNotification("Identité","Erreur","Votre Nom et Prénom doit commencer par une Majuscule !","CHAR_MULTIPLAYER",1)
                            PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                                
                        else
                            IdentitySet = true
                            TriggerServerEvent("ayzn:saveIdentity", PrenomIdentity,NomIdentity, TailleIdentity, dateIdentity,SexeIdentity)
                            LoadingPrompt("Sauvegarde de votre identité en cours", 3)
                            Citizen.Wait(500)
                            DoScreenFadeOut(7500)
                            RageUI.CloseAll()
                            RageUI.Visible(RMenu:Get('charCreator', 'main'))
                            Wait(8500)
                            DoScreenFadeIn(1500)
                            Wait(1500)
                            RemoveLoadingPrompt()
                            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
                        end
                    end
                end)
            end, function()
                ---Panels
            end)
        end

        
        if RageUI.Visible(RMenu:Get('charCreator', 'heritage')) then
            RageUI.DrawContent({ header = true, instructionalButton = true }, function()
                RageUI.HeritageWindow(iCharacterCreatorData.faceMum, iCharacterCreatorData.faceDad)
                RageUI.List(GetLabelText("FACE_MUMS"), HeritageMom, iCharacterCreatorData.faceMum, GetLabelText("CHARC_H_30"), {}, true, function(Hovered, Active, Selected, Index)
                    if cCharacterCreatorData.faceMum ~= Index then
                        cCharacterCreatorData.faceMum = Index - 1
                        iCharacterCreatorData.faceMum = Index
                    end
                end)
                
                RageUI.List(GetLabelText("FACE_DADS"), HeritageDad, iCharacterCreatorData.faceDad, GetLabelText("CHARC_H_31"), {}, true, function(Hovered, Active, Selected, Index)
                    if cCharacterCreatorData.faceDad ~= Index then
                        cCharacterCreatorData.faceDad = Index - 1
                        iCharacterCreatorData.faceDad = Index
                    end
                end)

                RageUI.UISliderHeritage(GetLabelText("FACE_H_DOM"), math.round(iCharacterCreatorData.ressemblance, 2) * 10, GetLabelText("CHARC_H_9"), function(Hovered, Selected, Active, Heritage, Index)
                    if cCharacterCreatorData.ressemblance ~= Heritage then
                        cCharacterCreatorData.ressemblance = Heritage
                        iCharacterCreatorData.ressemblance = Heritage
                    end
                end)

                RageUI.UISliderHeritage(GetLabelText("FACE_H_STON"), math.round(iCharacterCreatorData.skinMix, 2) * 10, GetLabelText("FACE_HER_ST_H"), function(Hovered, Selected, Active, Heritage, Index)
                    if cCharacterCreatorData.skinMix ~= Heritage then
                        cCharacterCreatorData.skinMix = Heritage
                        iCharacterCreatorData.skinMix = Heritage
                    end
                end)

                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                heritageSet = true

            end, function()

            end)
        end

        if RageUI.Visible(RMenu:Get('charCreator', 'customFace')) then
            RageUI.DrawContent({ header = true, instructionalButton = true }, function()
                RageUI.List(GetLabelText("FACE_F_BROW"), Items[cCharacterCreatorDataPED][1].List, Items[cCharacterCreatorDataPED][1].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][1].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.eyebrowHeight = 0.5
                            iCharacterCreatorData.eyebrowForward = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.eyebrowHeight = 0.9
                            iCharacterCreatorData.eyebrowForward = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.eyebrowHeight = 0.30
                            iCharacterCreatorData.eyebrowForward = 0.70
                        end
                        self.FACE_F_BROW = true
                        self.FACE_F_CHINS = false
                    else
                        self.FACE_F_BROW = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_EYES"), Items[cCharacterCreatorDataPED][2].List, Items[cCharacterCreatorDataPED][2].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][2].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.eyeOpening = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.eyeOpening = 0.9
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.eyeOpening = 0.30
                        end
                        self.FACE_F_EYES = true
                    else
                        self.FACE_F_EYES = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_NOSE"), Items[cCharacterCreatorDataPED][3].List, Items[cCharacterCreatorDataPED][3].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][3].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.noseWidth = 0.5
                            iCharacterCreatorData.nosePeaklowering = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.noseWidth = 0.9
                            iCharacterCreatorData.nosePeaklowering = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.noseWidth = 0.30
                            iCharacterCreatorData.nosePeaklowering = 0.70
                        end
                        self.FACE_F_NOSE = true
                    else
                        self.FACE_F_NOSE = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_NOSEP"), Items[cCharacterCreatorDataPED][4].List, Items[cCharacterCreatorDataPED][4].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][4].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.noseBoneHeight = 0.5
                            iCharacterCreatorData.noseBoneTwist = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.noseBoneHeight = 0.9
                            iCharacterCreatorData.noseBoneTwist = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.noseBoneHeight = 0.30
                            iCharacterCreatorData.noseBoneTwist = 0.70
                        end
                        self.FACE_F_NOSEP = true
                    else
                        self.FACE_F_NOSEP = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_NOSET"), Items[cCharacterCreatorDataPED][5].List, Items[cCharacterCreatorDataPED][5].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][5].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.nosePeakHeight = 0.5
                            iCharacterCreatorData.nosePeakLength = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.nosePeakHeight = 0.9
                            iCharacterCreatorData.nosePeakLength = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.nosePeakHeight = 0.30
                            iCharacterCreatorData.nosePeakLength = 0.70
                        end
                        self.FACE_F_NOSET = true
                    else
                        self.FACE_F_NOSET = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_CHEEK"), Items[cCharacterCreatorDataPED][6].List, Items[cCharacterCreatorDataPED][6].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][6].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.cheeksBoneHeight = 0.5
                            iCharacterCreatorData.cheeksBoneWidth = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.cheeksBoneHeight = 0.9
                            iCharacterCreatorData.cheeksBoneWidth = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.cheeksBoneHeight = 0.30
                            iCharacterCreatorData.cheeksBoneWidth = 0.70
                        end
                        self.FACE_F_CHEEK = true
                    else
                        self.FACE_F_CHEEK = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_CHEEKS"), Items[cCharacterCreatorDataPED][7].List, Items[cCharacterCreatorDataPED][7].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][7].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.cheeksBoneWidth = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.cheeksBoneWidth = 0.9
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.cheeksBoneWidth = 0.30
                        end
                        self.FACE_F_CHEEKS = true
                    else
                        self.FACE_F_CHEEKS = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_LIPS"), Items[cCharacterCreatorDataPED][8].List, Items[cCharacterCreatorDataPED][8].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][8].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.lipsThickness = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.lipsThickness = 0.9
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.lipsThickness = 0.30
                        end
                        self.FACE_F_LIPS = true
                    else
                        self.FACE_F_LIPS = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_JAW"), Items[cCharacterCreatorDataPED][9].List, Items[cCharacterCreatorDataPED][9].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][9].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.jawBoneWidth = 0.5
                            iCharacterCreatorData.jawBoneBackLength = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.jawBoneWidth = 0.9
                            iCharacterCreatorData.jawBoneBackLength = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.jawBoneWidth = 0.30
                            iCharacterCreatorData.jawBoneBackLength = 0.70
                        end
                        self.FACE_F_JAW = true
                    else
                        self.FACE_F_JAW = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_CHIN"), Items[cCharacterCreatorDataPED][10].List, Items[cCharacterCreatorDataPED][10].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][10].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.chimpBoneLength = 0.5
                            iCharacterCreatorData.chimpBoneWidth = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.chimpBoneLength = 0.9
                            iCharacterCreatorData.chimpBoneWidth = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.chimpBoneLength = 0.30
                            iCharacterCreatorData.chimpBoneWidth = 0.70
                        end
                        self.FACE_F_CHIN = true
                    else
                        self.FACE_F_CHIN = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_CHINS"), Items[cCharacterCreatorDataPED][11].List, Items[cCharacterCreatorDataPED][11].Index, GetLabelText("FACE_FEAT_H"), {}, true, function(Hovered, Active, Selected, Index)
                    Items[cCharacterCreatorDataPED][11].Index = Index
                    if (Active) then
                        if (Index == 1 and Selected) then
                            iCharacterCreatorData.chimpHole = 0.5
                            iCharacterCreatorData.chimpBoneLowering = 0.5
                        elseif (Index == 2 and Selected) then
                            iCharacterCreatorData.chimpHole = 0.9
                            iCharacterCreatorData.chimpBoneLowering = 0.6
                        elseif (Index == 3 and Selected) then
                            iCharacterCreatorData.chimpHole = 0.30
                            iCharacterCreatorData.chimpBoneLowering = 0.70
                        end
                        self.FACE_F_CHINS = true
                        self.FACE_F_BROW = false
                    else
                        self.FACE_F_CHINS = false
                    end
                end)
                TraitSet = true
            end, function()
                ---Panels
                if (self.FACE_F_BROW) then
                    RageUI.GridPanel(iCharacterCreatorData.eyebrowForward, iCharacterCreatorData.eyebrowHeight, "Haut", "Bas", "Intérieur", "Extérieur", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.eyebrowHeight = Y
                        cCharacterCreatorData.eyebrowForward = X
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.eyebrowHeight = Y
                        iCharacterCreatorData.eyebrowForward = X
                    end)
                end
                if (self.FACE_F_EYES) then
                    RageUI.GridPanelHorizontal(iCharacterCreatorData.eyeOpening, "Ouverts", "Plissés", function(Hovered, Active, X)
                        cCharacterCreatorData.eyeOpening = X
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.eyeOpening = X
                    end)
                end
                if (self.FACE_F_NOSE) then
                    --- Nez
                    RageUI.GridPanel(iCharacterCreatorData.noseWidth, iCharacterCreatorData.nosePeaklowering, "Relevé", "Bas", "Fin", "Épais", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.noseWidth = X
                        cCharacterCreatorData.nosePeaklowering = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.noseWidth = X
                        iCharacterCreatorData.nosePeaklowering = Y
                    end)
                end
                if (self.FACE_F_NOSEP) then
                    --- Arête
                    RageUI.GridPanel(iCharacterCreatorData.noseBoneHeight, iCharacterCreatorData.noseBoneTwist, "Saillante", "Incurvée", "Courte", "Longue", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.noseBoneHeight = X
                        cCharacterCreatorData.noseBoneTwist = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.noseBoneHeight = X
                        iCharacterCreatorData.noseBoneTwist = Y
                    end)
                end
                if (self.FACE_F_NOSET) then
                    --- Peak
                    RageUI.GridPanel(iCharacterCreatorData.nosePeakHeight, iCharacterCreatorData.nosePeakLength, "Bout vers le haut", "Bout vers me nas", "Cassé gauche", "Cassé droite", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.nosePeakHeight = X
                        cCharacterCreatorData.nosePeakLength = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.nosePeakHeight = X
                        iCharacterCreatorData.nosePeakLength = Y
                    end)
                end
                if (self.FACE_F_CHEEK) then
                    RageUI.GridPanel(iCharacterCreatorData.cheeksBoneHeight, iCharacterCreatorData.cheeksBoneWidth, "Haut", "Bas", "Intérieur", "Extérieur", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.cheeksBoneHeight = X
                        cCharacterCreatorData.cheeksBoneWidth = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.cheeksBoneHeight = X
                        iCharacterCreatorData.cheeksBoneWidth = Y
                    end)
                end
                if (self.FACE_F_CHEEKS) then
                    RageUI.GridPanelHorizontal(iCharacterCreatorData.cheeksBoneWidth, "Émacié", "Bouffi", function(Hovered, Active, X)
                        cCharacterCreatorData.cheeksBoneWidth = X
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.cheeksBoneWidth = X
                    end)
                end
                if (self.FACE_F_LIPS) then
                    RageUI.GridPanelHorizontal(iCharacterCreatorData.lipsThickness, "Minces", "Épaisses", function(Hovered, Active, X)
                        cCharacterCreatorData.lipsThickness = X
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.lipsThickness = X
                    end)
                end
                if (self.FACE_F_JAW) then
                    RageUI.GridPanel(iCharacterCreatorData.jawBoneWidth, iCharacterCreatorData.jawBoneBackLength, "Ronde", "Carrée", "Étroite", "Large", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.jawBoneWidth = X
                        cCharacterCreatorData.jawBoneBackLength = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.jawBoneWidth = X
                        iCharacterCreatorData.jawBoneBackLength = Y
                    end)
                end
                if (self.FACE_F_CHIN) then
                    RageUI.GridPanel(iCharacterCreatorData.chimpBoneLength, iCharacterCreatorData.chimpBoneWidth, "Haut", "Bas", "Intérieur", "Extérieur", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.chimpBoneLength = X
                        cCharacterCreatorData.chimpBoneWidth = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.chimpBoneLength = X
                        iCharacterCreatorData.chimpBoneWidth = Y
                    end)
                end
                if (self.FACE_F_CHINS) then
                    RageUI.GridPanel(iCharacterCreatorData.chimpHole, iCharacterCreatorData.chimpBoneLowering, "Arrondi", "Fossette", "Carré", "Pointu", function(Hovered, Active, X, Y)
                        cCharacterCreatorData.chimpHole = X
                        cCharacterCreatorData.chimpBoneLowering = Y
                        setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                        iCharacterCreatorData.chimpHole = X
                        iCharacterCreatorData.chimpBoneLowering = Y
                    end)
                end
            end)
        end

        if RageUI.Visible(RMenu:Get('charCreator', 'customAdvanced')) then
            local HairCutStyles = {}
            if (cCharacterCreatorDataPED) == "mp_m_freemode_01" then
                for i = 1, #hairListM, 1 do
                    table.insert(HairCutStyles, hairListM[i].name)
                end
            elseif (cCharacterCreatorDataPED) == "mp_f_freemode_01" then
                for i = 1, #hairListF, 1 do
                    table.insert(HairCutStyles, hairListF[i].name)
                end
            end
            
            RageUI.DrawContent({ header = true, instructionalButton = true }, function()
                RageUI.List(GetLabelText("FACE_HAIR"), HairCutStyles, iCharacterCreatorData.hairStyle, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.hairStyle ~= Index then
                            cCharacterCreatorData.hairStyle = Index -1 
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.hairStyle = Index -1 
                        end
                        self.FACE_HAIR = true
                    else
                        self.FACE_HAIR = false
                    end
                end)
                if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey('mp_m_freemode_01')) then
                    RageUI.List("Barbe", BarbeName, iCharacterCreatorData.beardStyle, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                        if Active then
                            if cCharacterCreatorData.beardStyle ~= Index then
                                cCharacterCreatorData.beardStyle = Index - 1
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.beardStyle = Index - 1
                            end
                            self.FACE_BEARD = true
                        else
                            self.FACE_BEARD = false
                        end
                    end)
                end
                RageUI.List(GetLabelText("FACE_F_SKINB"), tachList, iCharacterCreatorData.blemishesStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.blemishesStyle ~= Index - 1 then
                            cCharacterCreatorData.blemishesStyle = Index - 1 
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.blemishesStyle = Index - 1
                        end
                        self.FACE_TACH = true
                    else
                        self.FACE_TACH = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_SKINA"), rideList, iCharacterCreatorData.ageingStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.ageingStyle ~= Index - 1 then
                            cCharacterCreatorData.ageingStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.ageingStyle = Index - 1
                        end
                        self.FACE_AGE = true
                    else
                        self.FACE_AGE = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_SKC"), SKClist, iCharacterCreatorData.skinAspectStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.skinAspectStyle ~= Index - 1 then
                            cCharacterCreatorData.skinAspectStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.skinAspectStyle = Index - 1
                        end
                        self.skin_Aspect = true
                    else
                        self.skin_Aspect = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_MOLE"), MoleList, iCharacterCreatorData.frecklesStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.frecklesStyle ~= Index - 1 then
                            cCharacterCreatorData.frecklesStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.frecklesStyle = Index - 1
                        end
                        self.freckles = true
                    else
                        self.freckles = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_SUND"), ComplexList, iCharacterCreatorData.complexionStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.complexionStyle ~= Index - 1 then
                            cCharacterCreatorData.complexionStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.complexionStyle = Index - 1
                        end
                        self.complexion = true
                    else
                        self.complexion = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_APP_EYE"), eyesList, iCharacterCreatorData.eyeStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.eyeStyle ~= Index - 1 then
                            cCharacterCreatorData.eyeStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.eyeStyle = Index - 1
                        end
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_EYEM"), MaquillageList, iCharacterCreatorData.makeupStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.makeupStyle ~= Index - 1 then
                            cCharacterCreatorData.makeupStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.makeupStyle = Index - 1
                        end
                        self.makeup = true
                    else
                        self.makeup = false
                    end
                end)
                RageUI.List(GetLabelText("FACE_F_LIPST"), LipsList, iCharacterCreatorData.lipstickStyle + 1, GetLabelText("FACE_APP_H"), {}, true, function(Hovered, Active, Selected, Index)
                    if Active then
                        if cCharacterCreatorData.lipstickStyle ~= Index - 1 then
                            cCharacterCreatorData.lipstickStyle = Index - 1
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.lipstickStyle = Index - 1
                        end
                        self.lipstick = true
                    else
                        self.lipstick = false
                    end
                end)
                ApparenceSet = true
            end, function()
                --- Panel
                if self.FACE_HAIR then
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, colorsPanel.haircut[1], iCharacterCreatorData.hairColor[1] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.hairColor[1] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.hairColor[1] = CurrentIndex - 1
                                colorsPanel.haircut[1] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.hairColor[1] = CurrentIndex - 1
                            end
                        end
                    end)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, colorsPanel.haircut[2], iCharacterCreatorData.hairColor[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.hairColor[2] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.hairColor[2] = CurrentIndex - 1
                                colorsPanel.haircut[2] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.hairColor[2] = CurrentIndex - 1
                            end
                        end
                    end)
                end
                if self.lipstick then
                    RageUI.PercentagePanel(iCharacterCreatorData.lipstickOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.lipstickOpacity ~= Percent then
                                cCharacterCreatorData.lipstickOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.lipstickOpacity = Percent
                            end
                        end
                    end)
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, colorsPanel.lipstick[1], iCharacterCreatorData.lipstickColor[1] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.lipstickColor[1] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.lipstickColor[1] = CurrentIndex - 1
                                colorsPanel.lipstick[1] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.lipstickColor[1] = CurrentIndex - 1
                            end
                        end
                    end)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, colorsPanel.lipstick[2], iCharacterCreatorData.lipstickColor[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.lipstickColor[2] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.lipstickColor[2] = CurrentIndex - 1
                                colorsPanel.lipstick[2] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.lipstickColor[2] = CurrentIndex - 1
                            end
                        end
                    end)
                end
                if self.makeup then
                    RageUI.PercentagePanel(iCharacterCreatorData.makeupOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if cCharacterCreatorData.makeupOpacity ~= Percent then
                            cCharacterCreatorData.makeupOpacity = Percent
                            setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                            iCharacterCreatorData.makeupOpacity = Percent
                        end
                    end)
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, colorsPanel.makeup[1], iCharacterCreatorData.makeupColor[1] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.makeupColor[1] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.makeupColor[1] = CurrentIndex - 1
                                colorsPanel.makeup[1] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.makeupColor[1] = CurrentIndex - 1
                            end
                        end
                    end)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, colorsPanel.makeup[2], iCharacterCreatorData.makeupColor[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.makeupColor[2] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.makeupColor[2] = CurrentIndex - 1
                                colorsPanel.makeup[2] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.makeupColor[2] = CurrentIndex - 1
                            end
                        end
                    end)
                end
                if self.FACE_BEARD then
                    RageUI.PercentagePanel(iCharacterCreatorData.beardOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.beardOpacity ~= Percent then
                                cCharacterCreatorData.beardOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.beardOpacity = Percent
                            end
                        end
                    end)
                    RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, colorsPanel.barber[1], iCharacterCreatorData.beardColor[1] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.beardColor[1] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.beardColor[1] = CurrentIndex - 1
                                colorsPanel.barber[1] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.beardColor[1] = CurrentIndex - 1
                            end
                        end
                    end)
                    RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, colorsPanel.barber[2], iCharacterCreatorData.beardColor[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                        if (Active) then
                            if cCharacterCreatorData.beardColor[2] ~= CurrentIndex - 1 then
                                iCharacterCreatorData.beardColor[2] = CurrentIndex - 1
                                colorsPanel.barber[2] = MinimumIndex
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                cCharacterCreatorData.beardColor[2] = CurrentIndex - 1
                            end
                        end
                    end)
                end
                if self.FACE_TACH then
                    RageUI.PercentagePanel(iCharacterCreatorData.blemishesOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.blemishesOpacity ~= Percent then
                                cCharacterCreatorData.blemishesOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.blemishesOpacity = Percent
                            end
                        end
                    end)
                end
                if self.FACE_AGE then
                    RageUI.PercentagePanel(iCharacterCreatorData.ageingOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.ageingOpacity ~= Percent then
                                cCharacterCreatorData.ageingOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.ageingOpacity = Percent
                            end
                        end
                    end)
                end
                if self.skin_Aspect then
                    RageUI.PercentagePanel(iCharacterCreatorData.skinAspectOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.skinAspectOpacity ~= Percent then
                                cCharacterCreatorData.skinAspectOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.skinAspectOpacity = Percent
                            end
                        end
                    end)
                end
                if self.freckles then
                    RageUI.PercentagePanel(iCharacterCreatorData.frecklesOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.frecklesOpacity ~= Percent then
                                cCharacterCreatorData.frecklesOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.frecklesOpacity = Percent
                            end
                        end
                    end)
                end
                if self.complexion then
                    RageUI.PercentagePanel(iCharacterCreatorData.complexionOpacity, "Opacité", nil, nil, function(Hovered, Active, Percent)
                        if (Active) then
                            if cCharacterCreatorData.complexionOpacity ~= Percent then
                                cCharacterCreatorData.complexionOpacity = Percent
                                setPlayerFaceCreator(GetPlayerPed(-1), cCharacterCreatorData, skin)
                                iCharacterCreatorData.complexionOpacity = Percent
                            end
                        end
                    end)
                end
            end)
        end

        if RageUI.Visible(RMenu:Get('charCreator', 'clothing')) then
            RageUI.DrawContent({ header = true, instructionalButton = true }, function()
                local ped = GetPlayerPed(-1)
                playerPed = ped

                RageUI.Button("Nu(e)", "Nu(e)", {} , true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TenueSet = true
                        SetPedComponentVariation(GetPlayerPed(-1), 8,  15, 0, 2) 
                        SetPedComponentVariation(GetPlayerPed(-1), 11,  15, 0, 2) 
                        SetPedComponentVariation(GetPlayerPed(-1), 3,  15, 0, 2) 
                        SetPedComponentVariation(playerPed, 4,  14,   0, 2)  
                        SetPedComponentVariation(playerPed, 6,  34, 0, 2)

                        myTshirt,myTshirt2,myTorse,myTorse2,myBras,myBras2,myPantalon,myPantalon2,myChaussures,myChaussures2 = 15,0,15,0,15,0,14,0,34,0
                    end
                end)

                RageUI.Button("Tenue De Rue", "Tenue De Rue", {} , true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TenueSet = true
                        SetPedComponentVariation(GetPlayerPed(-1), 8,  23, 0, 2) -- TSHIRT
                        SetPedComponentVariation(GetPlayerPed(-1), 11,  3, 13, 2) -- TORSE
                        SetPedComponentVariation(GetPlayerPed(-1), 3,  4, 0, 2)  -- BRAS
                        SetPedComponentVariation(playerPed, 4,  3,   13, 2)   --PANT
                        SetPedComponentVariation(playerPed, 6,  1, 5, 2)  -- SHOES

                        myTshirt,myTshirt2,myTorse,myTorse2,myBras,myBras2,myPantalon,myPantalon2,myChaussures,myChaussures2 = 23,0,3,13,4,0,3,13,1,5
                    end
                end)

                RageUI.Button("Tenue Décontractée", "Tenue Décontractée", {} , true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TenueSet = true
                        SetPedComponentVariation(GetPlayerPed(-1), 8,  2, 2, 2) -- TSHIRT
                        SetPedComponentVariation(GetPlayerPed(-1), 11,  64, 0, 2) -- TORSE
                        SetPedComponentVariation(GetPlayerPed(-1), 3,  1, 0, 2)  -- BRAS
                        SetPedComponentVariation(playerPed, 4,  22,   0, 2)   --PANT
                        SetPedComponentVariation(playerPed, 6,  1, 0, 2)  -- SHOES

                        myTshirt,myTshirt2,myTorse,myTorse2,myBras,myBras2,myPantalon,myPantalon2,myChaussures,myChaussures2 = 2,2,64,0,1,0,22,0,1,0
                    end
                end)

                RageUI.Button("Tenue Touriste", "Tenue Touriste", {} , true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TenueSet = true
                        SetPedComponentVariation(GetPlayerPed(-1), 8,  15, 0, 2) -- TSHIRT
                        SetPedComponentVariation(GetPlayerPed(-1), 11,  5, 2, 2) -- TORSE
                        SetPedComponentVariation(GetPlayerPed(-1), 3,  5, 0, 2)  -- BRAS
                        SetPedComponentVariation(playerPed, 4,  16,   3, 2)   --PANT
                        SetPedComponentVariation(playerPed, 6,  5, 2, 2)  -- SHOES

                        myTshirt,myTshirt2,myTorse,myTorse2,myBras,myBras2,myPantalon,myPantalon2,myChaussures,myChaussures2 = 15,0,5,2,5,0,16,3,5,2
                    end
                end)

                RageUI.Button("Tenue Costard", "Tenue Costard", {} , true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TenueSet = true
                        SetPedComponentVariation(GetPlayerPed(-1), 8,  33, 0, 2) -- TSHIRT
                        SetPedComponentVariation(GetPlayerPed(-1), 11,  29, 0, 2) -- TORSE
                        SetPedComponentVariation(GetPlayerPed(-1), 3,  4, 0, 2)  -- BRAS
                        SetPedComponentVariation(playerPed, 4,  22,   0, 2)   --PANT
                        SetPedComponentVariation(playerPed, 6,  10, 0, 2)  -- SHOES

                        myTshirt,myTshirt2,myTorse,myTorse2,myBras,myBras2,myPantalon,myPantalon2,myChaussures,myChaussures2 = 33,0,29,0,4,0,22,0,10,0
                    end
                end)

            end, function()
            end)
        end

    end, 1)
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        
RegisterNetEvent("character:openCreationMenu")
AddEventHandler("character:openCreationMenu", function()
    openCharCreatorMenu()
    Wait(25)
    RageUI.Visible(RMenu:Get('charCreator', 'main'), not RageUI.Visible(RMenu:Get('charCreator', 'main')))
end)

RegisterCommand("perso", function()
    openCharCreatorMenu()
    Wait(25)
	RageUI.Visible(RMenu:Get('charCreator', 'main'), not RageUI.Visible(RMenu:Get('charCreator', 'main')))
end)


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
---  TOI DUMPER , AU LIEU DE VOLER DIRECTEMENT MON BEAU TRAVAIL DEMANDE MOI LA  ---
---  PERMISSION SUR DISCORD --> ayznismaybedead#0666 . CAR SI JE TE CHOPE SANS  ---
---  ME DEMANDER , TU ES DANS LE CACA :) ALLER JE TE SOUHAITE UN TRES BON DUMP  ---
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------