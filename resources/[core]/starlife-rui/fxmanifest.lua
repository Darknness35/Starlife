fx_version 'bodacious'
games { 'gta5' };


server_script '@mysql-async/lib/MySQL.lua'


client_scripts {
    '@es_extended/locale.lua',

    'RageUI/src/RMenu.lua',
    'RageUI/src/menu/RageUI.lua',
    'RageUI/src/menu/Menu.lua',
    'RageUI/src/menu/MenuController.lua',

    'RageUI/src/components/*.lua',

    'RageUI/src/menu/elements/*.lua',

    'RageUI/src/menu/items/*.lua',

    'RageUI/src/menu/panels/*.lua',

    'RageUI/src/menu/panels/*.lua',
    'RageUI/src/menu/windows/*.lua',


    'config.lua',

    --MENUS
    --'menus/character/character_cl.lua',
    --'menus/garages/garage_cl.lua',
    --'menus/menuillegal/menuillegal_cl.lua',
    'menus/parametres/parameters.lua',

    --JOBS
    'jobs/interim.lua',
    'jobs/functions.lua',
    'jobs/metiers/bucheron.lua',
    'jobs/metiers/mineur.lua',

    --SHOPS
    'shops/armureries.lua',
    'shops/autoecole.lua',
    'shops/location.lua',
    --'shops/poleemploi.lua',
    'shops/superettes.lua',
    'utils/functions.lua'
}

server_scripts {
    '@es_extended/locale.lua',

    'config.lua',

    --menus
    --'menus/character/character_sv.lua',
    --'menus/garages/garage_sv.lua',
    --'menus/menuillegal/menuillegal_sv.lua',

    --SHOPS
    'shops/server.lua'
}

dependencies {
	'es_extended',
    'skinchanger',
    'esx_base'
}