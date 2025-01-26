local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
    if not list[source] then
        list[source] = true
        playerCount = playerCount + 1
        GlobalState.playerCount = playerCount
    end
end)

AddEventHandler('playerDropped', function()
    if list[source] then
        list[source] = nil
        playerCount = playerCount - 1
        GlobalState.playerCount = playerCount
    end
end)

AddEventHandler('playerConnecting', function(name, setReason)
    local cv = GetConvarInt('sv_maxclients', 32) -- Max player count from server config

    print('Connecting: ' .. name .. '^7')

    if playerCount >= cv then
        print('Server is full.')

        setReason('This server is full (maximum ' .. tostring(cv) .. ' players).')
        CancelEvent() -- Cancel the player's connection
    end
end)
