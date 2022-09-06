-- Resource Metadata
fx_version 'cerulean'
game 'gta5'

author 'DarthGaijin'
description 'Start to getting user to writing some script for GTA FiveM'
version '1.0.0'

client_script "source/client.lua"
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "source/server.lua"
}

dependency "oxmysql"