Config = {}

Config.Locale = 'fr'
Config.DrawDistance = 15.0
Config.Size = {x = 1.0, y = 1.0, z = 1.5}
Config.Color = {r = 102, g = 102, b = 204}
Config.Type = 23

-- Blips
Config.Map = {
  -- Jobs
  --{name= "Pôle-Emploi", color= 27, id= 407, x= -268.9, y= -956.2, z= 30.4},
  -- Avocat
  {name= "Avocat", color= 2, id= 535, x= -1904.84, y= -570.815, z= 18.2},
  -- Journalist
  {name= "Journaliste", color= 5, id= 135, x= -582.97, y= -927.92, z= 41.06},
  -- Taxi
  {name= "Taxi", color= 5, id= 198, x= 895.44, y= -179.49, z= 74.6},
  -- The Palace
  --{name= "The Palace", color= 7, id= 304, x= -430.1980, y= 261.8168, z= 82.2},
  -- Daymson
  --{name= "Star Record", color= 1, id= 136, x = -437.412, y= 163.855, z= 77.35},
  -- Tabac
  {name= "Tabac", color= 8, id= 79, x= 2347.77, y= 3121.75, z= 47.25},
  -- Vigneron
  {name= "Vigneron", color= 7, id= 93, x= -1928.74, y= 2059.92, z= 139.95},
  -- Bucheron
  --{name= "Bucheron", color= 10, id= 237, x= -572.96, y= 5336.97, z= 70.2},
  -- Unicorn
  {name= "Unicorn", color = 8, id = 121, x= 132.038, y= -1286.822, z= 28.970},
  -- license drogud
  --{name= "Vendeur de licenses", color = 32 , id = 163 , x = 707.17, y = -962.5, z = 30.4},
  --agence
  {name= "Agence Immobilière", color = 1 , id = 357 , x = -200.52, y = -576.132, z = 40.489},
  --gofast
  --{name= "GoFast", color = 1 , id = 315 , x = 1569.8156, y = -2130.1, z = 78.33},
  --pizzeria
  --{name= "Pizzeria", color = 5 , id = 103 , x = 217.59413146973, y = -28.255523681641, z = 69.713890075684},
  --la poste
  --{name= "La Poste", color = 5 , id = 357 , x = 78.899, y = 111.934, z = 80.1},
  --Bacars
  {name= "Bacars", color = 7 , id = 72 , x = -212.01, y = -1324.3, z = 30.89},
  --Braquage bijouterie
  {name= "Bijouterie", color = 4 , id = 439 , x = -629.99, y = -236.542, z = 38.05},
  --auto ecole
  --{name= "Auto-Ecole", color = 5 , id = 408 , x = 239.471, y = -1380.960, z = 32.741},
}

-- Pole emploi
Config.ZonesPE = {
	{x = -268.93, y = -956.245, z = 30.4}
}

-- esx_accessories
Config.Price = 1000
Config.ShopsBlipsAcessories = {
	Ears = {
		Pos = nil,
		Blip = nil
	},
	Mask = {
		Pos = { 
			{ x = -1338.129, y = -1278.200, z = 3.872 },
		},
		Blip = { sprite = 362, color = 2 }
	},
	Helmet = {
		Pos = nil,
		Blip = nil
	},
	Glasses = {
		Pos = nil,
		Blip = nil
	}
}

Config.ZonesAccessories = {
	Ears = {
		Pos = {
			{x= 80.374, y= -1389.493, z= 28.406},
			{x= -709.426, y= -153.829, z= 36.535},
			{x= -163.093, y= -302.038, z= 38.853},
			{x= 420.787, y= -809.654, z= 28.611},
			{x= -817.070, y= -1075.96, z= 10.448},
			{x= -1451.300, y= -238.254, z= 48.929},
			{x= -0.756, y= 6513.685, z= 30.997},
			{x= 123.431, y= -208.060, z= 53.677},
			{x= 1687.318, y= 4827.685, z= 41.183},
			{x= 622.806, y= 2749.221, z= 41.208},
			{x= 1200.085, y= 2705.428, z= 37.342},
			{x= -1199.959, y= -782.534,	z= 16.452},
			{x= -3171.867, y= 1059.632,	z= 19.983},
			{x= -1095.670, y= 2709.245,	z= 18.227}
		}
	},
	Mask = {
		Pos = {
			{x = -1338.129, y = -1278.2, z = 3.9}
		}
	},
	Helmet = {
		Pos = {
			{x= 81.576, y= -1400.602, z= 28.406},
			{x= -705.845, y= -159.015, z= 36.535},
			{x= -161.349, y= -295.774, z= 38.853},
			{x= 419.319, y= -800.647, z= 28.611},
			{x= -824.362, y= -1081.741, z= 10.448},
			{x= -1454.888, y= -242.911, z= 48.931},
			{x= 4.770, y= 6520.935, z= 30.997},
			{x= 121.071, y= -223.266, z= 53.377},
			{x= 1689.648, y= 4818.805, z= 41.183},
			{x= 613.971, y= 2749.978, z= 41.208},
			{x= 1189.513, y= 2703.947, z= 37.342},
			{x= -1204.025, y= -774.439, z= 16.452},
			{x= -3164.280, y= 1054.705, z= 19.983},
			{x= -1103.125, y= 2700.599, z= 18.227}
		}
	},
	Glasses = {
		Pos = {
			{x= 75.287, y= -1391.131, z= 28.406},
			{x= -713.102, y= -160.116, z= 36.535},
			{x= -156.171, y= -300.547, z= 38.853},
			{x= 425.478, y= -807.866, z= 28.611},
			{x= -820.853, y= -1072.940, z= 10.448},
			{x= -1458.052, y= -236.783, z= 48.918},
			{x= 3.587, y= 6511.585, z= 30.997},
			{x= 131.335, y= -212.336, z= 53.677},
			{x= 1694.936, y= 4820.837, z= 41.183},
			{x= 613.972, y= 2768.814, z= 41.208},
			{x= 1198.678, y= 2711.011, z= 37.342},
			{x= -1188.227, y= -764.594, z= 16.452},
			{x= -3173.192, y= 1038.228, z= 19.983},
			{x= -1100.494, y= 2712.481, z= 18.227}
		}
	}
}
