ConfigDoors = {}
ConfigDoors.Locale = 'fr'

ConfigDoors.DoorList = {

	-- Entrance Doors
	{
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 434.747, y = -980.618, z = 30.839},
		textCoords = {x = 434.747, y = -981.50, z = 31.50},
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5
	},

	{
		objName = 'v_ilev_ph_door002',
		objCoords  = {x = 434.747, y = -983.215, z = 30.839},
		textCoords = {x = 434.747, y = -982.50, z = 31.50},
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objCoords  = {x = 447.238, y = -980.630, z = 30.689},
		textCoords = {x = 447.200, y = -980.010, z = 31.739},
		authorizedJobs = { 'police' },
		locked = true
	},


	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 463.815, y = -992.686, z = 24.9149},
		textCoords = {x = 463.30, y = -992.686, z = 25.10},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.381, y = -993.651, z = 24.914},
		textCoords = {x = 461.806, y = -993.308, z = 25.064},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.331, y = -998.152, z = 24.914},
		textCoords = {x = 461.806, y = -998.800, z = 25.064},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objCoords  = {x = 462.704, y = -1001.92, z = 24.9149},
		textCoords = {x = 461.806, y = -1002.450, z = 25.064},
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Prison petite porte
	{
		objName = 'prop_fnclink_03gate5',
		objCoords  = {x = 1797.76, y = 2596.56, z = 46.38},
		textCoords = {x = 1797.76, y = 2596.56, z = 46.38},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.5,
		size = 2
	},

    --Mecano
	{
		objName = 'prop_com_ls_door_01',
		objCoords  = {x = -356.099, y = -134.768, z = 40.053},
		textCoords = {x = -356.099, y = -134.768, z = 40.053},
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 15.0,
		size = 0.9
	},


	-- Unicorn (Entrée)
	{
		objName = 'prop_strip_door_01',
		objCoords = {x = 127.955, y = -1298.503, z = 29.419},
		textCoords = {x = 128.555, y = -1298.503, z = 29.419},
		authorizedJobs = { 'unicorn' },
		locked = true,
		distance = 2.5,
		size = 0.8
	},


	-- Porte BACARS (Blackface)
	{
		objName = 'lr_prop_supermod_door_01',
		objCoords  = {x = -205.6828, y = -1310.683, z = 30.29572},
		textCoords = {x = -205.6828, y = -1310.6826171875, z = 31.259550094604492},
		authorizedJobs = {'bacars'},
		locked = true,
		distance = 8.0,
		size = 0.8
		
	}


}