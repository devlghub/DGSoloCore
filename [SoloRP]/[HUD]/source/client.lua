CreateThread(function()
    while true do
        Wait(250)
        local playerID      = PlayerPedId()
        local playerHealth  = GetEntityHealth(playerID)
        local playerArmor  = GetPedArmour(playerID)
        local playerStamina = GetPlayerStamina(PlayerId())
        local playerOxygen = GetPlayerUnderwaterTimeRemaining(PlayerId())

        SendNUIMessage({
            type    = 'circleData',
            hp      = playerHealth,
            ap      = playerArmor,
            stamina = playerStamina,
            oxygen  = playerOxygen,
        })
    end
end)

function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


RegisterCommand("ids", function()
    Citizen.CreateThread(function()
        local startTimer = GetGameTimer()
        while GetGameTimer() < (startTimer + 5000) do
            Wait(0)
            local plyCoords = GetEntityCoords(PlayerPedId(source))
            for _, id in ipairs(GetActivePlayers()) do
                Draw3DText(plyCoords.x, plyCoords.y, plyCoords.z+1.15, 1, '[ '..GetPlayerServerId(id)..' ]')
            end
        end
    end)
end)