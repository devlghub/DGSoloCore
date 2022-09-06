-- For support join my discord: https://discord.gg/Z9Mxu72zZ6

local display = false
local nearModel = false

local atmModels = {
    "-870868698",  -- older atms
    "-1126237515",  -- blue atm
    "-1364697528",  -- red atm
    "506770882"  -- green atm
}

local days = {
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
}

-- Get the time
function getTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours <= 9 then
        hours = "0" .. hours
    end
    if minutes <= 9 then
        minutes = "0" .. minutes
    end
    return hours .. ":" .. minutes
end

-- Hide/Show ui
function SetDisplay(bool)
    local playerInfo = exports["Money_Script"]:getMoney()
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type='atm-ui'
        status = bool,
		playerName = GetPlayerName(PlayerId()),
		balance = "Account Balance: $" .. playerInfo.bank .. ".00",
        date = days[GetClockDayOfWeek() + 1],
        time = getTime()
    })
end

function drawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z + 1)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x, _y)
end

-- check if ped is close to an atm object.
function inRange(ped)
    playerCoords = GetEntityCoords(ped)
    for _, atm in pairs(atmModels) do
        object, outPosition, outRotation = GetCoordsAndRotationOfClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, 0.7, tonumber(atm), 0)
        if object == 1 then
            return true
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        ped = PlayerPedId()
        nearModel = inRange(ped)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not display and nearModel then
            drawText3D(outPosition, "~w~Press ~r~E ~w~to use the ATM")
            if IsControlJustPressed(0, 51) then
                SetDisplay(true)
                TriggerScreenblurFadeIn(1000)
            end
        end
    end
end)