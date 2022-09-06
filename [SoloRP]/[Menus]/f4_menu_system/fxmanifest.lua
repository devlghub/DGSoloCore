-- Resource Metadata
fx_version 'cerulean'
game 'gta5'

author 'DarthGaijin'
description 'Prompt user with F4 Menu'
version '1.0.0'

-- What to run
server_script "source/server.lua"
client_script "source/client.lua"

-- NUI Files
ui_page 'ui/ui.html'

files {
    'ui/ui.html',
    'ui/css/style.css',
    'ui/fonts/KumbhSans-Regular.ttf',
    'ui/js/*',
    'ui/img/*'
}