-- Resource Metadata
fx_version 'cerulean'
game 'gta5'

author 'DarthGaijin'
description 'Start to getting user to writing some script for GTA FiveM'
version '1.0.0'

-- What to run
client_scripts {
    'source/client.lua'
}

server_script 'source/server.lua'

-- NUI Files
ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/css/style.css',
    'html/fonts/KumbhSans-Regular.ttf',
    'html/js/*',
    'html/img/*'
}