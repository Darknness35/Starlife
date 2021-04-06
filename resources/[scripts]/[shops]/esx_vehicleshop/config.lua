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
		Pos = { x = -55.606, y = -1098.122, z = 26.422 },
		Size = { x = 1.2, y = 1.2, z = 0.6 },
		Type = -1
	},
	ShopInside = {
		Pos = { x = -31.743, y = -1091.759, z = 25.422 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 330.221,
		Type = -1
	},
	ShopOutside = {
		Pos = { x = -48.2081, y = -1096.262, z = 25.422 },
		Size = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 135.55,
		Type = -1
	},
	BossActions = {
		Pos = { x = -31.97, y = -1114.121, z = 26.42 },
		Size = { x = 1.0, y = 1.0, z = 0.5 },
		Type = 1
	}
}