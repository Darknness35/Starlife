fx_version 'bodacious'



game 'gta5'



client_scripts {

    '@es_extended/locale.lua',

    'utils/richpresence/client.lua',

    'utils/teleport/client.lua',

    'utils/circleblips/client.lua',

    'utils/anims/client.lua',

    'utils/doors/config.lua',

    'utils/doors/client.lua',

    'utils/other/cl_takehostage.lua',

    'utils/other/discord.lua',

    'utils/other/drift.lua',

    'utils/other/npc.lua',

    'utils/weap-accessories/weapons_cl.lua',

    'utils/voice/animation.lua',

    'utils/voice/vocalchat.lua',

    'utils/sync/vs_client.lua',

    'illegal/drop/drop_cl.lua',



    --BRAQUAGES

    'illegal/braquages/config.lua',

    'illegal/braquages/client/main.lua',

    'illegal/braquages/config.lua',



    --drogues

    'illegal/drogues/config.lua',

    'illegal/drogues/client/esx_drugs_cl.lua',

    --bitcoin

    --'illegal/bitcoin/config.lua',

   -- 'illegal/bitcoin/client.lua',



    --gofast

    'illegal/gofast/cl_GoFast.lua',



    --blanchiment

    'illegal/blanchisseur/config.lua',

    'illegal/blanchisseur/client.lua',



    --jobs

    'jobs/jobs/config.lua',

    'jobs/jobs/client/*.lua',

    'jobs/jobs/locales/fr.lua',

}



server_scripts {

    '@es_extended/locale.lua',

    '@mysql-async/lib/MySQL.lua',

    'utils/doors/config.lua',

    'utils/doors/server.lua',

    'utils/anims/server.lua',

    'utils/other/sv_takehostage.lua',

    'utils/weap-accessories/weapons_sv.lua',

    'utils/sync/vs_server.lua',



    --BRAQUAGES

    'illegal/braquages/config.lua',

    'illegal/braquages/server/main.lua',

    --bitcoin

    --'illegal/bitcoin/config.lua',

    --'illegal/bitcoin/server.lua',

    --drogues

    'illegal/drogues/config.lua',

    'illegal/drogues/server/esx_drugs_sv.lua',

    



    --gofast

    'illegal/gofast/srv_GoFast.lua',



    --blanchiment

    'illegal/blanchisseur/config.lua',

    'illegal/blanchisseur/server.lua',



    --jobs

    'jobs/jobs/config.lua',

    'jobs/jobs/server/main.lua',

    'jobs/jobs/locales/fr.lua',





}