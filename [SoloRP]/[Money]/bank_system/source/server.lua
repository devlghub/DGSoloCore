RegisterCommand("balance", function(source,args)
    local steamid = GetPlayerIdentifiers(source)[1]

    MySQL.scalar('SELECT cash FROM user_currency WHERE steamid = @steamid',{
        ["@steamid"] = steamid
    }, function(result)
        TriggerClientEvent("chat:addMessage", source, {
            args = {
                "Sith Bank",
                result
            },
            color = { 5, 255, 255 }
        })
    end)
end)

RegisterCommand("addcash", function(source,args)
    local steamid = GetPlayerIdentifiers(source)[1]
    local cashUpdate = 1000
    MySQL.update('UPDATE user_currency SET cash = cash + ? WHERE steamid = ?', {cashUpdate, steamid}, function(affectedRows)
    end)
end)





-- Function Scripable --

-- Send Cash from one client to another
function clientSendCash()
    RegisterCommand("sendcash", function(source,args)
        local steamid = GetPlayerIdentifiers(source)[1]
        local cashUpdate = 1000
        MySQL.update('UPDATE user_currency SET cash = cash + ? WHERE steamid = ?', {cashUpdate, steamid}, function(affectedRows)
        end)
    end)
end

-- Send Cash from one client to another --
function clientSendCash(amount, player, target)
    MySQL.scalar('SELECT cash FROM user_currency WHERE steamid = @steamid',{
        ["@steamid"] = steamid
    }, function(result)
        local playerCurrentCash = result
    end)

    local amount = tonumber(amount)
    local player = tonumber(player)
    local target = tonumber(target)

    if player == target then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You can't send money to yourself."}
        })
        return false
    elseif GetPlayerPing(target) == 0 then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "That player does not exist."}
        })
        return false
    elseif amount <= 0 then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You can't send that amount."}
        })
        return false
    elseif playerCurrentCash < amount then
        TriggerClientEvent("chat:addMessage", player, {
            color = {255, 0, 0},
            args = {"Error", "You don't have enough money."}
        })
        return false
    else
        MySQL.update('UPDATE user_currency SET cash = cash - ? WHERE steamid = ?', {amount, player})
        MySQL.update('UPDATE user_currency SET cash = cash + ? WHERE steamid = ?', {amount, target})
        print("success")
        TriggerClientEvent("chat:addMessage", player, {
            color = {0, 255, 0},
            args = {"Success", "You paid " .. GetPlayerName(target) .. " $" .. amount .. "."}
        })
        TriggerClientEvent("chat:addMessage", target, {
            color = {0, 255, 0},
            args = {"Success", GetPlayerName(player) .. " sent you $" .. amount .. "."}
        })
        return true
    end
end

