players = {}

function tablefind(tab, el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end

    return nil
end

function countBots()
    local count = 0

    for index, value in pairs(players) do
        local isBot = game:isbot(value)
        if isBot == 1 then
            count = count + 1
        end
    end

    return count
end

function removePlayer(player)
    local index = tablefind(players, player)
    if index ~= nil then
        table.remove(players, index)
    end
end

function kickPlayer(player)
    local clientNum = player:getentitynumber()
    game:kickplayer(clientNum)
end

function kickLeftoverBot(player)
    local timer =
        game:ontimeout(
        function()
            kickPlayer(player)
        end,
        10000
    )
    local timer2 =
        player:onnotifyonce(
        "spawned_player",
        function()
            timer:clear()
        end
    )
    player:onnotifyonce(
        "disconnect",
        function()
            timer2:clear()
        end
    )
end

function player_connected(player)
    player:onnotifyonce(
        "disconnect",
        function()
            removePlayer(player)
        end
    )
    table.insert(players, player)

    local isBot = game:isbot(player)
    if isBot == 1 then
        player:botsetdifficulty("default")
        kickLeftoverBot(player)
    end
end

function kickBot()
    for index, player in pairs(players) do
        local isBot = game:isbot(player)
        if isBot == 1 then
            kickPlayer(player)
            break
        end
    end
end

function spawnBot()
    game:executecommand("spawnbot 1")
end

function monitor()
    local count = #players
    local botCount = countBots()
    if count < 10 and botCount < 5 then
        spawnBot()
    elseif count > 14 and botCount > 0 then
        kickBot()
    end
end

function startLogic()
    game:oninterval(monitor, 3000)
end

if game:getdvar("gamemode") == "mp" then
    game:executecommand("spawnbot 4")
    level:onnotifyonce("matchStartTimer", startLogic)
    level:onnotify("connected", player_connected)
end
