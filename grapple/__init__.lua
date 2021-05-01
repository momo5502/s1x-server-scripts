function watch_exo_ability(player, weapon)
    if game:getdvarint("scr_game_infinite_grappling") ~= 1 then
        return
    end
    
    if weapon == "iw5_dlcgun12loot7_mp" then
        player:giveweapon("iw5_dlcgun12loot7_mp")
    end
end

function player_connected(player)
    local timer = player:onnotify("exo_ability_activate", function(weapon)watch_exo_ability(player, weapon) end)
    player:onnotifyonce("disconnect", function()timer:clear() end)
end

if game:getdvar("gamemode") == "mp" then
    game:setdvarifuninitialized("scr_game_infinite_grappling", 0)
    game:setdvar("scr_game_grappling_hook", "1")
    
    level:onnotify("connected", player_connected)
end
