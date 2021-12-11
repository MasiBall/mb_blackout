fx_version 'cerulean'
games { 'gta5' }

author 'MasiBall'
description 'Simple blackout resource'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/cl_bo.lua'
}

server_scripts {
    'server/sv_bo.lua'
}