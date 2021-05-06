function on_spawn(player)
	player:setperk("specialty_empimmune", false, false)
end

function player_connected(player)
	local timer =
		player:onnotify(
		"spawned_player",
		function()
			on_spawn(player)
		end
	)
	player:onnotifyonce(
		"disconnect",
		function()
			timer:clear()
		end
	)
end

if game:getdvar("gamemode") == "mp" then
	level:onnotify("connected", player_connected)
end
