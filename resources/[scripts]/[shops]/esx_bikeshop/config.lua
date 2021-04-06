Config = {}
Config.DrawDistance = 15.0
Config.MarkerColor = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage = 50
Config.Locale = 'fr'
Config.LicenseEnable = true -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters = 3
Config.PlateNumbers = 3
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = {
		Pos = { x = 969.63, y = -113.04, z = 73.4 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Type = 1
	},
	ShopInside = {
		Pos = { x = 971.97, y = -115.75, z = 74.35 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = -20.0,
		Type = -1
	},
	ShopOutside = {
		Pos = { x = 964.92, y = -119.25, z = 74.35 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 231.179,
		Type = -1
	},
	BossActions = {
		Pos = { x = 986.75, y = -92.73, z = 73.85 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Type = -1
	}
	--[[ GiveBackVehicle = {
		Pos = { x = 969.65, y = -143.39, z = 73.4 },
		Size = { x = 3.0, y = 3.0, z = 1.0 },
		Type = (Config.EnablePlayerManagement and 1 or -1)
	} ]]
--[[ 	ResellVehicle = {
		Pos = { x = 954.41, y = -133.89, z = 73.5 },
		Size = { x = 3.0, y = 3.0, z = 1.0 },
		Type = 1
	} ]]
}