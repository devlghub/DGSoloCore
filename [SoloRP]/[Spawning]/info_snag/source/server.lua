AddEventHandler('playerConnecting', function(name, setKickReason, defferals)

    -- Vars setting for the main function
    local source = source
    local identifiers = GetPlayerIdentifiers(source)
    local steamid
    local license
    local cashStartValue = 250
    local bankStartValue = 10000

    -- Definition of vars as user identifiers
    for k,v in ipairs(identifiers) do
        if string.match(v, 'steam') then
            steamid = v
            print('steamid grabbed: ', v)
        elseif string.match(v, 'license:') then
            license = v
            print('license grabbed: ', v)
        end
    end

    -- Check if user has steamID
    if not steamid then
        defferals.done('Please open steam before you play on the server')
    else
        defferals.done()
        print('steamid is being fetched')
        MySQL.scalar('SELECT 1 FROM user_identifiers WHERE steamid = @steamid',{
            ["@steamid"] = steamid
        }, function(result)
            if not result then
                print('New user found. Inserting identifier')
                MySQL.insert('INSERT INTO user_identifiers (steamid, license) VALUES (@steamid, @license)',
                {["@steamid"] = steamid, ["@license"] = license})
                MySQL.insert('INSERT INTO user_currency (steamid, cash, bank) VALUES (@steamid,@cashBalance, @bankBalance)',
                {["@steamid"] = steamid,["@cashBalance"] = cashStartValue, ["@bankBalance"] = bankStartValue})
                print('Identifier inserted into [DB].')
            else
                print('steamid found')
            end
        end)
    end
end)


AddEventHandler('playerDropped', function (reason)
    print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')

end)