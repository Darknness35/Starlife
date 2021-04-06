Config = {}
Config.DrawDistance = 15
Config.Size = {x = 1.5, y = 1.5, z = 1.5}
Config.Color = {r = 0, g = 128, b = 255}
Config.Type = 1
Config.Locale = 'fr'
Config.Zones = {}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
    -- weight == 0 : The item do not affect character inventory weight
    -- weight > 0 : The item cost place on inventory
    -- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1

-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
    -- Items
    bread = 300,
    water = 200,
    bandage = 500,
    blowpipe = 500,
    carokit = 400,
    carotool = 400,
    fixkit = 800,
    fixtool = 800,
    gazbottle = 800,
    gym_membership = 120,
    medikit = 250,
    phone = 200,
    powerade = 330,
    protein_shake = 330,
    sportlunch = 330,
    cdvierge = 1000,
    cddaym = 1000,
    gps = 250,
    keycard = 150,
    up7 = 330,
    coca = 330,
    fanta = 330,
    sprite = 330,
    orangina = 330,
    milk = 330,
    tea = 330,
    coffee = 330,
    jusfruit = 330,
    energy = 330,
    hamburger = 125,
    frites = 125,
    viande = 400,
    fishburger = 125,
    veganburger = 125,
    hotdog = 125,
    pizza = 125,
    brolly = 350,
    kitpic = 450,
    ball = 250,
    mask_swim = 500,
    bong = 200,
    tatgun = 330,
    bullet1 = 1500,
    bullet2 = 2000,
    bullet3 = 2500,
    bullet4 = 3000,
    rose = 150,
    notepad = 200,
    hazmat1 = 500,
    hazmat2 = 500,
    hazmat3 = 500,
    hazmat4 = 500,
    casapapel = 500,
    karting1 = 500,
    karting2 = 500,
    skydiving = 500,
    prisonnier = 500,
    badgelspd = 250,
    feuilletabac = 350,
    tabacsec = 500,
    malbora = 350,
    briquet = 500,
    cigar = 400,
    raisin = 500,
    vin = 1000,
    jusraisin = 900,
    poissoncru = 500,
    poisson = 1000,
    mojito = 330,
    rhum = 330,
    biere = 330,
    cocktail = 500,
    sucrecanne = 330,
    menthe = 200,
    citron = 200,
    waterg = 330,
    glacon = 200,
    levure = 200,
    juscanne = 200,
    houblon = 1000,
    malt = 1000,
    banane = 200,
    sirop = 200,
    bois = 3500,
    planche = 1000,
    paquetplanche = 4000,
    poule = 500,
    viandepoulet = 500,
    paquetnuggets = 1000,
    weed = 1500,
    weed_pooch = 750,
    coke = 1500,
    coke_pooch = 750,
    meth = 1500,
    meth_pooch = 750,
    opium = 1500,
    opium_pooch = 750,

  -- Armes
    WEAPON_COMBATPISTOL = 1000, -- poid pour une munnition
    WEAPON_KNIFE = 1000,
    WEAPON_NIGHTSTICK = 1000,
    WEAPON_HAMMER = 1000,
    WEAPON_BAT = 1000,
    WEAPON_katana = 1000,
    WEAPON_GOLFCLUB = 1000,
    WEAPON_CROWBAR = 1000,
    WEAPON_PISTOL = 1000,
    WEAPON_PISTOL_MK2 = 1000,
    WEAPON_APPISTOL = 1000,
    WEAPON_PISTOL50 = 1000,
    WEAPON_REVOLVER = 1000,
    WEAPON_REVOLVER_MK2 = 1000,
    WEAPON_SNSPISTOL = 1000,
    WEAPON_SNSPISTOL_MK2 = 1000,
    WEAPON_HEAVYPISTOL = 1000,
    WEAPON_VINTAGEPISTOL = 1000,
    WEAPON_MICROSMG = 1000,
    WEAPON_SMG = 1000,
    WEAPON_SMG_MK2 = 1000,
    WEAPON_ASSAULTSMG = 1000,
    WEAPON_MINISMG = 1000,
    WEAPON_MACHINEPISTOL = 1000,
    WEAPON_COMBATPDW = 1000,
    WEAPON_PUMPSHOTGUN = 1000,
    WEAPON_PUMPSHOTGUN_MK2 = 1000,
    WEAPON_SAWNOFFSHOTGUN = 1000,
    WEAPON_ASSAULTSHOTGUN = 1000,
    WEAPON_BULLPUPSHOTGUN = 1000,
    WEAPON_HEAVYSHOTGUN = 1000,
    WEAPON_ASSAULTRIFLE = 1000,
    WEAPON_ASSAULTRIFLE_MK2 = 1000,
    WEAPON_CARBINERIFLE = 1000,
    WEAPON_CARBINERIFLE_MK2 = 1000,
    WEAPON_ADVANCEDRIFLE = 1000,
    WEAPON_SPECIALCARBINE = 1000,
    WEAPON_SPECIALCARBINE_MK2 = 1000,
    WEAPON_BULLPUPRIFLE = 1000,
    WEAPON_BULLPUPRIFLE_MK2 = 1000,
    WEAPON_MG = 1000,
    WEAPON_COMBATMG = 1000,
    WEAPON_COMBATMG_MK2 = 1000,
    WEAPON_GUSENBERG = 1000,
    WEAPON_SNIPERRIFLE = 1000,
    WEAPON_HEAVYSNIPER = 1000,
    WEAPON_HEAVYSNIPER_MK2 = 1000,
    WEAPON_MARKSMANRIFLE = 1000,
    WEAPON_MARKSMANRIFLE_MK2 = 1000,
    WEAPON_GRENADELAUNCHER = 1000,
    WEAPON_GRENADELAUNCHER_SMOKE = 1000,
    WEAPON_RPG = 1000,
    WEAPON_STINGER = 1000,
    WEAPON_GRENADE = 1000,
    WEAPON_STICKYBOMB = 1000,
    WEAPON_SMOKEGRENADE = 1000,
    WEAPON_BZGAS = 1000,
    WEAPON_MOLOTOV = 1000,
    WEAPON_FIREEXTINGUISHER = 1000,
    WEAPON_PETROLCAN = 1000,
    WEAPON_BALL = 1000,
    WEAPON_BOTTLE = 1000,
    WEAPON_DIGISCANNER = 1000,
    WEAPON_DAGGER = 1000,
    WEAPON_FIREWORK = 1000,
    WEAPON_MUSKET = 1000,
    WEAPON_STUNGUN = 1000,
    WEAPON_HOMINGLAUNCHER = 1000,
    WEAPON_PROXMINE = 1000,
    WEAPON_SNOWBALL = 1000,
    WEAPON_FLAREGUN = 1000,
    WEAPON_GARBAGEBAG = 1000,
    WEAPON_HANDCUFFS = 1000,
    WEAPON_MARKSMANPISTOL = 1000,
    WEAPON_KNUCKLE = 1000,
    WEAPON_HATCHET = 1000,
    WEAPON_RAILGUN = 1000,
    WEAPON_MACHETE = 1000,
    WEAPON_SWITCHBLADE = 1000,
    WEAPON_DBSHOTGUN = 1000,
    WEAPON_AUTOSHOTGUN = 1000,
    WEAPON_BATTLEAXE = 1000,
    WEAPON_COMPACTLAUNCHER = 1000,
    WEAPON_PIPEBOMB = 1000,
    WEAPON_POOLCUE = 1000,
    WEAPON_WRENCH = 1000,
    WEAPON_FLASHLIGHT = 1000,
    GADGET_NIGHTVISION = 1000,
    GADGET_PARACHUTE = 1000,
    WEAPON_FLARE = 1000,
    WEAPON_DOUBLEACTION = 1000,
    WEAPON_RAYPISTOL = 1000,
    WEAPON_RAYCARBINE = 1000,
    WEAPON_RAYMINIGUN = 1000,
    -- Argent Sale
    black_money = 1, -- poids pour 1$
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 180000, --Off-road
    [10] = 200000, --Industrial
    [11] = 70000, --Utility
    [12] = 100000, --Vans
    [13] = 5, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 300000, --Commercial
    [21] = 0, --Trains
}

cfg = {
	deformationMultiplier = -1, -- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch
	deformationExponent = 1.0, -- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	collisionDamageExponent = 1.0, -- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	damageFactorEngine = 5.1, -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorBody = 5.1, -- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	engineDamageExponent = 1.0, -- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	weaponsDamageMultiplier = 0.124, -- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
	degradingHealthSpeedFactor = 7.4, -- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
	cascadingFailureSpeedFactor = 4.5, -- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8
	degradingFailureThreshold = 650.0, -- Below this value, slow health degradation will set in
	cascadingFailureThreshold = 280.0, -- Below this value, health cascading failure will set in
	engineSafeGuard = 100.0, -- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.
	torqueMultiplierEnabled = true, -- Decrease engine torge as engine gets more and more damaged
	limpMode = false, -- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
	limpModeMultiplier = 0.15, -- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25
	preventVehicleFlip = true, -- If true, you can't turn over an upside down vehicle
	sundayDriver = true, -- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
	sundayDriverAcceleratorCurve = 7.5, -- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	sundayDriverBrakeCurve = 5.0, -- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers
	compatibilityMode = false, -- prevents other scripts from modifying the fuel tank health to avoid random engine failure with BVA 2.01 (Downside is it disabled explosion prevention)

	randomTireBurstInterval = 0, -- Number of minutes (statistically, not precisely) to drive above 22 mph before you get a tire puncture. 0=feature is disabled

	classDamageMultiplier = {
		[0] = 	1.0, --	0: Compacts
				1.0, --	1: Sedans
				1.0, --	2: SUVs
				0.95, -- 3: Coupes
				1.0, --	4: Muscle
				0.95, -- 5: Sports Classics
				0.95, -- 6: Sports
				0.95, -- 7: Super
				0.27, -- 8: Motorcycles
				0.7, --	9: Off-road
				0.25, -- 10: Industrial
				0.35, -- 11: Utility
				0.85, -- 12: Vans
				1.0, --	13: Cycles
				0.4, --	14: Boats
				0.7, --	15: Helicopters
				0.7, --	16: Planes
				0.75, -- 17: Service
				0.85, -- 18: Emergency
				0.67, -- 19: Military
				0.43, -- 20: Commercial
				1.0 -- 21: Trains
	}
}