Config = {}
-- Are you using ESX? Turn this to true if you would like fuel & jerry cans to cost something.
Config.UseESX = true
-- What should the price of jerry cans be?
Config.JerryCanCost = 25
Config.RefillCost = 50 -- If it is missing half of it capacity, this amount will be divided in half, and so on.
-- Fuel decor - No need to change this, just leave it.
Config.FuelDecor = "_FUEL_LEVEL"
-- What keys are disabled while you're fueling.
Config.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}
-- Want to use the HUD? Turn this to true.
Config.EnableHUD = false
-- Configure blips here. Turn both to false to disable blips all together.
Config.ShowNearestGasStationOnly = false
Config.ShowAllGasStations = true
-- Configure the strings as you wish here.
Config.Strings = {
	ExitVehicle = "Sortez pour faire le plein de votre véhicule",
	EToRefuel = "Appuyez sur ~g~E ~w~pour faire le plein de votre véhicule",
	JerryCanEmpty = "Bidon d'essence' vide",
	FullTank = "Le réservoir est plein",
	PurchaseJerryCan = "Appuyez sur ~g~E ~w~pour acheter un bidon d'essence' pour ~g~$" .. Config.JerryCanCost,
	CancelFuelingPump = "Appuyez sur ~g~E ~w~pour annuler le ravitaillement du véhicule",
	CancelFuelingJerryCan = "Appuyez sur ~g~E ~w~pour arrêter le ravitaillement",
	NotEnoughCash = "Pas assez d'argent",
	RefillJerryCan = "Appuyez sur ~g~E ~w~ pour remplir le bidon d'essence",
	NotEnoughCashJerryCan = "Pas assez d'argent pour remplir le bidon d'essence",
	JerryCanFull = "Bidon d'essence plein",
	TotalCost = "Prix",
}

if not Config.UseESX then
	Config.Strings.PurchaseJerryCan = "Appuyez sur ~g~E ~w~ pour prendre un bidon d'essence"
	Config.Strings.RefillJerryCan = "Appuyez sur ~g~E ~w~ pour remplir le bidon d'essence"
end

Config.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
Config.Blacklist = {
	"dilettante"
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
Config.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
Config.Classes = {
	[0] = 0.0, -- Compacts
	[1] = 0.2, -- Sedans
	[2] = 0.2, -- SUVs
	[3] = 0.3, -- Coupes
	[4] = 0.3, -- Muscle
	[5] = 0.3, -- Sports Classics
	[6] = 0.4, -- Sports
	[7] = 0.4, -- Super
	[8] = 0.3, -- Motorcycles
	[9] = 0.3, -- Off-road
	[10] = 0.3, -- Industrial
	[11] = 0.3, -- Utility
	[12] = 0.3, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.1, -- Boats
	[15] = 0.1, -- Helicopters
	[16] = 0.1, -- Planes
	[17] = 0.2, -- Service
	[18] = 0.2, -- Emergency
	[19] = 0.3, -- Military
	[20] = 0.3, -- Commercial
	[21] = 0.3, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
Config.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

Config.GasStations = {
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-724.619, -935.1631, 19.213),
	vector3(265.648, -1261.309, 29.292)
}