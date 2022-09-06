-- NUI Callbacks
RegisterNUICallback('releaseFocus', function(data, cb)
    cb({})
    SetNuiFocus(false,false)
end)


-- Key binding.
RegisterCommand('+openf4menu', function()
    SetDisplay(true)
end)
RegisterKeyMapping('+openf4menu', 'Opens the f1 menu', 'keyboard', 'F4')



function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type="ui",
        status=bool
    })
end