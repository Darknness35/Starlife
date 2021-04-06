Config = {}

Config.DrawDistance = 15.0
Config.MarkerType = 1
Config.MarkerSize = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement = true
Config.EnableArmoryManagement = true
Config.EnableESXIdentity = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds = false -- turn this on if you want custom peds
Config.EnableLicenses = true -- enable if you're using esx_license
Config.EnableHandcuffTimer = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer = 10 * 60000 -- 10 mins
Config.EnableJobBlip = true -- enable blips for colleagues, requires esx_society
Config.MaxInService = -1
Config.Locale = 'fr'
Config.PoliceStations = {

    LSPD = {
        Blip = {
            Coords = vector3(425.1, -979.5, 30.7),
            Sprite = 60,
            Display = 4,
            Scale = 0.9,
            Colour = 29
        },
        Cloakrooms = {
            vector3(452.6, -992.8, 30.6)
        },
        Armories = {
            vector3(452.4, -980.1, 30.68)
        },
        Vehicles = {
            {
                Spawner = vector3(454.6, -1017.4, 28.4),
                InsideShop = vector3(228.5, -993.5, -99.5),
                SpawnPoints = {
                    { coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0 },
                    { coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
                    { coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
                    { coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
                }
            },
            {
                Spawner = vector3(473.3, -1018.8, 28.0),
                InsideShop = vector3(228.5, -993.5, -99.0),
                SpawnPoints = {
                    { coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
                    { coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
                }
            }
        },
        Helicopters = {
            {
                Spawner = vector3(461.1, -981.5, 43.6),
                InsideShop = vector3(477.0, -1106.4, 43.0),
                SpawnPoints = {
                    { coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
                }
            }
        },
        BossActions = {
            vector3(448.4, -973.2, 30.6)
        }
    }
}

Config.AuthorizedWeapons = {
    recruit = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    officer = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    sergeant = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    intendent = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    lieutenant = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
        { weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 15000 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    chef = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
        { weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 15000 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    capitaine = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
        { weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 15000 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    },
    boss = {
        { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 1500 },
        { weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
        { weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 15000 },
        { weapon = 'WEAPON_NIGHTSTICK', price = 500 },
        { weapon = 'WEAPON_STUNGUN', price = 1000 },
        { weapon = 'WEAPON_FLASHLIGHT', price = 300 }
    }
}

Config.AuthorizedVehicles = {
    Shared = {
        { model = 'tribike', label = 'Vélo', price = 250 },
        { model = 'police', label = 'Victoria', price = 700 }
    },
    recruit = {},
    officer = {
        { model = 'police', label = 'Police Interceptor', price = 700 },
        --{ model = 'police5', label = 'SUV Interceptor', price = 800 },
        { model = 'police2', label = 'Ford Cruiser', price = 700 },
        { model = 'policeb', label = 'Police Moto', price = 500 }
    },
    sergeant = {
        { model = 'police2', label = 'Police Cruiser', price = 700 },
        { model = 'police3', label = 'Police Interceptor', price = 600 },
        { model = 'policet', label = 'Police Transporter', price = 700 },
        --{ model = 'police5', label = 'SUV Interceptor', price = 800 },
        { model = 'police', label = 'Ford Cruiser', price = 700 },
        { model = 'policeb', label = 'Police Bike', price = 800 }
    },
    intendent = {},
    lieutenant = {
        { model = 'police2', label = 'Police Cruiser', price = 700 },
        { model = 'police3', label = 'Police Interceptor', price = 600 },
        --{ model = 'police5', label = 'SUV Interceptor', price = 800 },
        { model = 'policet', label = 'Police Transporter', price = 700 },
        { model = 'policeb', label = 'Police Bike', price = 800 },
        { model = 'pbus', label = 'Police Prison Bus', price = 500 },
        { model = 'riot', label = 'Police Riot', price = 1000 },
        { model = 'police4', label = 'Cruiser Banalisé', price = 800 },
        { model = 'fbi2', label = 'SUV Banalisé', price = 1000 }
    },
    chef = {
        { model = 'police2', label = 'Police Cruiser', price = 700 },
        { model = 'police3', label = 'Police Interceptor', price = 600 },
        { model = 'policet', label = 'Police Transporter', price = 800 },
        { model = 'policeb', label = 'Police Bike', price = 800 },
        { model = 'pbus', label = 'Police Prison Bus', price = 500 },
        { model = 'riot', label = 'Police Riot', price = 1000 },
        { model = 'police4', label = 'Cruiser Banalisé', price = 800 },
        { model = 'fbi2', label = 'SUV Banalisé', price = 1000 }
    },
    capitaine = {
        { model = 'police2', label = 'Police Cruiser', price = 700 },
        { model = 'police3', label = 'Police Interceptor', price = 600 },
        --{ model = 'police5', label = 'SUV Interceptor', price = 800 },
        { model = 'policet', label = 'Police Transporter', price = 800 },
        { model = 'policeb', label = 'Police Bike', price = 800 },
        { model = 'pbus', label = 'Police Prison Bus', price = 500 },
        { model = 'riot', label = 'Police Riot', price = 1000 },
        { model = 'police4', label = 'Cruiser Banalisé', price = 800 },
        { model = 'policefelon', label = 'Felon Banalisée', price = 900 },
        { model = 'fbi2', label = 'SUV Banalisé', price = 1000 }    
    },
    boss = {
        { model = 'police2', label = 'Police Cruiser', price = 700 },
        { model = 'police3', label = 'Police Interceptor', price = 600 },
        --{ model = 'police5', label = 'SUV Interceptor', price = 800 },
        { model = 'policet', label = 'Police Transporter', price = 800 },
        { model = 'policeb', label = 'Police Bike', price = 800 },
        { model = 'pbus', label = 'Police Prison Bus', price = 500 },
        { model = 'riot', label = 'Police Riot', price = 1000 },
        { model = 'police4', label = 'Cruiser Banalisé', price = 800 },
        { model = 'fbi2', label = 'SUV Banalisé', price = 1000 },
        { model = 'policefelon', label = 'Felon Banalisée', price = 900 },
        { model = 'pol718', label = 'Porsche Cayman', price = 1000 }
    }
}

Config.AuthorizedHelicopters = {
    recruit = {},
    officer = {},
    sergeant = {},
    intendent = {},
    lieutenant = {
        { model = 'polmav', label = 'Police Maverick', livery = 0, price = 900 }
    },
    chef = {
        { model = 'polmav', label = 'Police Maverick', livery = 0, price = 900 }
    },
    capitaine = {
        { model = 'polmav', label = 'Police Maverick', livery = 0, price = 900 }
    },
    boss = {
        { model = 'polmav', label = 'Police Maverick', livery = 0, price = 900 }
    }
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
    recruit_wear = {
        male = {
            ['tshirt_1'] = 59,  ['tshirt_2'] = 1,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 46,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 36,  ['tshirt_2'] = 1,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = 45,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    officer_wear = {
        male = {
            ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    sergeant_wear = {
        male = {
            ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 8,   ['decals_2'] = 1,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 7,   ['decals_2'] = 1,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    lieutenant_wear = { -- currently the same as intendent_wear
        male = {
            ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 8,   ['decals_2'] = 2,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 7,   ['decals_2'] = 2,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    capitaine_wear = {
        male = {
            ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 8,   ['decals_2'] = 3,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 7,   ['decals_2'] = 3,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    boss_wear = { -- currently the same as chef_wear
        male = {
            ['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 8,   ['decals_2'] = 3,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 48,   ['torso_2'] = 0,
            ['decals_1'] = 7,   ['decals_2'] = 3,
            ['arms'] = 44,
            ['pants_1'] = 34,   ['pants_2'] = 0,
            ['shoes_1'] = 27,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
        }
    },
    bullet_wear = {
        male = {
            ['bproof_1'] = 11,  ['bproof_2'] = 1
        },
        female = {
            ['bproof_1'] = 13,  ['bproof_2'] = 1
        }
    },
    gilet_wear = {
        male = {
            ['tshirt_1'] = 59,  ['tshirt_2'] = 1
        },
        female = {
            ['tshirt_1'] = 36,  ['tshirt_2'] = 1
        }
    }

}